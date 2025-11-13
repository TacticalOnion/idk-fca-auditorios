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
  public List<Map<String, Object>> list() {
    String sql = """
        SELECT
          e.id_evento       AS id,
          e.nombre          AS nombre,
          e.descripcion     AS descripcion,
          e.estatus         AS estatus,
          e.fecha_inicio    AS "fechaInicio",
          e.fecha_fin       AS "fechaFin",
          e.horario_inicio  AS "horarioInicio",
          e.horario_fin     AS "horarioFin",
          e.presencial      AS presencial,
          e.online          AS online,
          e.fecha_registro  AS "fechaRegistro",
          r.numero_registro AS "numeroRegistro",

          -- categoría
          e.id_categoria          AS "idCategoria",
          c.nombre                AS categoria,

          -- mega evento
          e.mega_evento           AS "megaEvento",
          e.id_mega_evento        AS "idMegaEvento",
          me.nombre               AS "nombreMegaEvento",
          CASE WHEN e.mega_evento IS TRUE
              THEN '[Mega Evento]'
              ELSE NULL
          END                     AS "isMegaEvento",

          -- calendario escolar
          e.id_calendario_escolar AS "idCalendarioEscolar",
          ce.semestre             AS "calendarioEscolar",

          -- recinto principal (de la reservación)
          rc.nombre               AS recinto,

          -- ponentes
          (
            SELECT jsonb_agg(
                    jsonb_build_object(
                      'nombreCompleto',
                        p.nombre || ' ' || p.apellido_paterno || ' ' || COALESCE(p.apellido_materno,''),
                      'semblanza',
                        s.archivo,
                      'reconocimiento',
                        pa.reconocimiento
                    )
                  )
            FROM participacion pa
            JOIN ponente p ON p.id_ponente = pa.id_ponente
            LEFT JOIN semblanza s ON s.id_ponente = p.id_ponente
            WHERE pa.id_evento = e.id_evento
          ) AS ponentes,

          -- organizadores
          (
            SELECT jsonb_agg(
                    jsonb_build_object(
                      'nombreCompleto',
                        u.nombre || ' ' || u.apellido_paterno || ' ' || COALESCE(u.apellido_materno,'')
                    )
                  )
            FROM evento_organizador eo
            JOIN usuario u ON u.id_usuario = eo.id_usuario
            WHERE eo.id_evento = e.id_evento
          ) AS organizadores,

          -- áreas
          (
            SELECT jsonb_agg(
                    jsonb_build_object(
                      'area', sub.nombre
                    )
                  )
            FROM (
              SELECT DISTINCT a.nombre
              FROM evento_organizador eo
              JOIN usuario u ON u.id_usuario = eo.id_usuario
              JOIN puesto  p2 ON p2.id_puesto = u.id_puesto
              JOIN area   a  ON a.id_area = p2.id_area
              WHERE eo.id_evento = e.id_evento
            ) AS sub
          ) AS areas,

          -- equipamiento
          (
            SELECT jsonb_agg(
                    jsonb_build_object(
                      'equipamiento', eq.nombre,
                      'cantidad',    ex.cantidad
                    )
                  )
            FROM eventoxequipamiento ex
            JOIN equipamiento eq ON eq.id_equipamiento = ex.id_equipamiento
            WHERE ex.id_evento = e.id_evento
          ) AS equipamiento

        FROM evento e
        LEFT JOIN reservacion r
          ON r.id_evento = e.id_evento
        LEFT JOIN recinto rc
          ON rc.id_recinto = r.id_recinto
        LEFT JOIN categoria c
          ON c.id_categoria = e.id_categoria
        LEFT JOIN calendario_escolar ce
          ON ce.id_calendario_escolar = e.id_calendario_escolar
        LEFT JOIN evento me
          ON me.id_evento = e.id_mega_evento
        ORDER BY e.fecha_inicio DESC, e.horario_inicio
        """;

    return jdbc.queryForList(sql);
  }

  @GetMapping("/{id}/verificar-equipamiento")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public List<java.util.Map<String,Object>> verificar(@PathVariable Long id) {
    return service.verificarEquipamiento(id);
  }

  @PostMapping("/{id}/autorizar")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Evento autorizar(@PathVariable Long id) {
    return service.autorizar(id);
  }

  @PostMapping("/{id}/cancelar")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Evento cancelar(@PathVariable Long id, @RequestParam String motivo) {
    return service.cancelar(id, motivo);
  }

  @PostMapping("/{id}/deshacer")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
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

  private String toSnakeCase(String input) {
    if (input == null) return "";
    String normalized = java.text.Normalizer.normalize(input, java.text.Normalizer.Form.NFD);
    normalized = normalized.replaceAll("\\p{M}", "");
    String snake = normalized.replaceAll("[^a-zA-Z0-9]+", "_");
    snake = snake.replaceAll("_+", "_");
    snake = snake.replaceAll("^_+", "").replaceAll("_+$", "");
    return snake.toLowerCase();
  }

  private String buildReconocimientoFileName(Long idEvento, Long idPonente) {
    String eventoNombre = jdbc.queryForObject(
        "SELECT nombre FROM evento WHERE id_evento=?",
        String.class,
        idEvento
    );

    Map<String,Object> datos = jdbc.queryForMap(
        "SELECT nombre, apellido_paterno, apellido_materno FROM ponente WHERE id_ponente = ?",
        idPonente
    );
    String nombre = (String) datos.get("nombre");
    String apP = (String) datos.get("apellido_paterno");
    String apM = (String) datos.get("apellido_materno");

    String basePonente = nombre
        + (apP != null && !apP.isBlank() ? "_" + apP : "")
        + (apM != null && !apM.isBlank() ? "_" + apM : "");

    String eventoSnake = toSnakeCase(eventoNombre);
    String ponenteSnake = toSnakeCase(basePonente);

    // <nombre del evento>.<nombre>_<apellido_paterno>_<apellido_materno>.pdf
    return eventoSnake + "." + ponenteSnake + ".pdf";
  }


  @PostMapping("/{id}/descargar-reconocimientos")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public ResponseEntity<Resource> descargarReconocimientos(@PathVariable Long id) throws Exception {
    List<Long> ponentes = repoPonentesDelEvento(id);
    if (ponentes.isEmpty()) {
      return ResponseEntity.noContent().build();
    }
    List<java.nio.file.Path> archivos = new ArrayList<>();
    for (Long idPonente : ponentes) {
      String nombrePdf = buildReconocimientoFileName(id, idPonente);
      archivos.add(pdfService.generarReconocimiento(idPonente, id, nombrePdf));
    }
    Resource zip = zipService.zip("reconocimientos_evento_" + id + ".zip", archivos);
    return ResponseEntity.ok()
        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + zip.getFilename())
        .contentType(MediaType.APPLICATION_OCTET_STREAM)
        .body(zip);
  }

  private String buildSemblanzaFileName(Long idPonente) {
    Map<String, Object> datos = jdbc.queryForMap(
        "SELECT nombre, apellido_paterno, apellido_materno FROM ponente WHERE id_ponente = ?",
        idPonente
    );

    String nombre = (String) datos.get("nombre");
    String apP = (String) datos.get("apellido_paterno");
    String apM = (String) datos.get("apellido_materno");

    String base = nombre
        + (apP != null && !apP.isBlank() ? "_" + apP : "")
        + (apM != null && !apM.isBlank() ? "_" + apM : "");

    // Regla: <nombre>_<apellido_paterno>_<apellido_materno>.pdf en snake_case
    return toSnakeCase(base) + ".pdf";
  }

  @PostMapping("/{id}/descargar-semblanzas")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public ResponseEntity<Resource> descargarSemblanzas(@PathVariable Long id) throws Exception {
    // Reutilizamos la misma consulta de ponentes del evento
    List<Long> ponentes = repoPonentesDelEvento(id);
    if (ponentes.isEmpty()) {
      return ResponseEntity.noContent().build();
    }

    List<java.nio.file.Path> archivos = new ArrayList<>();
    for (Long idPonente : ponentes) {
      String nombrePdf = buildSemblanzaFileName(idPonente);
      archivos.add(pdfService.generarSemblanza(idPonente, nombrePdf));
    }

    Resource zip = zipService.zip("semblanzas_evento_" + id + ".zip", archivos);
    return ResponseEntity.ok()
        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + zip.getFilename())
        .contentType(MediaType.APPLICATION_OCTET_STREAM)
        .body(zip);
  }


  @PostMapping("")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
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
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String, Object> detalle(@PathVariable Long id) {
    // ── 1) Datos principales del evento (evento.nombre, categoria, megaEvento, etc.)
    Map<String, Object> evento = jdbc.queryForMap("""
        SELECT
          e.id_evento       AS id,
          e.nombre          AS nombre,
          e.descripcion     AS descripcion,
          e.estatus         AS estatus,
          e.motivo          AS motivo,
          e.fecha_inicio    AS "fechaInicio",
          e.fecha_fin       AS "fechaFin",
          e.horario_inicio  AS "horarioInicio",
          e.horario_fin     AS "horarioFin",
          e.presencial      AS presencial,
          e.online          AS online,
          e.fecha_registro  AS "fechaRegistro",
          r.numero_registro AS "numeroRegistro",

          -- categoría: nombre
          e.id_categoria          AS "idCategoria",
          c.nombre                AS categoria,

          -- mega evento (bandera + nombre del mega evento + etiqueta 'Mega Evento')
          e.mega_evento           AS "megaEvento",
          e.id_mega_evento        AS "idMegaEvento",
          me.nombre               AS "nombreMegaEvento",
          CASE WHEN e.mega_evento IS TRUE
              THEN 'Mega Evento'
              ELSE NULL
          END                     AS "isMegaEvento",

          -- calendario escolar (semestre)
          e.id_calendario_escolar AS "idCalendarioEscolar",
          ce.semestre             AS "calendarioEscolar",

          -- recinto principal (reservación)
          rc.nombre               AS recinto

        FROM evento e
        LEFT JOIN reservacion r
          ON r.id_evento = e.id_evento
        LEFT JOIN recinto rc
          ON rc.id_recinto = r.id_recinto
        LEFT JOIN categoria c
          ON c.id_categoria = e.id_categoria
        LEFT JOIN calendario_escolar ce
          ON ce.id_calendario_escolar = e.id_calendario_escolar
        LEFT JOIN evento me
          ON me.id_evento = e.id_mega_evento
        WHERE e.id_evento = ?
        """, id);

    // ── 2) Ponentes: nombre completo, semblanza, reconocimiento
    List<Map<String, Object>> ponentes = jdbc.queryForList("""
        SELECT
          p.id_ponente AS id,
          p.nombre || ' ' || p.apellido_paterno || ' ' || COALESCE(p.apellido_materno, '') AS "nombreCompleto",
          s.archivo AS semblanza,
          pa.reconocimiento
        FROM participacion pa
        JOIN ponente p ON p.id_ponente = pa.id_ponente
        LEFT JOIN semblanza s ON s.id_ponente = p.id_ponente
        WHERE pa.id_evento = ?
        ORDER BY p.nombre, p.apellido_paterno, p.apellido_materno
        """, id);


    // ── 3) Organizadores: solo nombreCompleto
    List<Map<String, Object>> organizadores = jdbc.queryForList("""
        SELECT
          u.id_usuario AS id,
          u.nombre || ' ' || u.apellido_paterno || ' ' || COALESCE(u.apellido_materno, '') AS "nombreCompleto"
        FROM evento_organizador eo
        JOIN usuario u ON u.id_usuario = eo.id_usuario
        WHERE eo.id_evento = ?
        ORDER BY u.nombre, u.apellido_paterno, u.apellido_materno
        """, id);

    // ── 4) Áreas involucradas: DISTINCT por organizadores
    List<Map<String, Object>> areas = jdbc.queryForList("""
        SELECT DISTINCT
          a.id_area AS id,
          a.nombre  AS area
        FROM evento_organizador eo
        JOIN usuario u ON u.id_usuario = eo.id_usuario
        JOIN puesto  p2 ON p2.id_puesto = u.id_puesto
        JOIN area    a  ON a.id_area   = p2.id_area
        WHERE eo.id_evento = ?
        ORDER BY a.nombre
        """, id);

    // ── 5) Equipamiento: nombre, cantidad, disponible (true/false), cantidadFaltante
    List<Map<String, Object>> equipamiento = jdbc.queryForList("""
        WITH disp AS (
          SELECT e.id_equipamiento,
                COALESCE((SELECT SUM(cantidad)
                          FROM inventario_area ia
                          WHERE ia.id_equipamiento = e.id_equipamiento
                            AND COALESCE(ia.activo, true) = true), 0) +
                COALESCE((SELECT SUM(cantidad)
                          FROM inventario_recinto ir
                          WHERE ir.id_equipamiento = e.id_equipamiento
                            AND COALESCE(ir.activo, true) = true), 0) AS disponible
          FROM equipamiento e
        )
        SELECT
          ex.id_equipamiento AS id,
          eq.nombre          AS equipamiento,
          ex.cantidad        AS cantidad,
          CASE
            WHEN GREATEST(ex.cantidad - COALESCE(d.disponible, 0), 0) = 0
              THEN TRUE
            ELSE FALSE
          END                AS disponible,
          GREATEST(ex.cantidad - COALESCE(d.disponible, 0), 0) AS cantidadFaltante
        FROM eventoxequipamiento ex
        JOIN equipamiento eq ON eq.id_equipamiento = ex.id_equipamiento
        LEFT JOIN disp d ON d.id_equipamiento = ex.id_equipamiento
        WHERE ex.id_evento = ?
        ORDER BY eq.nombre
        """, id);

    return Map.of(
        "evento", evento,
        "ponentes", ponentes,
        "organizadores", organizadores,
        "areas", areas,
        "equipamiento", equipamiento
    );
  }

  @PostMapping("/{id}/descargar-semblanza")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public ResponseEntity<Resource> descargarSemblanzaIndividual(@PathVariable Long id) throws Exception {
    // 1) Intentar recuperar la ruta del archivo ya generado
    Map<String, Object> s;
    try {
      s = jdbc.queryForMap(
          "SELECT archivo FROM semblanza WHERE id_ponente=? LIMIT 1",
          id
      );
    } catch (org.springframework.dao.EmptyResultDataAccessException ex) {
      s = null;
    }

    String archivo = (s != null && s.get("archivo") != null)
        ? String.valueOf(s.get("archivo"))
        : null;

    java.nio.file.Path pdfPath;

    // 2) Si ya existe y el archivo está en disco, lo reutilizamos
    if (archivo != null && java.nio.file.Files.exists(java.nio.file.Paths.get(archivo))) {
      pdfPath = java.nio.file.Paths.get(archivo);
    } else {
      // 3) Si no existe o el archivo se perdió, lo generamos de nuevo
      String fileName = buildSemblanzaFileName(id);
      pdfPath = pdfService.generarSemblanza(id, fileName);

      // upsert a la tabla semblanza
      jdbc.update("""
          INSERT INTO semblanza(id_ponente, archivo)
          VALUES (?,?)
          ON CONFLICT (id_ponente) DO UPDATE SET archivo = EXCLUDED.archivo
        """, id, pdfPath.toString());
    }

    Resource resource = new org.springframework.core.io.FileSystemResource(pdfPath);
    if (!resource.exists()) {
      return ResponseEntity.notFound().build();
    }

    return ResponseEntity.ok()
        .header(HttpHeaders.CONTENT_DISPOSITION,
            "attachment; filename=" + pdfPath.getFileName().toString())
        .contentType(MediaType.APPLICATION_PDF)
        .body(resource);
  }

  @PostMapping("/{idEvento}/ponentes/{idPonente}/descargar-reconocimiento")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public ResponseEntity<Resource> descargarReconocimientoIndividual(
      @PathVariable("idEvento") Long idEvento,
      @PathVariable("idPonente") Long idPonente
  ) throws Exception {

    // Generamos el nombre de archivo igual que en el ZIP
    String nombrePdf = buildReconocimientoFileName(idEvento, idPonente);

    java.nio.file.Path pdfPath = pdfService.generarReconocimiento(idPonente, idEvento, nombrePdf);

    Resource resource = new org.springframework.core.io.FileSystemResource(pdfPath);
    if (!resource.exists()) {
      return ResponseEntity.notFound().build();
    }

    return ResponseEntity.ok()
        .header(HttpHeaders.CONTENT_DISPOSITION,
            "attachment; filename=" + pdfPath.getFileName().toString())
        .contentType(MediaType.APPLICATION_PDF)
        .body(resource);
  }

}
