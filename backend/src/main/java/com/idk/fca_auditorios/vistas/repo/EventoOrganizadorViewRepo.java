package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.EventoOrganizadorView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface EventoOrganizadorViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT e.nombre AS evento,
      (u.nombre || ' ' || u.apellido_paterno || ' ' || u.apellido_materno) AS organizador,
      eo.confirmacion AS confirmacion,
      eo.numero_registro AS numeroRegistro
    FROM evento_organizador eo
    JOIN evento e ON e.id_evento = eo.id_evento
    JOIN usuario u ON u.id_usuario = eo.id_usuario
    ORDER BY e.nombre, organizador
  """, nativeQuery = true)
List<EventoOrganizadorView> findAllView();
}
