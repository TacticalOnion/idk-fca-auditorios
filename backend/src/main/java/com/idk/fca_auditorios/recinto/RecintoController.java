package com.idk.fca_auditorios.recinto;

import com.idk.fca_auditorios.storage.LocalStorageService;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.*;
import java.util.*;

@RestController
@RequestMapping("/api/recintos")
public class RecintoController {

  private final RecintoRepository repo;
  private final JdbcTemplate jdbc;
  private final LocalStorageService storage;

  public RecintoController(RecintoRepository repo, JdbcTemplate jdbc, LocalStorageService storage) {
    this.repo = repo;
    this.jdbc = jdbc;
    this.storage = storage;
  }

  // DTOs para la galería
  public record FotografiaDto(Long id, String fotografia) {
  }

  public record RecintoGalleryDto(
      Long id,
      String nombre,
      Integer aforo,
      BigDecimal latitud,
      BigDecimal longitud,
      String croquis,
      Short idTipoRecinto,
      String tipoRecinto,
      List<FotografiaDto> fotografias
  ) {
  }

  public record TipoRecintoDto(Long id, String nombre) {
  }

  /**
   * Lista todos los recintos para la GalleryView
   */
  @GetMapping
  @PreAuthorize("hasAnyRole('ADMINISTRADOR', 'FUNCIONARIO','SUPERADMINISTRADOR')")
  public List<RecintoGalleryDto> listar() {
    String sql = """
        SELECT r.id_recinto,
               r.nombre,
               r.aforo,
               r.latitud,
               r.longitud,
               r.croquis,
               r.id_tipo_recinto,
               tr.nombre AS tipo_recinto,
               f.id_fotografia,
               f.fotografia
        FROM recinto r
        JOIN tipo_recinto tr ON tr.id_tipo_recinto = r.id_tipo_recinto
        LEFT JOIN fotografia f ON f.id_recinto = r.id_recinto
        WHERE r.activo = TRUE
        ORDER BY r.nombre, f.id_fotografia
        """;

    Map<Long, RecintoGalleryDto> map = new LinkedHashMap<>();

    jdbc.query(sql, rs -> {
      Long id = rs.getLong("id_recinto");
      RecintoGalleryDto dto = map.get(id);
      if (dto == null) {
        dto = new RecintoGalleryDto(
            id,
            rs.getString("nombre"),
            rs.getInt("aforo"),
            rs.getBigDecimal("latitud"),
            rs.getBigDecimal("longitud"),
            rs.getString("croquis"),
            rs.getShort("id_tipo_recinto"),
            rs.getString("tipo_recinto"),
            new ArrayList<>()
        );
        map.put(id, dto);
      }

      Long idFoto = rs.getLong("id_fotografia");
      if (!rs.wasNull()) {
        String fotografia = rs.getString("fotografia");
        dto.fotografias().add(new FotografiaDto(idFoto, fotografia));
      }
    });

    return new ArrayList<>(map.values());
  }

  /**
   * Catálogo de tipos de recinto
   */
  @GetMapping("/tipos")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public List<TipoRecintoDto> tiposRecinto() {
    String sql = "SELECT id_tipo_recinto AS id, nombre FROM tipo_recinto ORDER BY nombre";
    return jdbc.query(sql, (rs, rowNum) ->
        new TipoRecintoDto(
            rs.getLong("id"),
            rs.getString("nombre")
        )
    );
  }

  /**
   * Crear recinto + croquis + fotografías
   * Reglas:
   *  - Debe haber al menos 4 fotografías
   */
  @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String, Object> crear(
      @RequestPart("nombre") String nombre,
      @RequestPart("latitud") BigDecimal latitud,
      @RequestPart("longitud") BigDecimal longitud,
      @RequestPart("aforo") Integer aforo,
      @RequestPart("idTipoRecinto") Short idTipoRecinto,
      @RequestPart("croquis") MultipartFile croquis,
      @RequestPart("fotografias") MultipartFile[] fotografias
  ) throws IOException {

    if (fotografias == null || fotografias.length < 4) {
      throw new IllegalArgumentException("Debe subir al menos 4 fotografías del recinto");
    }
    if (croquis == null || croquis.isEmpty()) {
      throw new IllegalArgumentException("El croquis es obligatorio");
    }

    storage.ensureDirs();

    // Guardar croquis
    String croquisFileName = UUID.randomUUID() + "_" + Objects.requireNonNull(croquis.getOriginalFilename());
    Path croquisPath = storage.resolveCroquis(croquisFileName);
    Files.copy(croquis.getInputStream(), croquisPath, StandardCopyOption.REPLACE_EXISTING);
    String croquisRuta = "/recinto/croquis/" + croquisFileName;

    // Crear registro de recinto
    Recinto r = new Recinto();
    r.setNombre(nombre);
    r.setLatitud(latitud);
    r.setLongitud(longitud);
    r.setAforo(aforo);
    r.setCroquis(croquisRuta);
    r.setIdTipoRecinto(idTipoRecinto);
    r.setActivo(true);

    r = repo.save(r);
    Long idRecinto = r.getId();

    // Guardar fotografías
    for (MultipartFile f : fotografias) {
      if (f == null || f.isEmpty()) continue;
      String fileName = UUID.randomUUID() + "_" + Objects.requireNonNull(f.getOriginalFilename());
      Path fotoPath = storage.resolveFotografia(fileName);
      Files.copy(f.getInputStream(), fotoPath, StandardCopyOption.REPLACE_EXISTING);
      String rutaFoto = "/recinto/fotografias/" + fileName;
      jdbc.update("INSERT INTO fotografia (fotografia, id_recinto) VALUES (?, ?)", rutaFoto, idRecinto);
    }

    return Map.of("ok", true, "id", r.getId());
  }

  /**
   * Agregar fotografías a un recinto existente
   */
  @PostMapping(value = "/{id}/fotos", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String, Object> agregarFotos(
      @PathVariable Long id,
      @RequestPart("files") MultipartFile[] files,
      @RequestPart(value = "portadaIndex", required = false) String portadaIndexIgnored
  ) throws IOException {

    Recinto r = repo.findById(id).orElseThrow();
    storage.ensureDirs();

    if (files == null || files.length == 0) {
      throw new IllegalArgumentException("Debe subir al menos una fotografía");
    }

    for (MultipartFile f : files) {
      if (f == null || f.isEmpty()) continue;
      String fileName = UUID.randomUUID() + "_" + Objects.requireNonNull(f.getOriginalFilename());
      Path fotoPath = storage.resolveFotografia(fileName);
      Files.copy(f.getInputStream(), fotoPath, StandardCopyOption.REPLACE_EXISTING);
      String rutaFoto = "/recinto/fotografias/" + fileName;
      jdbc.update("INSERT INTO fotografia (fotografia, id_recinto) VALUES (?, ?)", rutaFoto, r.getId());
    }

    return Map.of("ok", true);
  }

  /**
   * Actualizar datos básicos del recinto
   * (nombre, aforo, latitud, longitud, idTipoRecinto)
   */
  @PatchMapping("/{id}")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String, Object> actualizar(@PathVariable Long id, @RequestBody Map<String, Object> body) {
    Recinto r = repo.findById(id).orElseThrow();

    if (body.containsKey("nombre")) {
      r.setNombre((String) body.get("nombre"));
    }
    if (body.containsKey("aforo")) {
      Object v = body.get("aforo");
      r.setAforo(v == null ? null : Integer.parseInt(v.toString()));
    }
    if (body.containsKey("latitud")) {
      Object v = body.get("latitud");
      r.setLatitud(v == null ? null : new BigDecimal(v.toString()));
    }
    if (body.containsKey("longitud")) {
      Object v = body.get("longitud");
      r.setLongitud(v == null ? null : new BigDecimal(v.toString()));
    }
    if (body.containsKey("idTipoRecinto")) {
      Object v = body.get("idTipoRecinto");
      r.setIdTipoRecinto(v == null ? null : Short.parseShort(v.toString()));
    }

    repo.save(r);
    return Map.of("ok", true);
  }

  /**
   * Baja lógica del recinto
   */
  @DeleteMapping("/{id}")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String, Object> eliminar(@PathVariable Long id) {
    Recinto r = repo.findById(id).orElseThrow();
    r.setActivo(false);
    repo.save(r);
    return Map.of("ok", true);
  }
}
