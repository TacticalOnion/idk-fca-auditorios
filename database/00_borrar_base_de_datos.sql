
-- Desconectarse de la base actual (si está en uso)
--     Debes conectarte primero a postgres antes de ejecutar esto.
--     En psql:  \c postgres
--     o en PgAdmin: seleccionar base postgres

-- Eliminar la base existente si existe
DROP DATABASE IF EXISTS fca_auditorios;

-- (Opcional) Eliminar el usuario del sistema si lo habías creado
-- DROP ROLE IF EXISTS fca_user;

-- (Opcional) Limpiar schemas sin borrar la base (si prefieres no eliminar toda la DB)
-- DROP SCHEMA IF EXISTS public CASCADE;
-- CREATE SCHEMA public;
