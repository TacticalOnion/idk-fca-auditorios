package com.idk.fca_auditorios.vistas.repo;

import com.idk.fca_auditorios.vistas.dto.AuditoriaView;
import com.idk.fca_auditorios.vistas.entidad.Permiso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;


public interface AuditoriaViewRepo extends JpaRepository<Permiso, Short> {
  @Query(value = """
    SELECT a.id_auditoria AS idAuditoria,
      a.nombre_tabla AS nombreTabla,
      a.id_registro_afectado AS idRegistroAfectado,
      a.accion AS accion,
      a.campo_modificado AS campoModificado,
      a.valor_anterior AS valorAnterior,
      a.valor_nuevo AS valorNuevo,
      COALESCE(u.nombre || ' ' || u.apellido_paterno || ' ' || u.apellido_materno, 'N/D') AS usuario,
      a.fecha_hora::text AS fechaHora
    FROM auditoria a
    LEFT JOIN usuario u ON u.id_usuario = a.id_usuario
    ORDER BY a.id_auditoria DESC
  """, nativeQuery = true)
  List<AuditoriaView> findAllView();
}
