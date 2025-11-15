package com.idk.fca_auditorios.ponente;

import com.idk.fca_auditorios.pdf.PdfService;
import com.idk.fca_auditorios.storage.LocalStorageService;
import jakarta.validation.constraints.NotBlank;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.nio.file.Path;
import java.util.*;

@RestController
@RequestMapping("/api/ponentes")
public class PonenteController {

  private final PonenteRepository repo;
  private final JdbcTemplate jdbc;
  private final PdfService pdf;
  private final LocalStorageService storage;

  public PonenteController(PonenteRepository repo, JdbcTemplate jdbc, PdfService pdf,
                         LocalStorageService storage) {
    this.repo = repo; this.jdbc = jdbc; this.pdf = pdf; this.storage = storage;
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

  @PostMapping("/{id}/descargar-semblanza")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public ResponseEntity<Resource> descargarSemblanzaIndividual(@PathVariable Long id) throws Exception {
    // 1) Intentar recuperar la ruta de semblanza ya generada
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

    // 2) Si no existe registro o el archivo ya no está en disco, lo generamos
    if (archivo == null || !java.nio.file.Files.exists(java.nio.file.Paths.get(archivo))) {
      String fileName = buildSemblanzaFileName(id);
      pdfPath = pdf.generarSemblanza(id, fileName);

      jdbc.update("""
          INSERT INTO semblanza(id_ponente, archivo)
          VALUES (?,?)
          ON CONFLICT (id_ponente) DO UPDATE SET archivo = EXCLUDED.archivo
          """, id, pdfPath.toString());
    } else {
      pdfPath = java.nio.file.Paths.get(archivo);
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


  // Convierte texto a snake_case, minúsculas y sin acentos
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

  /**
   * Genera el nombre de archivo de la semblanza:
   *   nombre_apellido_paterno_apellido_materno.pdf
   * en snake_case y minúsculas.
   */
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

    // <nombre>_<apellido_paterno>_<apellido_materno>.pdf en snake_case
    return toSnakeCase(base) + ".pdf";
  }

  @GetMapping("/search")
  public List<Map<String, Object>> search(@RequestParam String q) {

      String like = "%" + q.toLowerCase() + "%";

      return jdbc.queryForList("""
          SELECT p.id_ponente,
                p.nombre,
                p.apellido_paterno,
                p.apellido_materno,
                pa.nombre AS pais
          FROM ponente p
          JOIN pais pa ON pa.id_pais = p.id_pais
          WHERE LOWER(p.nombre) LIKE ?
            OR LOWER(p.apellido_paterno) LIKE ?
            OR LOWER(p.apellido_materno) LIKE ?
          ORDER BY p.nombre
      """, like, like, like);
  }

  @GetMapping("/{id}")
  public Map<String, Object> get(@PathVariable Integer id) {
    Map<String, Object> ponente = jdbc.queryForMap("""
        SELECT p.id_ponente,
              p.nombre,
              p.apellido_paterno,
              p.apellido_materno,
              p.id_pais,
              pa.nombre AS pais
          FROM ponente p
          JOIN pais pa ON pa.id_pais = p.id_pais
        WHERE p.id_ponente = ?
    """, id);

    List<Map<String, Object>> semblanzas = jdbc.queryForList("""
        SELECT id_semblanza, biografia
        FROM semblanza
        WHERE id_ponente = ?
    """, id);

    List<Map<String, Object>> reconocimientos = jdbc.queryForList("""
        SELECT r.*, sxr.id_semblanza
        FROM semblanzaxreconocimiento sxr
        JOIN reconocimiento r ON r.id_reconocimiento = sxr.id_reconocimiento
        JOIN semblanza s ON s.id_semblanza = sxr.id_semblanza
        WHERE s.id_ponente = ?
        ORDER BY r.anio DESC
    """, id);


    List<Map<String, Object>> experiencia = jdbc.queryForList("""
        SELECT e.*, sxe.id_semblanza, emp.nombre AS empresa
        FROM semblanzaxexperiencia sxe
        JOIN experiencia e ON e.id_experiencia = sxe.id_experiencia
        JOIN semblanza s ON s.id_semblanza = sxe.id_semblanza
        LEFT JOIN empresa emp ON emp.id_empresa = e.id_empresa
        WHERE s.id_ponente = ?
        ORDER BY e.fecha_inicio DESC
    """, id);

    List<Map<String, Object>> grados = jdbc.queryForList("""
        SELECT g.*, sxg.id_semblanza, i.nombre AS institucion
        FROM semblanzaxgrado sxg
        JOIN grado g ON g.id_grado = sxg.id_grado
        JOIN semblanza s ON s.id_semblanza = sxg.id_semblanza
        LEFT JOIN institucion i ON i.id_institucion = g.id_institucion
        WHERE s.id_ponente = ?
        ORDER BY g.id_grado DESC
    """, id);

      return Map.of(
              "ponente", ponente,
              "semblanza", semblanzas,
              "reconocimientos", reconocimientos,
              "experiencia", experiencia,
              "grados", grados
      );
  }

  @GetMapping("/{id}/reconocimientos")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public List<Map<String, Object>> listarReconocimientosPorPonente(@PathVariable Long id) {
    return jdbc.queryForList("""
        SELECT
          e.id_evento   AS "idEvento",
          e.nombre      AS "nombreEvento",
          pa.reconocimiento
        FROM participacion pa
        JOIN evento e ON e.id_evento = pa.id_evento
        WHERE pa.id_ponente = ?
        ORDER BY e.fecha_inicio DESC, e.nombre
        """, id);
  }

}
