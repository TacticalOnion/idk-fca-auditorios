package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.EventoView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface EventoViewRepo extends JpaRepository<Permiso, Short> {
@Query(value = """
  SELECT e.id_evento AS idEvento,
    e.nombre AS nombre,
    e.descripcion AS descripcion,
    e.fecha_inicio::text AS fechaInicio,
    e.fecha_fin::text AS fechaFin,
    e.horario_inicio::text AS horarioInicio,
    e.horario_fin::text AS horarioFin,
    e.presencial AS presencial,
    e.online AS online,
    e.mega_evento AS megaEvento,
    c.nombre AS categoria,
    em.nombre AS megaEventoNombre
  FROM evento e
  JOIN categoria c ON c.id_categoria = e.id_categoria
  LEFT JOIN evento em ON em.id_evento = e.id_mega_evento
  ORDER BY e.id_evento
  """, nativeQuery = true)
List<EventoView> findAllView();
}
