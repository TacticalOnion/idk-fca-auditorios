package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.AreaInventarioView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface AreaInventarioViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT a.nombre AS area,
      e.nombre AS equipamiento,
      ai.cantidad AS cantidad,
      ai.numero_registro AS numeroRegistro
    FROM area_inventario ai
    JOIN area a ON a.id_area = ai.id_area
    JOIN equipamiento e ON e.id_equipamiento = ai.id_equipamiento
    ORDER BY a.nombre, e.nombre
  """, nativeQuery = true)
  List<AreaInventarioView> findAllView();
}
