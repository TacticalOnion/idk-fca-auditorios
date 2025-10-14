package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.IntegranteView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface IntegranteViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT i.id_integrante AS idIntegrante,
      i.nombre AS nombre,
      i.apellido_paterno AS apellidoPaterno,
      i.apellido_materno AS apellidoMaterno,
      i.semblanza AS semblanza
    FROM integrante i
    ORDER BY i.id_integrante
  """, nativeQuery = true)
  List<IntegranteView> findAllView();
}
