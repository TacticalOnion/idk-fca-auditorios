package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.UsuarioView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface UsuarioViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT u.id_usuario AS idUsuario,
      u.nombre AS nombre,
      u.apellido_paterno AS apellidoPaterno,
      u.apellido_materno AS apellidoMaterno,
      u.nombre_usuario AS nombreUsuario,
      u.correo AS correo,
      u.telefono AS telefono,
      u.celular AS celular,
      u.activo AS activo,
      r.nombre AS rol,
      p.nombre AS puesto
    FROM usuario u
    JOIN rol_usuario r ON r.id_rol_usuario = u.id_rol_usuario
    JOIN puesto p ON p.id_puesto = u.id_puesto
    ORDER BY u.id_usuario
    """, nativeQuery = true)
    List<UsuarioView> findAllView();
}
