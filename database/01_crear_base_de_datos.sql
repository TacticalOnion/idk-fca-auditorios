-- Crear la base de datos
CREATE DATABASE fca_auditorios
    WITH ENCODING 'UTF8'
    LC_COLLATE='es_MX.UTF-8'
    LC_CTYPE='es_MX.UTF-8'
    TEMPLATE template0;

-- Agregar un comentario descriptivo
COMMENT ON DATABASE fca_auditorios IS 'Base de datos del sistema de gestión de auditorios de la FCA';

-- Ajustar zona horaria por defecto
ALTER DATABASE fca_auditorios SET timezone TO 'America/Mexico_City';
