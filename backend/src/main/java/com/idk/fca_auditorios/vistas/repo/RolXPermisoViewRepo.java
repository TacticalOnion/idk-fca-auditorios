package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.RolXPermisoView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface RolXPermisoViewRepo extends JpaRepository<Permiso, Short> {
@Query(value = """
SELECT r.nombre AS rol,
p.recurso AS recurso,
p.accion AS accion,
p.alcance AS alcance
FROM rolxpermiso rxp
JOIN rol_usuario r ON r.id_rol_usuario = rxp.id_rol_usuario
JOIN permiso p ON p.id_permiso = rxp.id_permiso
ORDER BY r.nombre, p.recurso, p.accion, p.alcance
""", nativeQuery = true)
List<RolXPermisoView> findAllView();
}
