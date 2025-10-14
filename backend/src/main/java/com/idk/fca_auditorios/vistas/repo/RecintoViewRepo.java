package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.RecintoView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface RecintoViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT r.id_recinto AS idRecinto,
      r.nombre AS nombre,
      r.latitud::text AS latitud,
      r.longitud::text AS longitud,
      r.aforo AS aforo,
      r.croquis AS croquis,
      r.activo AS activo,
      t.nombre AS tipo
    FROM recinto r
    JOIN tipo t ON t.id_tipo = r.id_tipo
    ORDER BY r.id_recinto
  """, nativeQuery = true)
  List<RecintoView> findAllView();
}
