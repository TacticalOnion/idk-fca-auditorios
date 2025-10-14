package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.ParticipacionView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface ParticipacionViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT e.nombre AS evento,
      (i.nombre || ' ' || i.apellido_paterno || ' ' || i.apellido_materno) AS integrante,
      rp.nombre AS rolParticipacion,
      p.numero_registro AS numeroRegistro
    FROM participacion p
    JOIN evento e ON e.id_evento = p.id_evento
    JOIN integrante i ON i.id_integrante = p.id_integrante
    JOIN rol_participacion rp ON rp.id_rol_participacion = p.id_rol_participacion
    ORDER BY e.nombre, integrante
  """, nativeQuery = true)
  List<ParticipacionView> findAllView();
}
