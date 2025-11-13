package com.idk.fca_auditorios.ponente;

import com.idk.fca_auditorios.pdf.PdfService;
import com.idk.fca_auditorios.storage.LocalStorageService;
import jakarta.validation.constraints.NotBlank;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import com.idk.fca_auditorios.common.ZipService;

import java.nio.file.Path;
import java.util.*;

@RestController
@RequestMapping("/api/ponentes")
public class PonenteController {

  private final PonenteRepository repo;
  private final JdbcTemplate jdbc;
  private final PdfService pdf;
  private final LocalStorageService storage;
  private final ZipService zipService;

  public PonenteController(PonenteRepository repo, JdbcTemplate jdbc, PdfService pdf,
                         LocalStorageService storage, ZipService zipService) {
    this.repo = repo; this.jdbc = jdbc; this.pdf = pdf; this.storage = storage; this.zipService = zipService;
    this.storage.ensureDirs(); // ✅ ahora 'storage' se usa
  }


  @GetMapping
  public List<Map<String,Object>> list(@RequestParam(required = false) String q,
                                       @RequestParam(required = false) Long idPais) {
    if (q != null && !q.isBlank()) {
      var out = new ArrayList<Map<String,Object>>();
      for (var p : repo.findByNombreContainingIgnoreCaseOrApellidoPaternoContainingIgnoreCase(q, q)) {
        out.add(mapPonente(p));
      }
      return out;
    }
    if (idPais != null) {
      return jdbc.queryForList("""
        SELECT p.id_ponente as id, p.nombre, p.apellido_paterno, p.apellido_materno, p.id_pais,
               s.archivo as semblanzaArchivo
        FROM ponente p
        LEFT JOIN semblanza s ON s.id_ponente = p.id_ponente
        WHERE p.id_pais = ?
        ORDER BY p.nombre
      """, idPais);
    }
    return jdbc.queryForList("""
      SELECT p.id_ponente as id, p.nombre, p.apellido_paterno, p.apellido_materno, p.id_pais,
             s.archivo as semblanzaArchivo
      FROM ponente p
      LEFT JOIN semblanza s ON s.id_ponente = p.id_ponente
      ORDER BY p.nombre
    """);
  }

  private Map<String,Object> mapPonente(Ponente p) {
    var m = new LinkedHashMap<String,Object>();
    m.put("id", p.getId());
    m.put("nombre", p.getNombre());
    m.put("apellidoPaterno", p.getApellidoPaterno());
    m.put("apellidoMaterno", p.getApellidoMaterno());
    m.put("idPais", p.getIdPais());
    // Obtener semblanza (si existe)
    List<Map<String,Object>> s = jdbc.queryForList("SELECT archivo FROM semblanza WHERE id_ponente=?", p.getId());
    m.put("semblanzaArchivo", s.isEmpty() ? null : s.get(0).get("archivo"));
    return m;
  }

  @PostMapping("/{id}/generar-semblanza")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String, Object> generarSemblanza(@PathVariable Long id,
                                              @RequestParam @NotBlank String nombreArchivoPdf) throws Exception {
    // Ignoramos nombreArchivoPdf y usamos nuestro formato estándar
    String fileName = buildSemblanzaFileName(id);

    Path pdfPath = pdf.generarSemblanza(id, fileName);

    // upsert a la tabla semblanza
    int updated = jdbc.update("""
      INSERT INTO semblanza(id_ponente, archivo)
      VALUES (?,?)
      ON CONFLICT (id_ponente) DO UPDATE SET archivo = EXCLUDED.archivo
    """, id, pdfPath.toString());

    return Map.of("ok", true, "archivo", pdfPath.toString(), "updated", updated > 0);
  }

  @PostMapping("/descargar-semblanzas")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public ResponseEntity<Resource> descargarSemblanzas(@RequestBody Map<String,Object> body) throws Exception {
      List<?> idsRaw = (List<?>) body.getOrDefault("ids", List.of());
  List<Integer> ids = new java.util.ArrayList<>();
  for (Object o : idsRaw) {
    ids.add(Integer.valueOf(String.valueOf(o)));
  }
  if (ids.isEmpty()) return ResponseEntity.status(400).build();

  if (ids.isEmpty()) return ResponseEntity.status(400).build();
  
  List<java.nio.file.Path> archivos = new ArrayList<>();
  for (Integer idPonente : ids) {
    Map<String,Object> s = jdbc.queryForMap(
        "SELECT archivo FROM semblanza WHERE id_ponente=? LIMIT 1",
        idPonente
    );
    String archivo = (s != null && s.get("archivo") != null)
        ? String.valueOf(s.get("archivo"))
        : null;

    if (archivo == null || !java.nio.file.Files.exists(java.nio.file.Paths.get(archivo))) {
      // Usamos el nombre estándar en snake_case
      String nombrePdf = buildSemblanzaFileName(idPonente.longValue());
      java.nio.file.Path pdfPath = pdf.generarSemblanza(idPonente.longValue(), nombrePdf);
      archivos.add(pdfPath);

      jdbc.update("""
          INSERT INTO semblanza(id_ponente, archivo) VALUES (?,?)
          ON CONFLICT (id_ponente) DO UPDATE SET archivo=EXCLUDED.archivo
      """, idPonente, pdfPath.toString());
    } else {
      archivos.add(java.nio.file.Paths.get(archivo));
    }
  }

  Resource zip = zipService.zip("semblanzas.zip", archivos);
  return ResponseEntity.ok()
      .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + zip.getFilename())
      .contentType(MediaType.APPLICATION_OCTET_STREAM)
      .body(zip);
  }

  private String toSnakeCase(String input) {
    if (input == null) return "";
    String normalized = java.text.Normalizer.normalize(input, java.text.Normalizer.Form.NFD);
    // quitar acentos
    normalized = normalized.replaceAll("\\p{M}", "");
    // reemplazar cualquier cosa que no sea letra o número por guion bajo
    String snake = normalized.replaceAll("[^a-zA-Z0-9]+", "_");
    // colapsar múltiples guiones bajos
    snake = snake.replaceAll("_+", "_");
    // quitar guiones bajos al inicio o final
    snake = snake.replaceAll("^_+", "").replaceAll("_+$", "");
    return snake.toLowerCase();
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

}
