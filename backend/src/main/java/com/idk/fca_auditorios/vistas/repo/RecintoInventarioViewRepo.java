package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.RecintoInventarioView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface RecintoInventarioViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT r.nombre AS recinto,
      e.nombre AS equipamiento,
      ri.cantidad AS cantidad,
      ri.numero_registro AS numeroRegistro
    FROM recinto_inventario ri
    JOIN recinto r ON r.id_recinto = ri.id_recinto
    JOIN equipamiento e ON e.id_equipamiento = ri.id_equipamiento
    ORDER BY r.nombre, e.nombre
  """, nativeQuery = true)
  List<RecintoInventarioView> findAllView();
}
