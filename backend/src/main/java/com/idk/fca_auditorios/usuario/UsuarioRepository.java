package com.idk.fca_auditorios.usuario;

import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import java.util.Optional;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

  interface UserLoginProjection {
    String getNombreUsuario();
    String getContrasenia();
    boolean isActivo();
    String getRolNombre();
  }

  @Query("""
    select u.nombreUsuario as nombreUsuario,
           u.contrasenia    as contrasenia,
           coalesce(u.activo,true) as activo,
           r.nombre         as rolNombre
    from Usuario u
    left join u.rol r
    where lower(u.nombreUsuario) = lower(:username)
    """)
  Optional<UserLoginProjection> findUserForLogin(@Param("username") String username);

  Optional<Usuario> findByNombreUsuarioIgnoreCase(String nombreUsuario);
}
