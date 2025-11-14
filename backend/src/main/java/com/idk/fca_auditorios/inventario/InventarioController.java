package com.idk.fca_auditorios.inventario;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.postgresql.util.PGobject;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.sql.Array;
import java.util.*;

@RestController
@RequestMapping("/api/inventario")
public class InventarioController {

  private final JdbcTemplate jdbc;
  private final ObjectMapper objectMapper;

  public InventarioController(JdbcTemplate jdbc, ObjectMapper objectMapper) {
    this.jdbc = jdbc;
    this.objectMapper = objectMapper;
  }
  
  /** Consolida existencias totales por equipamiento y desglose (área/recinto). */
  @GetMapping("/general")
  @PreAuthorize("hasRole('ADMINISTRADOR')")
  public List<Map<String, Object>> getInventarioGeneral() {
    String sql = """
      WITH inv_tot AS (
        SELECT id_equipamiento, SUM(cantidad) AS total
        FROM (
          SELECT id_equipamiento, cantidad
          FROM inventario_area
          WHERE coalesce(activo,true) = true
          UNION ALL
          SELECT id_equipamiento, cantidad
          FROM inventario_recinto
          WHERE coalesce(activo,true) = true
        ) t
        GROUP BY id_equipamiento
      )
      SELECT e.id_equipamiento as id,
             e.nombre,
             e.existencia,
             coalesce(it.total,0) as total,
             ARRAY(
               SELECT json_build_object('area', a.nombre, 'cantidad', ia.cantidad)
               FROM inventario_area ia
               JOIN area a ON a.id_area = ia.id_area
               WHERE ia.id_equipamiento = e.id_equipamiento
                 AND coalesce(ia.activo,true) = true
               ORDER BY a.nombre
             ) as porArea,
             ARRAY(
               SELECT json_build_object('recinto', r.nombre, 'cantidad', ir.cantidad)
               FROM inventario_recinto ir
               JOIN recinto r ON r.id_recinto = ir.id_recinto
               WHERE ir.id_equipamiento = e.id_equipamiento
                 AND coalesce(ir.activo,true) = true
               ORDER BY r.nombre
             ) as porRecinto
      FROM equipamiento e
      LEFT JOIN inv_tot it ON it.id_equipamiento = e.id_equipamiento
      ORDER BY e.nombre
      """;

    return jdbc.query(sql, (rs, rowNum) -> {
      Map<String, Object> row = new LinkedHashMap<>();
      row.put("id", rs.getLong("id"));
      row.put("nombre", rs.getString("nombre"));
      row.put("existencia", rs.getBoolean("existencia"));
      row.put("total", rs.getInt("total"));

      row.put("porArea",  parseJsonArrayColumn(rs.getArray("porArea")));
      row.put("porRecinto", parseJsonArrayColumn(rs.getArray("porRecinto")));

      return row;
    });
  }

  /**
   * Convierte una columna de tipo json[] de Postgres a List<Map<String,Object>>.
   * Ejemplo de cada elemento: {"area":"Coordinación X","cantidad":3}
   */
  private List<Map<String, Object>> parseJsonArrayColumn(Array sqlArray) {
    if (sqlArray == null) return List.of();
    try {
      Object[] arr = (Object[]) sqlArray.getArray();
      List<Map<String, Object>> list = new ArrayList<>();

      for (Object o : arr) {
        String json;
        if (o instanceof PGobject pg) {
          // Para columnas json/jsonb el driver usualmente retorna PGobject
          json = pg.getValue();
        } else {
          // Fallback: tomamos el toString()
          json = String.valueOf(o);
        }

        // Cada elemento es un objeto con { "area"/"recinto", "cantidad" }
        Map<String, Object> elem = objectMapper.readValue(
            json,
            new TypeReference<Map<String, Object>>() {}
        );
        list.add(elem);
      }

      return list;
    } catch (Exception e) {
      throw new RuntimeException("Error al leer columna de tipo json[]", e);
    }
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
