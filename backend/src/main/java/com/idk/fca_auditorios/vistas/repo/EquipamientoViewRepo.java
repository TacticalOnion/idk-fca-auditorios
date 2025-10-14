package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.EquipamientoView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface EquipamientoViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT eq.id_equipamiento AS idEquipamiento,
      eq.nombre AS nombre,
      eq.activo AS activo,
      a.nombre AS area
    FROM equipamiento eq
    LEFT JOIN area a ON a.id_area = eq.id_area
    ORDER BY eq.id_equipamiento
  """, nativeQuery = true)
  List<EquipamientoView> findAllView();
}
