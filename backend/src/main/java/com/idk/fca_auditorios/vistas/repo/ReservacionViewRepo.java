package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.ReservacionView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface ReservacionViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT e.nombre AS evento,
      r.nombre AS recinto,
      res.fecha_solicitud::text AS fechaSolicitud,
      res.estatus AS estatus,
      res.numero_registro AS numeroRegistro
    FROM reservacion res
    JOIN evento e ON e.id_evento = res.id_evento
    JOIN recinto r ON r.id_recinto = res.id_recinto
    ORDER BY res.numero_registro
  """, nativeQuery = true)
  List<ReservacionView> findAllView();
}