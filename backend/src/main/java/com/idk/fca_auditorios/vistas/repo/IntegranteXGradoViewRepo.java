package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.IntegranteXGradoView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface IntegranteXGradoViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT (i.nombre || ' ' || i.apellido_paterno || ' ' || i.apellido_materno) AS integrante,
      g.titulo AS grado
    FROM integrantexgrado ig
    JOIN integrante i ON i.id_integrante = ig.id_integrante
    JOIN grado g ON g.id_grado = ig.id_grado
    ORDER BY integrante, grado
  """, nativeQuery = true)
  List<IntegranteXGradoView> findAllView();
}