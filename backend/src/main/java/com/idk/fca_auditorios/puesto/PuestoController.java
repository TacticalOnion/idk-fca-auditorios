package com.idk.fca_auditorios.puesto;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/puestos")
public class PuestoController {
  private final JdbcTemplate jdbc;

  public PuestoController(JdbcTemplate jdbc) { this.jdbc = jdbc; }

  @GetMapping
  @PreAuthorize("hasAnyRole('administrador','superadministrador')")
  public List<Map<String,Object>> search(
      @RequestParam(required = false) String q,
      @RequestParam(required = false) Long idArea
  ) {
    String sql = """
      SELECT p.id_puesto AS id, p.nombre, p.id_area, a.nombre AS area
      FROM puesto p
      JOIN area a ON a.id_area = p.id_area
      WHERE (? IS NULL OR LOWER(p.nombre) LIKE LOWER(CONCAT('%',?,'%')))
        AND (? IS NULL OR p.id_area = ?)
      ORDER BY a.nombre, p.nombre
    """;
    return jdbc.queryForList(sql, q, q, idArea, idArea);
  }
}
