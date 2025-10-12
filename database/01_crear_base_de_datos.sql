-- Crear la base de datos
CREATE DATABASE fca_auditorios
    WITH
    TEMPLATE template0
    ENCODING 'UTF8'
    LC_COLLATE='Spanish_Spain.1252'
    LC_CTYPE='Spanish_Spain.1252'
    LOCALE_PROVIDER = 'libc';

-- Agregar un comentario descriptivo
COMMENT ON DATABASE fca_auditorios IS 'Base de datos del sistema de gestión de auditorios de la FCA';

-- Ajustar zona horaria por defecto
ALTER DATABASE fca_auditorios SET timezone TO 'America/Mexico_City';
