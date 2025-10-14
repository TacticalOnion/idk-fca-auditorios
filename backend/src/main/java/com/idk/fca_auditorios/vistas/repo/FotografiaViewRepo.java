package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.FotografiaView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface FotografiaViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
      SELECT f.id_fotografia AS idFotografia,
      f.fotografia AS fotografia,
      r.nombre AS recinto
    FROM fotografia f
    JOIN recinto r ON r.id_recinto = f.id_recinto
    ORDER BY f.id_fotografia
  """, nativeQuery = true)
  List<FotografiaView> findAllView();
}