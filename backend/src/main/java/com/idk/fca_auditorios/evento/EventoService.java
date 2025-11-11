package com.idk.fca_auditorios.evento;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class EventoService {
  private final EventoRepository repo;
  private final JdbcTemplate jdbc;

  public EventoService(EventoRepository repo, JdbcTemplate jdbc) {
    this.repo = repo; this.jdbc = jdbc;
  }

  public List<Map<String,Object>> verificarEquipamiento(Long idEvento) {
    String sql = """
      WITH target AS (
        SELECT
          e.id_evento,
          tsrange(
            e.fecha_inicio + e.horario_inicio,
            e.fecha_fin     + e.horario_fin,
            '[)'
          ) AS t_range
        FROM public.evento e
        WHERE e.id_evento = ?
      ),
      inventario AS (
        SELECT i.id_equipamiento, SUM(i.cantidad) AS stock_total
        FROM (
          SELECT ia.id_equipamiento, ia.cantidad
          FROM public.inventario_area ia
          WHERE ia.activo = TRUE
          UNION ALL
          SELECT ir.id_equipamiento, ir.cantidad
          FROM public.inventario_recinto ir
          WHERE ir.activo = TRUE
        ) i
        GROUP BY i.id_equipamiento
      ),
      solicitado AS (
        SELECT ex.id_equipamiento, ex.cantidad AS solicitado_evento
        FROM public.eventoxequipamiento ex
        WHERE ex.id_evento = ?
      ),
      reservado_traslape AS (
        SELECT ex.id_equipamiento, SUM(ex.cantidad) AS reservado_solapado
        FROM public.eventoxequipamiento ex
        JOIN public.evento e ON e.id_evento = ex.id_evento
        CROSS JOIN target t
        WHERE e.estatus = 'autorizado'
          AND e.id_evento <> t.id_evento
          AND tsrange(e.fecha_inicio + e.horario_inicio, e.fecha_fin + e.horario_fin, '[)') && t.t_range
        GROUP BY ex.id_equipamiento
      ),
      consolidado AS (
        SELECT
          COALESCE(i.id_equipamiento, s.id_equipamiento, r.id_equipamiento) AS id_equipamiento,
          COALESCE(i.stock_total, 0)         AS stock_total,
          COALESCE(r.reservado_solapado, 0)  AS reservado_solapado,
          COALESCE(s.solicitado_evento, 0)   AS solicitado_evento
        FROM inventario i
        FULL JOIN solicitado s ON s.id_equipamiento = i.id_equipamiento
        FULL JOIN reservado_traslape r
               ON r.id_equipamiento = COALESCE(i.id_equipamiento, s.id_equipamiento)
      )
      SELECT
        c.id_equipamiento,
        e.nombre AS nombre_equipamiento,
        c.stock_total,
        c.reservado_solapado,
        (c.stock_total - c.reservado_solapado) AS disponible_efectivo,
        c.solicitado_evento,
        GREATEST(0, c.solicitado_evento - (c.stock_total - c.reservado_solapado)) AS faltante,
        (c.solicitado_evento <= (c.stock_total - c.reservado_solapado)) AS puede_cubrir
      FROM consolidado c
      LEFT JOIN public.equipamiento e ON e.id_equipamiento = c.id_equipamiento
      WHERE c.solicitado_evento > 0
      ORDER BY e.nombre
    """;
    return jdbc.queryForList(sql, idEvento, idEvento);
  }

  @Transactional
  public Evento autorizar(Long idEvento) {
    List<Map<String,Object>> ver = verificarEquipamiento(idEvento);
    boolean ok = ver.stream().allMatch(m -> Boolean.TRUE.equals(m.get("puede_cubrir")));
    if (!ok) {
      throw new IllegalStateException("No se puede autorizar: equipamiento insuficiente");
    }
    Evento e = repo.findById(idEvento).orElseThrow();
    e.setEstatus("autorizado");
    e.setMotivo(null);
    return e;
  }

  @Transactional
  public Evento cancelar(Long idEvento, String motivo) {
    if (motivo == null || motivo.isBlank()) throw new IllegalArgumentException("Motivo requerido");
    Evento e = repo.findById(idEvento).orElseThrow();
    e.setEstatus("cancelado");
    e.setMotivo(motivo);
    return e;
  }

  @Transactional
  public Evento deshacer(Long idEvento) {
    Evento e = repo.findById(idEvento).orElseThrow();
    e.setEstatus("pendiente");
    e.setMotivo(null);
    return e;
  }
}
