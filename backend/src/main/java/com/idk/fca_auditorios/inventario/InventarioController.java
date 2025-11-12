package com.idk.fca_auditorios.inventario;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/inventario")
public class InventarioController {

  private final JdbcTemplate jdbc;

  public InventarioController(JdbcTemplate jdbc) { this.jdbc = jdbc; }

  /** Consolida existencias totales por equipamiento y desglose (área/recinto). */
  @GetMapping("/general")
  public List<Map<String,Object>> general() {
    return jdbc.queryForList("""
      WITH inv_tot AS (
        SELECT id_equipamiento, SUM(cantidad) AS total
        FROM (
          SELECT id_equipamiento, cantidad FROM inventario_area WHERE coalesce(activo,true)=true
          UNION ALL
          SELECT id_equipamiento, cantidad FROM inventario_recinto WHERE coalesce(activo,true)=true
        ) t GROUP BY id_equipamiento
      )
      SELECT e.id_equipamiento as id, e.nombre, e.existencia,
             coalesce(it.total,0) as total,
             -- desglose
             ARRAY(
               SELECT json_build_object('area', a.nombre, 'cantidad', ia.cantidad)
               FROM inventario_area ia
               JOIN area a ON a.id_area=ia.id_area
               WHERE ia.id_equipamiento=e.id_equipamiento AND coalesce(ia.activo,true)=true
               ORDER BY a.nombre
             ) as porArea,
             ARRAY(
               SELECT json_build_object('recinto', r.nombre, 'cantidad', ir.cantidad)
               FROM inventario_recinto ir
               JOIN recinto r ON r.id_recinto=ir.id_recinto
               WHERE ir.id_equipamiento=e.id_equipamiento AND coalesce(ir.activo,true)=true
               ORDER BY r.nombre
             ) as porRecinto
      FROM equipamiento e
      LEFT JOIN inv_tot it ON it.id_equipamiento = e.id_equipamiento
      ORDER BY e.nombre
    """);
  }

  @GetMapping("/area")
  public List<Map<String,Object>> porArea() {
    return jdbc.queryForList("""
      SELECT a.nombre as area, e.nombre as equipamiento, ia.cantidad, ia.activo
      FROM inventario_area ia
      JOIN area a ON a.id_area=ia.id_area
      JOIN equipamiento e ON e.id_equipamiento=ia.id_equipamiento
      ORDER BY a.nombre, e.nombre
    """);
  }

  @GetMapping("/recinto")
  public List<Map<String,Object>> porRecinto() {
    return jdbc.queryForList("""
      SELECT r.nombre as recinto, e.nombre as equipamiento, ir.cantidad, ir.activo
      FROM inventario_recinto ir
      JOIN recinto r ON r.id_recinto=ir.id_recinto
      JOIN equipamiento e ON e.id_equipamiento=ir.id_equipamiento
      ORDER BY r.nombre, e.nombre
    """);
  }

  /** Alta simple de equipamiento + al menos un registro en inventario (área o recinto). */
  @PostMapping("/equipamiento")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public Map<String,Object> crearEquipamiento(@RequestBody Map<String,Object> body) {
    String nombre = String.valueOf(body.get("nombre"));
    Boolean existencia = (body.get("existencia") == null)
        ? Boolean.TRUE
        : Boolean.valueOf(String.valueOf(body.get("existencia")));
    if (nombre == null || nombre.isBlank()) throw new IllegalArgumentException("nombre requerido");

    Long id = jdbc.queryForObject(
        "INSERT INTO equipamiento(nombre, existencia) VALUES (?,?) RETURNING id_equipamiento",
        Long.class, nombre, existencia
    );

    int inserts = 0;

    // ✅ Sin unchecked cast
    List<?> areasRaw = (List<?>) body.getOrDefault("areas", List.of());
    for (Object aObj : areasRaw) {
      Map<?,?> a = (Map<?,?>) aObj;
      Long idArea = Long.parseLong(String.valueOf(a.get("idArea")));
      Integer cantidad = Integer.parseInt(String.valueOf(a.get("cantidad")));
      inserts += jdbc.update(
          "INSERT INTO inventario_area(id_area, id_equipamiento, cantidad, activo) VALUES (?,?,?,true)",
          idArea, id, cantidad
      );
    }

    // ✅ Sin unchecked cast
    List<?> recintosRaw = (List<?>) body.getOrDefault("recintos", List.of());
    for (Object rObj : recintosRaw) {
      Map<?,?> r = (Map<?,?>) rObj;
      Long idRecinto = Long.parseLong(String.valueOf(r.get("idRecinto")));
      Integer cantidad = Integer.parseInt(String.valueOf(r.get("cantidad")));
      inserts += jdbc.update(
          "INSERT INTO inventario_recinto(id_recinto, id_equipamiento, cantidad, activo) VALUES (?,?,?,true)",
          idRecinto, id, cantidad
      );
    }

    if (inserts == 0) throw new IllegalArgumentException("Debe registrar al menos un inventario de área o de recinto");
    return Map.of("idEquipamiento", id, "registrosInventario", inserts);
  }

}
