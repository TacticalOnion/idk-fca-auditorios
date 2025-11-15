SELECT u.nombre_usuario AS "Nombre usuario", r.nombre AS "Rol usuario" 
FROM usuario AS u JOIN rol_usuario AS r 
    ON u.id_rol_usuario = r.id_rol_usuario;