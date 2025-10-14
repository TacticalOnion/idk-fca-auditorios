package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.ReservacionXEquipamientoView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface ReservacionXEquipamientoViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT e.nombre AS evento,
      r.nombre AS recinto,
      eq.nombre AS equipamiento,
      rxe.cantidad AS cantidad
    FROM reservacionxequipamiento rxe
    JOIN reservacion res ON res.id_evento = rxe.id_evento AND res.id_recinto = rxe.id_recinto
    JOIN evento e ON e.id_evento = res.id_evento
    JOIN recinto r ON r.id_recinto = res.id_recinto
    JOIN equipamiento eq ON eq.id_equipamiento = rxe.id_equipamiento
    ORDER BY e.nombre, r.nombre, eq.nombre
  """, nativeQuery = true)
  List<ReservacionXEquipamientoView> findAllView();
}
