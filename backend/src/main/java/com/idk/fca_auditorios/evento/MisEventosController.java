package com.idk.fca_auditorios.evento;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Endpoints para "Mis eventos" de los funcionarios.
 *
 * - GET /api/mis-eventos
 *   Lista de eventos donde el usuario autenticado tiene relación (organizador o según reglas).
 *
 * - GET /api/mis-eventos/{id}/detalle
 *   Detalle de un evento, SOLO si el usuario aparece en una reservación del evento.
 */
@RestController
@RequestMapping("/api/mis-eventos")
public class MisEventosController {

  private final JdbcTemplate jdbc;

  public MisEventosController(JdbcTemplate jdbc) {
    this.jdbc = jdbc;
  }

  @GetMapping
  @PreAuthorize("hasRole('FUNCIONARIO')")
  public List<Map<String, Object>> listMisEventos(Authentication authentication) {
    String username = authentication.getName();

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
          rc.nombre               AS recinto

        FROM evento e
        JOIN reservacion r
          ON r.id_evento = e.id_evento
        LEFT JOIN recinto rc
          ON rc.id_recinto = r.id_recinto
        LEFT JOIN categoria c
          ON c.id_categoria = e.id_categoria
        LEFT JOIN calendario_escolar ce
          ON ce.id_calendario_escolar = e.id_calendario_escolar
        LEFT JOIN evento me
          ON me.id_evento = e.id_mega_evento
        WHERE
          -- Regla de "mis eventos": el usuario autenticado aparece como organizador del evento
          EXISTS (
            SELECT 1
            FROM evento_organizador eo
            JOIN usuario u ON u.id_usuario = eo.id_usuario
            WHERE eo.id_evento = e.id_evento
              AND u.nombre_usuario = ?
          )
        ORDER BY e.fecha_inicio DESC, e.horario_inicio
        """;

    return jdbc.queryForList(sql, username);

  }

  /**
   * Detalle de un evento para "Mis eventos".
   *
   * Solo devuelve información si el evento:
   *  - existe, y
   *  - está asociado a una reservación donde aparece el usuario autenticado (id_usuario).
   *
   * Shape de respuesta:
   * {
   *   "evento": { ...campos del evento... },
   *   "ponentes": [ { id, nombreCompleto }, ... ],
   *   "organizadores": [ { id, nombreCompleto }, ... ],
   *   "areas": [ { area }, ... ],
   *   "equipamiento": [ { equipamiento, cantidad, disponible, cantidadFaltante }, ... ]
   * }
   */
  @GetMapping("/{id}/detalle")
  @PreAuthorize("hasRole('FUNCIONARIO')")
  public Map<String, Object> detalleMisEvento(
      @PathVariable("id") Long id,
      Authentication authentication
  ) {
    String username = authentication.getName();

    // 1) Obtener el evento solo si el usuario aparece en alguna reservación del evento
    String sqlEvento = """
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
          rc.nombre               AS recinto

        FROM evento e
        JOIN reservacion r
          ON r.id_evento = e.id_evento
        LEFT JOIN recinto rc
          ON rc.id_recinto = r.id_recinto
        LEFT JOIN categoria c
          ON c.id_categoria = e.id_categoria
        LEFT JOIN calendario_escolar ce
          ON ce.id_calendario_escolar = e.id_calendario_escolar
        LEFT JOIN evento me
          ON me.id_evento = e.id_mega_evento
        WHERE
          e.id_evento = ?
          AND EXISTS (
            SELECT 1
            FROM evento_organizador eo
            JOIN usuario u ON u.id_usuario = eo.id_usuario
            WHERE eo.id_evento = e.id_evento
              AND u.nombre_usuario = ?
          )
        """;

    List<Map<String, Object>> eventos = jdbc.queryForList(sqlEvento, id, username);

    if (eventos.isEmpty()) {
      // No existe el evento o el usuario no tiene permiso -> 404 lógico
      throw new org.springframework.web.server.ResponseStatusException(
          org.springframework.http.HttpStatus.NOT_FOUND,
          "Evento no encontrado o no autorizado"
      );
    }
    Map<String, Object> evento = eventos.get(0);

    // 2) Ponentes del evento
    String sqlPonentes = """
        SELECT
          p.id_ponente AS id,
          (p.nombre || ' ' || p.apellido_paterno || ' ' || COALESCE(p.apellido_materno, '')) AS "nombreCompleto"
        FROM participacion pa
        JOIN ponente p ON p.id_ponente = pa.id_ponente
        WHERE pa.id_evento = ?
        ORDER BY p.nombre, p.apellido_paterno, p.apellido_materno
        """;
    List<Map<String, Object>> ponentes = jdbc.queryForList(sqlPonentes, id);

    // 3) Organizadores del evento
    String sqlOrganizadores = """
        SELECT
          u.id_usuario AS id,
          (u.nombre || ' ' || u.apellido_paterno || ' ' || COALESCE(u.apellido_materno, '')) AS "nombreCompleto"
        FROM evento_organizador eo
        JOIN usuario u ON u.id_usuario = eo.id_usuario
        WHERE eo.id_evento = ?
        ORDER BY u.nombre, u.apellido_paterno, u.apellido_materno
        """;
    List<Map<String, Object>> organizadores = jdbc.queryForList(sqlOrganizadores, id);

    // 4) Áreas involucradas (distintas)
    String sqlAreas = """
        SELECT DISTINCT
          a.nombre AS area
        FROM evento_organizador eo
        JOIN usuario u ON u.id_usuario = eo.id_usuario
        JOIN puesto  p ON p.id_puesto = u.id_puesto
        JOIN area    a ON a.id_area = p.id_area
        WHERE eo.id_evento = ?
        ORDER BY a.nombre
        """;
    List<Map<String, Object>> areas = jdbc.queryForList(sqlAreas, id);

    // 5) Equipamiento solicitado
    //    Nota: aquí se devuelve disponible=true y cantidadFaltante=0;
    //    si quieres replicar EXACTAMENTE la lógica de inventario del trigger,
    //    se puede extender esta consulta con los mismos CTE de verificación.
    String sqlEquipamiento = """
        SELECT
          eq.nombre AS equipamiento,
          ex.cantidad AS cantidad,
          TRUE  AS disponible,
          0     AS "cantidadFaltante"
        FROM eventoxequipamiento ex
        JOIN equipamiento eq ON eq.id_equipamiento = ex.id_equipamiento
        WHERE ex.id_evento = ?
        ORDER BY eq.nombre
        """;
    List<Map<String, Object>> equipamiento = jdbc.queryForList(sqlEquipamiento, id);

    // 6) Armar la respuesta con el shape que espera EventDetailSheet.tsx
    Map<String, Object> response = new HashMap<>();
    response.put("evento", evento);
    response.put("ponentes", ponentes);
    response.put("organizadores", organizadores);
    response.put("areas", areas);
    response.put("equipamiento", equipamiento);

    return response;
  }
}
