package com.idk.fca_auditorios.auditoria;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Solo consulta la tabla auditoria. Los triggers llenan la tabla al modificar
 * usuario, inventario_area e inventario_recinto. :contentReference[oaicite:4]{index=4}
 */
@RestController
@RequestMapping("/api/auditoria")
public class AuditoriaController {
  private final JdbcTemplate jdbc;

  public AuditoriaController(JdbcTemplate jdbc) { this.jdbc = jdbc; }

  @GetMapping
  @PreAuthorize("hasRole('superadministrador')")
  public List<Map<String, Object>> list() {
    return jdbc.queryForList("""
      select a.nombre_tabla, a.id_registro_afectado, a.accion, a.campo_modificado,
             a.valor_anterior, a.valor_nuevo, a.fecha_hora, a.id_usuario, a.id_puesto
        from auditoria a
        order by a.fecha_hora desc
      """);
  }
}
