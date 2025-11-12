package com.idk.fca_auditorios.recinto;

import com.idk.fca_auditorios.storage.LocalStorageService;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.*;
import java.util.*;

@RestController
@RequestMapping("/api/recintos")
public class RecintoController {
  private final RecintoRepository repo;
  private final JdbcTemplate jdbc;
  private final LocalStorageService storage;

  public RecintoController(RecintoRepository repo, JdbcTemplate jdbc, LocalStorageService storage) {
    this.repo = repo; this.jdbc = jdbc; this.storage = storage;
    this.storage.ensureDirs(); // ✅ ahora 'storage' se usa
  }


  @GetMapping
  public List<Map<String,Object>> gallery() {
    return jdbc.queryForList("""
      SELECT r.id_recinto as id, r.nombre, r.capacidad, r.ubicacion, r.croquis, r.activo,
             (SELECT f.ruta FROM fotografia f WHERE f.id_recinto=r.id_recinto AND coalesce(f.portada,false)=true
              ORDER BY f.id_fotografia ASC LIMIT 1) as portada,
             ARRAY(SELECT f2.ruta FROM fotografia f2 WHERE f2.id_recinto=r.id_recinto ORDER BY f2.id_fotografia) as fotos
      FROM recinto r
      WHERE coalesce(r.activo,true)=true
      ORDER BY r.nombre
    """);
  }

  @PostMapping
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String,Object> crear(@RequestBody Recinto body) {
    Recinto r = repo.save(body);
    return Map.of("id", r.getId());
  }

  @PostMapping(value="/{id}/fotos", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String,Object> subirFotos(@PathVariable Long id,
                                       @RequestParam("files") List<MultipartFile> files,
                                       @RequestParam(name="portadaIndex", required=false) Integer portadaIndex) throws Exception {
    Path base = Paths.get(System.getProperty("user.dir")).resolve("src/main/resources/uploads/recinto/fotografias/");
    Files.createDirectories(base);
    int i = 0;
    for (MultipartFile file : files) {
      String filename = id + "_" + System.nanoTime() + "_" + file.getOriginalFilename();
      Path out = base.resolve(filename);
      Files.copy(file.getInputStream(), out, StandardCopyOption.REPLACE_EXISTING);
      boolean isPortada = (portadaIndex != null && portadaIndex == i);
      jdbc.update("INSERT INTO fotografia(id_recinto, ruta, portada) VALUES (?,?,?)", id, out.toString(), isPortada);
      i++;
    }
    return Map.of("ok", true, "subidas", files.size());
  }

  @PatchMapping("/{id}")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String,Object> editar(@PathVariable Long id, @RequestBody Map<String,Object> body) {
    Recinto r = repo.findById(id).orElseThrow();
    if (body.containsKey("nombre")) r.setNombre(String.valueOf(body.get("nombre")));
    if (body.containsKey("capacidad")) r.setCapacidad(Integer.valueOf(String.valueOf(body.get("capacidad"))));
    if (body.containsKey("ubicacion")) r.setUbicacion(String.valueOf(body.get("ubicacion")));
    if (body.containsKey("croquis")) r.setCroquis(String.valueOf(body.get("croquis")));
    if (body.containsKey("activo")) r.setActivo(Boolean.valueOf(String.valueOf(body.get("activo"))));
    repo.save(r);
    return Map.of("ok", true);
  }

  @DeleteMapping("/{id}")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String,Object> eliminar(@PathVariable Long id) {
    Recinto r = repo.findById(id).orElseThrow();
    r.setActivo(false); // baja lógica
    repo.save(r);
    return Map.of("ok", true);
  }

}
