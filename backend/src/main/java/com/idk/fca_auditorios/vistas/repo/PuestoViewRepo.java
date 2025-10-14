package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.PuestoView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface PuestoViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT p.id_puesto AS idPuesto,
      p.nombre AS nombre,
      p.activo AS activo,
      a.nombre AS area
    FROM puesto p
    JOIN area a ON a.id_area = p.id_area
    ORDER BY p.id_puesto
  """, nativeQuery = true)
List<PuestoView> findAllView();
}
