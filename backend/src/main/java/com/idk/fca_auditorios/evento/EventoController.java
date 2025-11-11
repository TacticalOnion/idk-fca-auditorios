package com.idk.fca_auditorios.evento;

import com.idk.fca_auditorios.common.ZipService;
import com.idk.fca_auditorios.pdf.PdfService;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import com.idk.fca_auditorios.evento.dto.EventoCreateRequest;
import jakarta.validation.Valid;
import java.util.Map;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/eventos")
public class EventoController {
  private final EventoRepository repo;
  private final EventoService service;
  private final JdbcTemplate jdbc;
  private final PdfService pdfService;
  private final ZipService zipService;

  public EventoController(EventoRepository repo, EventoService service,
                          JdbcTemplate jdbc, PdfService pdfService, ZipService zipService) {
    this.repo = repo; this.service = service;
    this.jdbc = jdbc; this.pdfService = pdfService; this.zipService = zipService;
  }

  @GetMapping
  public List<Evento> list() { return repo.findAll(); }

  @GetMapping("/{id}/verificar-equipamiento")
  @PreAuthorize("hasRole('administrador')")
  public List<java.util.Map<String,Object>> verificar(@PathVariable Long id) {
    return service.verificarEquipamiento(id);
  }

  @PostMapping("/{id}/autorizar")
  @PreAuthorize("hasRole('administrador')")
  public Evento autorizar(@PathVariable Long id) {
    return service.autorizar(id);
  }

  @PostMapping("/{id}/cancelar")
  @PreAuthorize("hasRole('administrador')")
  public Evento cancelar(@PathVariable Long id, @RequestParam String motivo) {
    return service.cancelar(id, motivo);
  }

  @PostMapping("/{id}/deshacer")
  @PreAuthorize("hasRole('administrador')")
  public Evento deshacer(@PathVariable Long id) {
    return service.deshacer(id);
  }

  /** Obtiene los IDs de ponentes asociados al evento (ajusta el SQL si tu tabla difiere). */
  private List<Long> repoPonentesDelEvento(Long idEvento) {
    return jdbc.queryForList("""
        SELECT DISTINCT p.id_ponente
        FROM participacion pa
        JOIN ponente p ON p.id_ponente = pa.id_ponente
        WHERE pa.id_evento = ?
      """, Long.class, idEvento);
  }

  @PostMapping("/{id}/descargar-reconocimientos")
  @PreAuthorize("hasRole('administrador')")
  public ResponseEntity<Resource> descargarReconocimientos(@PathVariable Long id) throws Exception {
    List<Long> ponentes = repoPonentesDelEvento(id);
    if (ponentes.isEmpty()) {
      return ResponseEntity.noContent().build();
    }
    List<java.nio.file.Path> archivos = new ArrayList<>();
    for (Long idPonente : ponentes) {
      String nombrePdf = "reconocimiento_evento_" + id + "_ponente_" + idPonente + ".pdf";
      archivos.add(pdfService.generarReconocimiento(idPonente, id, nombrePdf));
    }
    Resource zip = zipService.zip("reconocimientos_evento_" + id + ".zip", archivos);
    return ResponseEntity.ok()
        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + zip.getFilename())
        .contentType(MediaType.APPLICATION_OCTET_STREAM)
        .body(zip);
  }

  @PostMapping("")
  @PreAuthorize("hasRole('administrador')")
  public Evento crear(@Valid @RequestBody EventoCreateRequest body) {
    Evento e = new Evento();
    e.setNombre(body.nombre());
    e.setDescripcion(body.descripcion());
    e.setFechaInicio(java.time.LocalDate.parse(body.fechaInicio()));
    e.setFechaFin(java.time.LocalDate.parse(body.fechaFin()));
    e.setHorarioInicio(java.time.LocalTime.parse(body.horarioInicio()));
    e.setHorarioFin(java.time.LocalTime.parse(body.horarioFin()));
    e.setPresencial(Boolean.TRUE.equals(body.presencial()));
    e.setOnline(Boolean.TRUE.equals(body.online()));
    e.setEstatus("pendiente");
    return repo.save(e);
  }

  @GetMapping("/{id}/detalle")
  @PreAuthorize("hasRole('administrador')")
  public Map<String,Object> detalle(@PathVariable Long id) {
    Map<String,Object> evento = jdbc.queryForMap("""
      SELECT e.id_evento as id, e.nombre, e.descripcion, e.estatus, e.motivo,
            e.fecha_inicio as fechaInicio, e.fecha_fin as fechaFin,
            e.horario_inicio as horarioInicio, e.horario_fin as horarioFin,
            e.presencial, e.online, e.id_categoria as idCategoria, e.id_calendario_escolar as idCalendarioEscolar
      FROM evento e WHERE e.id_evento = ?
    """, id);

    List<Map<String,Object>> organizadores = jdbc.queryForList("""
      SELECT u.id_usuario as id, u.nombre_usuario as username, u.nombre, u.apellido_paterno as apellidoPaterno,
            u.apellido_materno as apellidoMaterno, u.correo
      FROM evento_organizador eo
      JOIN usuario u ON u.id_usuario = eo.id_usuario
      WHERE eo.id_evento = ?
      ORDER BY u.nombre
    """, id);

    List<Map<String,Object>> recintos = jdbc.queryForList("""
      SELECT r.id_recinto as id, r.nombre, r.aforo, r.croquis
      FROM reservacion rv
      JOIN recinto r ON r.id_recinto = rv.id_recinto
      WHERE rv.id_evento = ?
      ORDER BY r.nombre
    """, id);

    List<Map<String,Object>> equipamiento = jdbc.queryForList("""
      WITH disp AS (
        SELECT e.id_equipamiento,
              COALESCE((SELECT SUM(cantidad) FROM inventario_area   ia WHERE ia.id_equipamiento=e.id_equipamiento AND COALESCE(ia.activo,true)=true),0) +
              COALESCE((SELECT SUM(cantidad) FROM inventario_recinto ir WHERE ir.id_equipamiento=e.id_equipamiento AND COALESCE(ir.activo,true)=true),0) AS disponible
        FROM equipamiento e
      )
      SELECT ex.id_equipamiento as id, eq.nombre, ex.cantidad as solicitado,
            COALESCE(d.disponible,0) as disponible,
            GREATEST(ex.cantidad - COALESCE(d.disponible,0),0) as faltante
      FROM eventoxequipamiento ex
      JOIN equipamiento eq ON eq.id_equipamiento = ex.id_equipamiento
      LEFT JOIN disp d ON d.id_equipamiento = ex.id_equipamiento
      WHERE ex.id_evento = ?
      ORDER BY eq.nombre
    """, id);

    // ⭐ ÁREAS INVOLUCRADAS: evento_organizador -> usuario -> puesto -> area (DISTINCT)
    List<Map<String,Object>> areas = jdbc.queryForList("""
      SELECT DISTINCT a.id_area AS id, a.nombre
      FROM evento_organizador eo
      JOIN usuario u ON u.id_usuario = eo.id_usuario
      JOIN puesto  p ON p.id_puesto  = u.id_puesto
      JOIN area    a ON a.id_area    = p.id_area
      WHERE eo.id_evento = ?
      ORDER BY a.nombre
    """, id);

    return Map.of(
        "evento", evento,
        "organizadores", organizadores,
        "recintos", recintos,
        "equipamiento", equipamiento,
        "areas", areas
    );
  }


}
