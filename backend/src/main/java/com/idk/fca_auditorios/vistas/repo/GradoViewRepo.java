package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.GradoView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface GradoViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT g.id_grado AS idGrado,
      g.titulo AS titulo,
      n.nombre AS nivel,
      ins.nombre AS institucion,
      p.nombre AS pais
    FROM grado g
    JOIN nivel n ON n.id_nivel = g.id_nivel
    JOIN institucion ins ON ins.id_institucion = g.id_institucion
    JOIN pais p ON p.id_pais = g.id_pais
    ORDER BY g.id_grado
  """, nativeQuery = true)
  List<GradoView> findAllView();
}
