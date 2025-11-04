-- Limpiar esquema public y crear de nuevo
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

SET client_encoding to 'UTF8';
BEGIN;
---------------------------------------------------------
-- TABLAS PADRE
---------------------------------------------------------
-- permiso
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.permiso (
    id_permiso SMALLINT GENERATED ALWAYS AS IDENTITY,
    recurso VARCHAR(50) NOT NULL,
    accion VARCHAR(50) NOT NULL,
    alcance VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    -- pk
    CONSTRAINT pk_permiso PRIMARY KEY (id_permiso),
    -- ck
    CONSTRAINT ck_permiso_alcance CHECK (alcance IN ('global', 'propietario')),
    CONSTRAINT ck_permiso_recurso_no_vacio CHECK (btrim(recurso) <> ''),
    CONSTRAINT ck_permiso_accion_no_vacio CHECK (btrim(accion) <> ''),
    CONSTRAINT ck_permiso_alcance_no_vacio CHECK (btrim(alcance) <> ''),
    CONSTRAINT ck_permiso_descripcion_no_vacio CHECK (btrim(descripcion) <> ''),
    -- uq
    CONSTRAINT uq_permiso UNIQUE (recurso, accion, alcance)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.permiso IS 'Registra los tipos de permisos que puede tener un rol';
-- atributos
COMMENT ON COLUMN public.permiso.id_permiso IS 'Identificador del permiso';
COMMENT ON COLUMN public.permiso.recurso IS 'Recurso al que se le asigna el permiso (por ejemplo: usuario, evento, reservacion, etc.)';
COMMENT ON COLUMN public.permiso.accion IS 'Acción que se permite realizar sobre el recurso (por ejemplo: crear, leer, editar, eliminar)';
COMMENT ON COLUMN public.permiso.alcance IS 'Alcance del permiso (por ejemplo: global, propietario)';
COMMENT ON COLUMN public.permiso.descripcion IS 'Descripción de la función que otorga al usuario el permiso';
-- ck
COMMENT ON CONSTRAINT ck_permiso_alcance ON public.permiso IS 'Se asegura de que el alcance sea uno de los permitidos';
COMMENT ON CONSTRAINT ck_permiso_recurso_no_vacio ON public.permiso IS 'Se asegura de que el valor de recurso no esté vacío';
COMMENT ON CONSTRAINT ck_permiso_accion_no_vacio ON public.permiso IS 'Se asegura de que el valor de acción no esté vacío';
COMMENT ON CONSTRAINT ck_permiso_alcance_no_vacio ON public.permiso IS 'Se asegura de que el valor de alcance no esté vacío';
COMMENT ON CONSTRAINT ck_permiso_descripcion_no_vacio ON public.permiso IS 'Se asegura de que el valor de descripción no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_permiso ON public.permiso IS 'Se asegura de que no haya permisos duplicados para un mismo recurso, acción y alcance';

---------------------------------------------------------
-- rol_usuario
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.rol_usuario (
    id_rol_usuario SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    -- pk
    CONSTRAINT pk_rol_usuario PRIMARY KEY (id_rol_usuario),
    -- ck
    CONSTRAINT ck_rol_usuario_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    -- uq
    CONSTRAINT uq_rol_usuario_nombre UNIQUE (nombre)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.rol_usuario IS 'Registra los tipos de roles que puede tener un usuario';
-- atributos
COMMENT ON COLUMN public.rol_usuario.id_rol_usuario IS 'Identificador del rol de usuario';
COMMENT ON COLUMN public.rol_usuario.nombre IS 'Nombre del rol de usuario';
-- ck
COMMENT ON CONSTRAINT ck_rol_usuario_nombre_no_vacio ON public.rol_usuario IS 'Se asegura de que el valor del nombre no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_rol_usuario_nombre ON public.rol_usuario IS 'Se asegura de que no haya dos roles de usuario con el mismo nombre';

---------------------------------------------------------
-- responsable_area
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.responsable_area (
    id_responsable_area SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT True,
    -- pk
    CONSTRAINT pk_responsable_area PRIMARY KEY (id_responsable_area),
    -- uq
    CONSTRAINT uq_responsable_area_nombre_completo UNIQUE (nombre, apellido_paterno, apellido_materno),
    -- ck
    CONSTRAINT ck_responsable_area_correo CHECK (correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT ck_responsable_area_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    CONSTRAINT ck_responsable_area_apellido_paterno_no_vacio CHECK (btrim(apellido_paterno) <> ''),
    CONSTRAINT ck_responsable_area_apellido_materno_no_vacio CHECK (btrim(apellido_materno) <> ''),
    CONSTRAINT ck_responsable_area_correo_no_vacio CHECK (btrim(correo) <> '')
);
-- documentacion
-- tabla
COMMENT ON TABLE public.responsable_area IS 'Registra los responsables de las areas';
-- atributos
COMMENT ON COLUMN public.responsable_area.id_responsable_area IS 'Identificador del responsable del area';
COMMENT ON COLUMN public.responsable_area.nombre IS 'Nombre del responsable del area';
COMMENT ON COLUMN public.responsable_area.apellido_paterno IS 'Apellido paterno del responsable del area';
COMMENT ON COLUMN public.responsable_area.apellido_materno IS 'Apellido materno del responsable del area';
COMMENT ON COLUMN public.responsable_area.correo IS 'Correo del responsable del area';
COMMENT ON COLUMN public.responsable_area.activo IS 'Indica si el responsable del area está activo o no';
-- uq
COMMENT ON CONSTRAINT uq_responsable_area_nombre_completo ON public.responsable_area IS 'Se asegura de que no haya dos responsables con el mismo nombre';
-- ck
COMMENT ON CONSTRAINT ck_responsable_area_correo ON public.responsable_area IS 'Se asegura de que el correo tenga un formato válido';
COMMENT ON CONSTRAINT ck_responsable_area_nombre_no_vacio ON public.responsable_area IS 'Se asegura de que el valor del nombre no esté vacío';
COMMENT ON CONSTRAINT ck_responsable_area_apellido_paterno_no_vacio ON public.responsable_area IS 'Se asegura de que el valor del apellido paterno no esté vacío';
COMMENT ON CONSTRAINT ck_responsable_area_apellido_materno_no_vacio ON public.responsable_area IS 'Se asegura de que el valor del apellido materno no esté vacío';
COMMENT ON CONSTRAINT ck_responsable_area_correo_no_vacio ON public.responsable_area IS 'Se asegura de que el valor del correo no esté vacío';
---------------------------------------------------------
-- nivel
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.nivel (
    id_nivel SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    siglas VARCHAR(20) NOT NULL,
    jerarquia SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_nivel PRIMARY KEY (id_nivel),
    -- ck
    CONSTRAINT ck_nivel_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    CONSTRAINT ck_nivel_siglas_no_vacio CHECK (btrim(siglas) <> ''),
    CONSTRAINT ck_nivel_jerarquia CHECK (jerarquia > 0),
    -- uq
    CONSTRAINT uq_nivel_nombre UNIQUE (nombre),
    CONSTRAINT uq_nivel_siglas UNIQUE (siglas)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.nivel IS 'Nivel de educación de un grado academico, por ejemplo: doctorado, maestría, etc.';
-- atributos
COMMENT ON COLUMN public.nivel.id_nivel IS 'Identificador del nivel de un grado academico';
COMMENT ON COLUMN public.nivel.nombre IS 'Nombre del nivel de un grado academico';
COMMENT ON COLUMN public.nivel.siglas IS 'Siglas del nivel de un grado academico';
COMMENT ON COLUMN public.nivel.jerarquia IS 'Jerarquía del nivel de un grado academico, entre mayor sea el valor mayor es la jerarquía';
-- ck
COMMENT ON CONSTRAINT ck_nivel_nombre_no_vacio ON public.nivel IS 'Se asegura de que el valor del nombre no esté vacío';
COMMENT ON CONSTRAINT ck_nivel_siglas_no_vacio ON public.nivel IS 'Se asegura de que el valor de las siglas no esté vacío';
COMMENT ON CONSTRAINT ck_nivel_jerarquia ON public.nivel IS 'Se asegura de que la jerarquía sea mayor a 0';
-- uq
COMMENT ON CONSTRAINT uq_nivel_nombre ON public.nivel IS 'Se asegura de que no haya dos niveles con el mismo nombre';
COMMENT ON CONSTRAINT uq_nivel_siglas ON public.nivel IS 'Se asegura de que no haya dos niveles con las mismas siglas';

---------------------------------------------------------
-- institucion
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.institucion (
    id_institucion SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(100) NOT NULL,
    siglas VARCHAR(20) NOT NULL,
    -- pk
    CONSTRAINT pk_institucion PRIMARY KEY (id_institucion),
    -- ck
    CONSTRAINT ck_institucion_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    CONSTRAINT ck_institucion_siglas_no_vacio CHECK (btrim(siglas) <> ''),
    -- uq
    CONSTRAINT uq_institucion_nombre UNIQUE (nombre)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.institucion IS 'Catálogo de instituciones academicas';
-- atributos
COMMENT ON COLUMN public.institucion.id_institucion IS 'Identificador de la institución academica';
COMMENT ON COLUMN public.institucion.nombre IS 'Nombre de la institución academica';
COMMENT ON COLUMN public.institucion.siglas IS 'Siglas del nombre de la institución academica';
-- ck
COMMENT ON CONSTRAINT ck_institucion_nombre_no_vacio ON public.institucion IS 'Se asegura de que el valor del nombre no esté vacío';
COMMENT ON CONSTRAINT ck_institucion_siglas_no_vacio ON public.institucion IS 'Se asegura de que el valor de las siglas no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_institucion_nombre ON public.institucion IS 'Se asegura de que no haya dos instituciones con el mismo nombre';

---------------------------------------------------------
-- reconocimiento
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.reconocimiento (
    id_reconocimiento INTEGER GENERATED ALWAYS AS IDENTITY,
    titulo VARCHAR(100) NOT NULL,
    organizacion VARCHAR(100) NOT NULL,
    anio SMALLINT NOT NULL,
    descripcion VARCHAR(500) NULL,
    -- pk
    CONSTRAINT pk_reconocimiento PRIMARY KEY (id_reconocimiento),
    -- ck
    CONSTRAINT ck_reconocimiento_titulo_no_vacio CHECK (btrim(titulo) <> ''),
    CONSTRAINT ck_reconocimiento_organizacion_no_vacio CHECK (btrim(organizacion) <> ''),
    CONSTRAINT ck_reconocimiento_descripcion_no_vacio CHECK (btrim(descripcion) <> ''),
    CONSTRAINT ck_reconocimiento_anio_valido CHECK (anio BETWEEN 1900 AND 2100),
    -- uq
    CONSTRAINT uq_reconocimiento UNIQUE (titulo, organizacion, anio) 
);

-- documentacion
-- tablas
COMMENT ON TABLE public.reconocimiento IS 'Registra los reconocimientos obtenidos por un ponente';
-- atributos
COMMENT ON COLUMN public.reconocimiento.id_reconocimiento IS 'Identificador del reconocimiento';
COMMENT ON COLUMN public.reconocimiento.titulo IS 'Título del reconocimiento';
COMMENT ON COLUMN public.reconocimiento.organizacion IS 'Organización que otorga el reconocimiento';
COMMENT ON COLUMN public.reconocimiento.anio IS 'Año en que se otorgó el reconocimiento';
COMMENT ON COLUMN public.reconocimiento.descripcion IS 'Descripción del reconocimiento';
-- ck
COMMENT ON CONSTRAINT ck_reconocimiento_titulo_no_vacio ON public.reconocimiento IS 'Se asegura de que el valor del título no esté vacío';
COMMENT ON CONSTRAINT ck_reconocimiento_organizacion_no_vacio ON public.reconocimiento IS 'Se asegura de que el valor de la organización no esté vacío';
COMMENT ON CONSTRAINT ck_reconocimiento_descripcion_no_vacio ON public.reconocimiento IS 'Se asegura de que el valor de la descripción no esté vacío';
COMMENT ON CONSTRAINT ck_reconocimiento_anio_valido ON public.reconocimiento IS 'Se asegura de que el año esté entre 1900 y 2100';
-- uq
COMMENT ON CONSTRAINT uq_reconocimiento ON public.reconocimiento IS 'Se asegura de que no haya dos reconocimientos iguales';

---------------------------------------------------------
-- categoria
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.categoria (
    id_categoria SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    -- pk
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria),
    -- ck
    CONSTRAINT ck_categoria_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    -- uq
    CONSTRAINT uq_categoria_nombre UNIQUE (nombre)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.categoria IS 'Registra las categorias en las que se puede clasificar un evento';
-- atributos
COMMENT ON COLUMN public.categoria.id_categoria IS 'Identificador de la categoria en la que se puede clasificar el evento';
COMMENT ON COLUMN public.categoria.nombre IS 'Nombre de la categoria';
-- ck
COMMENT ON CONSTRAINT ck_categoria_nombre_no_vacio ON public.categoria IS 'Se asegura de que el valor del nombre no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_categoria_nombre ON public.categoria IS 'Se asegura de que no haya dos categorias con el mismo nombre';

---------------------------------------------------------
-- pais
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.pais (
    id_pais SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(100) NOT NULL,
    -- pk
    CONSTRAINT pk_pais PRIMARY KEY (id_pais),
    -- ck
    CONSTRAINT ck_pais_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    -- uq
    CONSTRAINT uq_pais_nombre UNIQUE (nombre)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.pais IS 'Catálogo de paises';
-- atributos
COMMENT ON COLUMN public.pais.id_pais IS 'Identificador del país';
COMMENT ON COLUMN public.pais.nombre IS 'Nombre del país';
-- ck
COMMENT ON CONSTRAINT ck_pais_nombre_no_vacio ON public.pais IS 'Se asegura de que el valor del nombre no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_pais_nombre ON public.pais IS 'Se asegura de que no haya dos paises con el mismo nombre';

---------------------------------------------------------
-- tipo_recinto
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.tipo_recinto (
    id_tipo_recinto SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    -- pk
    CONSTRAINT pk_tipo_recinto PRIMARY KEY (id_tipo_recinto),
    -- ck
    CONSTRAINT ck_tipo_recinto_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    -- uq
    CONSTRAINT uq_tipo_recinto_nombre UNIQUE (nombre)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.tipo_recinto IS 'Registra los tipos en los que se puede clasificar un recinto';
-- atributos
COMMENT ON COLUMN public.tipo_recinto.id_tipo_recinto IS 'Identificador del tipo en el que se clasifica un recinto';
COMMENT ON COLUMN public.tipo_recinto.nombre IS 'Nombre del tipo de recinto';
-- ck
COMMENT ON CONSTRAINT ck_tipo_recinto_nombre_no_vacio ON public.tipo_recinto IS 'Se asegura de que el valor del nombre no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_tipo_recinto_nombre ON public.tipo_recinto IS 'Se asegura de que no haya dos tipos de recinto con el mismo nombre';

---------------------------------------------------------
-- calendario_escolar
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.calendario_escolar (
    id_calendario_escolar SMALLINT GENERATED ALWAYS AS IDENTITY,
    semestre VARCHAR(50) NOT NULL,
    semestre_inicio DATE NOT NULL,
    semestre_fin DATE NOT NULL,
    -- pk
    CONSTRAINT pk_calendario_escolar PRIMARY KEY (id_calendario_escolar),
    -- ck
    CONSTRAINT ck_calendario_escolar_rango_fechas CHECK (semestre_inicio < semestre_fin),
    CONSTRAINT ck_calendario_escolar_semestre_no_vacio CHECK (btrim(semestre) <> ''),
    -- uq
    CONSTRAINT uq_calendario_escolar_semestre UNIQUE (semestre)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.calendario_escolar IS 'Registra el calendario escolar que regira a los eventos';
-- atributos
COMMENT ON COLUMN public.calendario_escolar.id_calendario_escolar IS 'Identificador del calendario escolar';
COMMENT ON COLUMN public.calendario_escolar.semestre IS 'Nombre del semestre escolar';
COMMENT ON COLUMN public.calendario_escolar.semestre_inicio IS 'Fecha de inicio del semestre escolar';
COMMENT ON COLUMN public.calendario_escolar.semestre_fin IS 'Fecha de fin del semestre escolar';
-- ck
COMMENT ON CONSTRAINT ck_calendario_escolar_rango_fechas ON public.calendario_escolar IS 'Se asegura de que la fecha de inicio del semestre sea inferior a la fecha de fin del semestre';
COMMENT ON CONSTRAINT ck_calendario_escolar_semestre_no_vacio ON public.calendario_escolar IS 'Se asegura de que el valor del semestre no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_calendario_escolar_semestre ON public.calendario_escolar IS 'Se asegura de que no haya dos calendarios escolares con el mismo semestre';

---------------------------------------------------------
-- tipo_periodo
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.tipo_periodo (
    id_tipo_periodo SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    -- pk
    CONSTRAINT pk_tipo_periodo PRIMARY KEY (id_tipo_periodo),
    -- ck
    CONSTRAINT ck_tipo_periodo_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    -- uq
    CONSTRAINT uq_tipo_periodo_nombre UNIQUE (nombre)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.tipo_periodo IS 'Registra los tipos de periodos en los que se pueden clasificar los periodos académicos (por ejemplo: vacaciones administrativas,periodo intersemestral,etc.)';
-- atributos
COMMENT ON COLUMN public.tipo_periodo.id_tipo_periodo IS 'Identificador del tipo de periodo académico';
COMMENT ON COLUMN public.tipo_periodo.nombre IS 'Nombre del tipo de periodo académico';
-- ck
COMMENT ON CONSTRAINT ck_tipo_periodo_nombre_no_vacio ON public.tipo_periodo IS 'Se asegura de que el valor del nombre no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_tipo_periodo_nombre ON public.tipo_periodo IS 'Se asegura de que no haya dos tipos de periodo con el mismo nombre';

---------------------------------------------------------
-- TABLAS PADRE-HIJA
---------------------------------------------------------
-- area
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.area (
    id_area SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(150) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT True ,
    id_responsable_area SMALLINT NULL DEFAULT NULL,
    -- pk
    CONSTRAINT pk_area PRIMARY KEY (id_area),
    -- fk
    CONSTRAINT fk_responsable_area FOREIGN KEY (id_responsable_area) REFERENCES public.responsable_area (id_responsable_area) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_area_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    -- uq
    CONSTRAINT uq_area_nombre UNIQUE (nombre)
);

-- documentacion
-- tabla
COMMENT ON TABLE public.area IS 'Registra los tipos de area a las que puede pertenecer un usuario';
-- atributos
COMMENT ON COLUMN public.area.id_area IS 'Identificador del area al que pertenece el usuario';
COMMENT ON COLUMN public.area.nombre IS 'Nombre del area';
COMMENT ON COLUMN public.area.activo IS 'Indica si el area esta activa o no';
COMMENT ON COLUMN public.area.id_responsable_area IS 'Responsable del area';
-- ck
COMMENT ON CONSTRAINT ck_area_nombre_no_vacio ON public.area IS 'Se asegura de que el valor del nombre no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_area_nombre ON public.area IS 'Se asegura de que no haya dos areas con el mismo nombre';

---------------------------------------------------------
-- periodo
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.periodo (
    id_periodo SMALLINT GENERATED ALWAYS AS IDENTITY,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    id_tipo_periodo SMALLINT NOT NULL,
    id_calendario_escolar SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_periodo PRIMARY KEY (id_periodo),
    -- fk
    CONSTRAINT fk_tipo_periodo FOREIGN KEY (id_tipo_periodo) REFERENCES public.tipo_periodo (id_tipo_periodo) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_calendario_escolar FOREIGN KEY (id_calendario_escolar) REFERENCES public.calendario_escolar (id_calendario_escolar) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_rango_fechas CHECK (fecha_inicio <= fecha_fin)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.periodo IS 'Registra los periodos académicos del calendario escolar';
-- atributos
COMMENT ON COLUMN public.periodo.id_periodo IS 'Identificador del periodo academico';
COMMENT ON COLUMN public.periodo.fecha_inicio IS 'Fecha de inicio del periodo academico';
COMMENT ON COLUMN public.periodo.fecha_fin IS 'Fecha de fin del periodo academico';
COMMENT ON COLUMN public.periodo.id_tipo_periodo IS 'Tipo de periodo academico';
COMMENT ON COLUMN public.periodo.id_calendario_escolar IS 'Calendario escolar al que pertenece el periodo';
-- ck
COMMENT ON CONSTRAINT ck_rango_fechas ON public.periodo IS 'Se asegura de que la fecha de inicio sea anterior a la fecha de fin del periodo academico';
---------------------------------------------------------
-- puesto
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.puesto (
    id_puesto SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(100) NOT NULL,
    unico BOOLEAN NOT NULL DEFAULT True,
    activo BOOLEAN NOT NULL DEFAULT True,
    id_area SMALLINT NOT NULL,
    id_jefe SMALLINT NULL DEFAULT NULL,
    -- pk
    CONSTRAINT pk_puesto PRIMARY KEY (id_puesto),
    -- fk
    CONSTRAINT fk_area FOREIGN KEY (id_area) REFERENCES public.area (id_area) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_jefe FOREIGN KEY (id_jefe) REFERENCES public.puesto (id_puesto) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_puesto_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    CONSTRAINT ck_puesto_id_jefe_no_igual CHECK (id_jefe IS NULL OR id_jefe <> id_puesto),
    -- uq
    CONSTRAINT uq_puesto_nombre UNIQUE(nombre),
    CONSTRAINT uq_puesto_nombre_area UNIQUE (nombre,id_area)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.puesto IS 'Registra los puestos que puede tener un usuario';
-- atributos
COMMENT ON COLUMN public.puesto.id_puesto IS 'Identificador del puesto en la facultad que ocupa el usuario';
COMMENT ON COLUMN public.puesto.nombre IS 'Nombre del puesto';
COMMENT ON COLUMN public.puesto.activo IS 'Indica si el puesto esta activo o no';
COMMENT ON COLUMN public.puesto.id_area IS 'Area al que pertenece el puesto';
COMMENT ON COLUMN public.puesto.id_jefe IS 'Jefe del puesto';
-- ck
COMMENT ON CONSTRAINT ck_puesto_id_jefe_no_igual ON public.puesto IS 'Se segura de que no haya autoreferencia por parte del mismo puesto';
COMMENT ON CONSTRAINT ck_puesto_nombre_no_vacio ON public.puesto IS 'Se asegura de que el valor del nombre no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_puesto_nombre ON public.puesto IS 'Se asegura de que no haya dos puestos con el mismo nombre';
COMMENT ON CONSTRAINT uq_puesto_nombre_area ON public.puesto IS 'Se asegura de que no haya dos puestos iguales';

---------------------------------------------------------
-- usuario
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.usuario (
    id_usuario SMALLINT GENERATED ALWAYS AS IDENTITY,
    foto_usuario VARCHAR(512) NOT NULL DEFAULT '/usuarios/fotos/foto_usuario_default.png',
    nombre_usuario VARCHAR(100) NOT NULL,
    rfc CHAR(13) NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    contrasenia CHAR(64) NOT NULL DEFAULT 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',
    telefono CHAR(10) NOT NULL,
    celular CHAR(10) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT True,
    id_rol_usuario SMALLINT NOT NULL,
    id_puesto SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
    -- fk
    CONSTRAINT fk_rol_usuario FOREIGN KEY (id_rol_usuario) REFERENCES public.rol_usuario (id_rol_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_puesto FOREIGN KEY (id_puesto) REFERENCES public.puesto (id_puesto) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_usuario_rfc_valido CHECK (rfc ~ '^[A-ZÑ&]{3,4}[0-9]{6}[A-Z0-9]{3}$' ),
    CONSTRAINT ck_usuario_correo CHECK (correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT ck_usuario_telefono_celular_numerico CHECK (telefono ~ '^[0-9]{10}$' AND  celular  ~ '^[0-9]{10}$'),
    CONSTRAINT ck_usuario_nombre_usuario_no_vacio CHECK (btrim(nombre_usuario) <> ''),
    CONSTRAINT ck_usuario_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    CONSTRAINT ck_usuario_apellido_paterno_no_vacio CHECK (btrim(apellido_paterno) <> ''),
    CONSTRAINT ck_usuario_apellido_materno_no_vacio CHECK (btrim(apellido_materno) <> ''),
    CONSTRAINT ck_usuario_correo_no_vacio CHECK (btrim(correo) <> ''),
    -- uq
    CONSTRAINT uq_usuario_nombre_usuario UNIQUE (nombre_usuario),
    CONSTRAINT uq_usuario_nombre_completo UNIQUE (nombre, apellido_paterno, apellido_materno),
    CONSTRAINT uq_usuario_rfc UNIQUE (rfc),
    CONSTRAINT uq_usuario_telefono UNIQUE (telefono),
    CONSTRAINT uq_usuario_celular UNIQUE (celular),
    CONSTRAINT uq_usuario_correo UNIQUE (correo)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.usuario IS 'Registra los usuarios del sistema de gestión de recintos';
-- atributos
COMMENT ON COLUMN public.usuario.id_usuario IS 'Identificador del usuario del sistema';
COMMENT ON COLUMN public.usuario.foto_usuario IS 'Ruta del archivo que almacena la foto del usuario';
COMMENT ON COLUMN public.usuario.nombre_usuario IS 'Nombre de usuario';
COMMENT ON COLUMN public.usuario.rfc IS 'RFC del usuario';
COMMENT ON COLUMN public.usuario.nombre IS 'Nombre del usuario';
COMMENT ON COLUMN public.usuario.apellido_paterno IS 'Apellido paterno del usuario';
COMMENT ON COLUMN public.usuario.apellido_materno IS 'Apellido materno del usuario';
COMMENT ON COLUMN public.usuario.contrasenia IS 'Contrasenia de la cuenta del usuario';
COMMENT ON COLUMN public.usuario.telefono IS 'Telefono fijo de contacto del usuario';
COMMENT ON COLUMN public.usuario.celular IS 'Celular de contacto del usuario';
COMMENT ON COLUMN public.usuario.correo IS 'Correo de contacto del usuario';
COMMENT ON COLUMN public.usuario.activo IS 'Indica si el usuario es activo o no';
COMMENT ON COLUMN public.usuario.id_rol_usuario IS 'Rol del usuario';
COMMENT ON COLUMN public.usuario.id_puesto IS 'Puesto del usuario';
-- ck
COMMENT ON CONSTRAINT ck_usuario_correo ON public.usuario IS 'Se asegura de que el correo tenga un formato válido';
COMMENT ON CONSTRAINT ck_usuario_telefono_celular_numerico ON public.usuario IS 'Se asegura de que el telefono y celular contengan solo 10 digitos numericos';
COMMENT ON CONSTRAINT ck_usuario_nombre_usuario_no_vacio ON public.usuario IS 'Se asegura de que el nombre de usuario no esté vacío';
COMMENT ON CONSTRAINT ck_usuario_nombre_no_vacio ON public.usuario IS 'Se asegura de que el nombre no esté vacío';
COMMENT ON CONSTRAINT ck_usuario_apellido_paterno_no_vacio ON public.usuario IS 'Se asegura de que el apellido paterno no esté vacío';
COMMENT ON CONSTRAINT ck_usuario_apellido_materno_no_vacio ON public.usuario IS 'Se asegura de que el apellido materno no esté vacío';
COMMENT ON CONSTRAINT ck_usuario_correo_no_vacio ON public.usuario IS 'Se asegura de que el correo no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_usuario_nombre_usuario ON public.usuario IS 'Se asegura de que no haya dos usuarios con el mismo nombre de usuario';
COMMENT ON CONSTRAINT uq_usuario_nombre_completo ON public.usuario IS 'Se asegura de que no haya dos usuarios con el mismo nombre completo';
COMMENT ON CONSTRAINT uq_usuario_rfc ON public.usuario IS 'Se asegura de que no haya dos usuarios con el mismo RFC';
COMMENT ON CONSTRAINT uq_usuario_telefono ON public.usuario IS 'Se asegura de que no haya dos usuarios con el mismo telefono';
COMMENT ON CONSTRAINT uq_usuario_celular ON public.usuario IS 'Se asegura de que no haya dos usuarios con el mismo celular';
COMMENT ON CONSTRAINT uq_usuario_correo ON public.usuario IS 'Se asegura de que no haya dos usuarios con el mismo correo';

---------------------------------------------------------
-- ponente
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.ponente (
    id_ponente INTEGER GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    id_pais SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_ponente PRIMARY KEY (id_ponente),
    -- fk
    CONSTRAINT fk_ponente_pais FOREIGN KEY (id_pais) REFERENCES public.pais (id_pais) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_ponente_correo CHECK (correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT ck_ponente_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    CONSTRAINT ck_ponente_apellido_paterno_no_vacio CHECK (btrim(apellido_paterno) <> ''),
    CONSTRAINT ck_ponente_apellido_materno_no_vacio CHECK (btrim(apellido_materno) <> ''),
    CONSTRAINT ck_ponente_correo_no_vacio CHECK (btrim(correo) <> ''),
    -- uq
    CONSTRAINT uq_ponente_nombre_completo UNIQUE (nombre, apellido_paterno, apellido_materno),
    CONSTRAINT uq_ponente_correo UNIQUE (correo)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.ponente IS 'Registra a los ponentes que participan en los eventos';
-- atributos
COMMENT ON COLUMN public.ponente.id_ponente IS 'Identificador del ponente que participa en al menos un evento';
COMMENT ON COLUMN public.ponente.nombre IS 'Nombre del ponente';
COMMENT ON COLUMN public.ponente.apellido_paterno IS 'Apellido paterno del ponente';
COMMENT ON COLUMN public.ponente.apellido_materno IS 'Apellido materno del ponente';
COMMENT ON COLUMN public.ponente.correo IS 'Correo para contacto del ponente';
COMMENT ON COLUMN public.ponente.id_pais IS 'País de origen del ponente';
-- ck
COMMENT ON CONSTRAINT ck_ponente_correo ON public.ponente IS 'Se asegura de que el correo tenga un formato válido';
COMMENT ON CONSTRAINT ck_ponente_nombre_no_vacio ON public.ponente IS 'Se asegura de que el valor del nombre no esté vacío';
COMMENT ON CONSTRAINT ck_ponente_apellido_paterno_no_vacio ON public.ponente IS 'Se asegura de que el valor del apellido paterno no esté vacío';
COMMENT ON CONSTRAINT ck_ponente_apellido_materno_no_vacio ON public.ponente IS 'Se asegura de que el valor del apellido materno no esté vacío';
COMMENT ON CONSTRAINT ck_ponente_correo_no_vacio ON public.ponente IS 'Se asegura de que el valor de correo no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_ponente_nombre_completo ON public.ponente IS 'Se asegura de que no haya dos registros de una misma persona en el catálogo de personas';
COMMENT ON CONSTRAINT uq_ponente_correo ON public.ponente IS 'Se asegura de que no haya dos correos iguales';

---------------------------------------------------------
-- evento
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.evento (
    id_evento INTEGER GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_fin TIME NOT NULL,
    presencial BOOLEAN NOT NULL DEFAULT True,
    online BOOLEAN NOT NULL DEFAULT False,
    estatus VARCHAR(50) NOT NULL DEFAULT 'pendiente',
    motivo VARCHAR(500) NULL,
    mega_evento BOOLEAN NOT NULL DEFAULT False,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_categoria SMALLINT NOT NULL,
    id_mega_evento INTEGER NULL,
    id_calendario_escolar SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_evento PRIMARY KEY (id_evento),
    -- fk
    CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria (id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_mega_evento FOREIGN KEY (id_mega_evento) REFERENCES public.evento (id_evento) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_calendario_escolar FOREIGN KEY (id_calendario_escolar) REFERENCES public.calendario_escolar (id_calendario_escolar) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_evento_rango_fechas CHECK (fecha_inicio <= fecha_fin),
    CONSTRAINT ck_evento_rango_horarios CHECK (horario_inicio < horario_fin),
    CONSTRAINT ck_evento_horario_laboral CHECK (horario_inicio >= '07:00' AND horario_fin <= '22:00'),
    CONSTRAINT ck_evento_estatus CHECK (estatus IN ('pendiente', 'autorizado', 'realizado', 'cancelado')),
    CONSTRAINT ck_evento_duracion CHECK (fecha_inicio <> fecha_fin OR (horario_fin - horario_inicio) >= INTERVAL '30 minutes'),
    CONSTRAINT ck_evento_modalidad CHECK (presencial OR online),
    CONSTRAINT ck_evento_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    CONSTRAINT ck_evento_descripcion_no_vacio CHECK (btrim(descripcion) <> ''),
    CONSTRAINT ck_evento_motivo_no_vacio CHECK (btrim(motivo) <> ''),
    -- uq
    CONSTRAINT uq_evento_nombre UNIQUE (nombre)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.evento IS 'Registra los eventos academicos organizados en la facultad';
-- atributos
COMMENT ON COLUMN public.evento.id_evento IS 'Identificador del evento';
COMMENT ON COLUMN public.evento.nombre IS 'Nombre del evento';
COMMENT ON COLUMN public.evento.descripcion IS 'Descripción del evento';
COMMENT ON COLUMN public.evento.fecha_inicio IS 'Fecha de inicio del evento';
COMMENT ON COLUMN public.evento.fecha_fin IS 'Fecha de fin del evento';
COMMENT ON COLUMN public.evento.horario_inicio IS 'Hora de inicio del evento';
COMMENT ON COLUMN public.evento.horario_fin IS 'Hora de fin del evento';
COMMENT ON COLUMN public.evento.presencial IS 'Indica si el evento es de modalidad presencial';
COMMENT ON COLUMN public.evento.online IS 'Indica si el evento es de modalidad online';
COMMENT ON COLUMN public.evento.estatus IS 'Estatus del evento (pendiente, autorizado, realizado, cancelado)';
COMMENT ON COLUMN public.evento.motivo IS 'Motivo de rechazo de la solicitud de evento';
COMMENT ON COLUMN public.evento.mega_evento IS 'Indica si el evento es un mega evento (que agrupa otros eventos)';
COMMENT ON COLUMN public.evento.fecha_registro IS 'Fecha y hora en la que se registró el evento en el sistema';
COMMENT ON COLUMN public.evento.id_categoria IS 'Categoria en la que se clasifica el evento';
COMMENT ON COLUMN public.evento.id_mega_evento IS 'Mega evento al que pertenece el evento. Sirve para casos en donde un evento agrupa otros eventos';
COMMENT ON COLUMN public.evento.id_calendario_escolar IS 'Calendario escolar al que pertenece el evento';
-- ck
COMMENT ON CONSTRAINT ck_evento_rango_fechas ON public.evento IS 'Se asegura de que la fecha de inicio no sea posterior a la fecha de fin';
COMMENT ON CONSTRAINT ck_evento_rango_horarios ON public.evento IS 'Se asegura de que la hora de inicio sea anterior a la hora de fin';
COMMENT ON CONSTRAINT ck_evento_horario_laboral ON public.evento IS 'Se asegura de que el evento se realice dentro del horario laboral (07:00 a 22:00)';
COMMENT ON CONSTRAINT ck_evento_estatus ON public.evento IS 'Valida que solo se registren los estatus pendiente, autorizado, realizado y cancelado';
COMMENT ON CONSTRAINT ck_evento_duracion ON public.evento IS 'Se asegura de que el evento tenga una duración mínima de 30 minutos si es en un solo día';
COMMENT ON CONSTRAINT ck_evento_modalidad ON public.evento  IS 'Se asegura de que al menos una modalidad (presencial u online) sea verdadera';
COMMENT ON CONSTRAINT ck_evento_nombre_no_vacio ON public.evento IS 'Se asegura de que el valor del nombre no esté vacío';
COMMENT ON CONSTRAINT ck_evento_descripcion_no_vacio ON public.evento IS 'Se asegura de que el valor de la descripción no esté vacío';
COMMENT ON CONSTRAINT ck_evento_motivo_no_vacio ON public.evento IS 'Se asegura de que el valor del motivo no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_evento_nombre ON public.evento IS 'Se asegura de que no haya dos eventos con el mismo nombre';

---------------------------------------------------------
-- empresa
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.empresa (
    id_empresa SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    id_pais SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_empresa PRIMARY KEY (id_empresa),
    -- fk
    CONSTRAINT fk_empresa_pais FOREIGN KEY (id_pais) REFERENCES public.pais (id_pais) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_empresa_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    -- uq
    CONSTRAINT uq_empresa_nombre UNIQUE (nombre)
);

-- documentacion
-- tabla
COMMENT ON TABLE public.empresa IS 'Catálogo de empresas';
-- atributos
COMMENT ON COLUMN public.empresa.id_empresa IS 'Identificador de la empresa';
COMMENT ON COLUMN public.empresa.nombre IS 'Nombre de la empresa';
COMMENT ON COLUMN public.empresa.id_pais IS 'País al que pertenece la empresa';
-- ck
COMMENT ON CONSTRAINT ck_empresa_nombre_no_vacio ON public.empresa IS 'Se asegura de que el valor del nombre no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_empresa_nombre ON public.empresa IS 'Se asegura de que no haya dos empresas con el mismo nombre';

---------------------------------------------------------
-- semblanza
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.semblanza (
    id_semblanza INTEGER GENERATED ALWAYS AS IDENTITY,
    archivo VARCHAR(512) NOT NULL,
    biografia VARCHAR(500) NULL,
    id_ponente INTEGER NOT NULL,
    -- pk
    CONSTRAINT pk_semblanza PRIMARY KEY (id_semblanza),
    -- fk
    CONSTRAINT fk_ponente FOREIGN KEY (id_ponente) REFERENCES public.ponente (id_ponente) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_semblanza_archivo_no_vacio CHECK (btrim(archivo) <> ''),
    CONSTRAINT ck_semblanza_biografia_no_vacio CHECK (btrim(biografia) <> ''),
    -- uq
    CONSTRAINT uq_semblanza_archivo UNIQUE (archivo),
    CONSTRAINT uq_semblanza_ponente UNIQUE (id_ponente)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.semblanza IS 'Registra las semblanzas de los ponentes';
-- atributos
COMMENT ON COLUMN public.semblanza.id_semblanza IS 'Identificador de la semblanza';
COMMENT ON COLUMN public.semblanza.archivo IS 'Ruta del archivo de la semblanza';
COMMENT ON COLUMN public.semblanza.biografia IS 'Biografía del ponente';
COMMENT ON COLUMN public.semblanza.id_ponente IS 'Ponente al que pertenece la semblanza';
-- ck
COMMENT ON CONSTRAINT ck_semblanza_archivo_no_vacio ON public.semblanza IS 'Se asegura de que el valor del archivo no esté vacío';
COMMENT ON CONSTRAINT ck_semblanza_biografia_no_vacio ON public.semblanza IS 'Se asegura de que el valor de la biografía no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_semblanza_archivo ON public.semblanza IS 'Se asegura de que no haya dos semblanzas con el mismo archivo';
COMMENT ON CONSTRAINT uq_semblanza_ponente ON public.semblanza IS 'Se asegura de que no haya dos semblanzas para el mismo ponente';

---------------------------------------------------------
-- experiencia
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.experiencia (
    id_experiencia INTEGER GENERATED ALWAYS AS IDENTITY,
    puesto VARCHAR(50) NOT NULL,
    puesto_actual BOOLEAN NOT NULL DEFAULT False,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL DEFAULT CURRENT_DATE,
    id_empresa SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_experiencia PRIMARY KEY (id_experiencia),
    -- fk
    CONSTRAINT fk_empresa FOREIGN KEY (id_empresa) REFERENCES public.empresa (id_empresa) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_experiencia_rango_fechas CHECK (fecha_inicio < fecha_fin),
    CONSTRAINT ck_experiencia_puesto_no_vacio CHECK (btrim(puesto) <> ''),
    CONSTRAINT ck_experiencia_anio_inicio_valido CHECK (fecha_inicio BETWEEN '1900-01-01' AND '2100-12-31'),
    CONSTRAINT ck_experiencia_anio_fin_valido CHECK (fecha_fin IS NULL OR fecha_fin BETWEEN '1900-01-01' AND '2100-12-31'),
    -- uq
    CONSTRAINT uq_experiencia UNIQUE (puesto, fecha_inicio, fecha_fin, id_empresa)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.experiencia IS 'Registra las experiencias laborales de los ponentes';
-- atributos
COMMENT ON COLUMN public.experiencia.id_experiencia IS 'Identificador de la experiencia laboral';
COMMENT ON COLUMN public.experiencia.puesto IS 'Puesto desempeñado en la experiencia laboral';
COMMENT ON COLUMN public.experiencia.puesto_actual IS 'Indica si el puesto es el actual del ponente';
COMMENT ON COLUMN public.experiencia.fecha_inicio IS 'Fecha de inicio de la experiencia laboral';
COMMENT ON COLUMN public.experiencia.fecha_fin IS 'Fecha de fin de la experiencia laboral';
COMMENT ON COLUMN public.experiencia.id_empresa IS 'Empresa en la que se desempeñó la experiencia laboral';
-- ck
COMMENT ON CONSTRAINT ck_experiencia_rango_fechas ON public.experiencia IS 'Se asegura de que la fecha de inicio sea anterior a la fecha de fin';
COMMENT ON CONSTRAINT ck_experiencia_puesto_no_vacio ON public.experiencia IS 'Se asegura de que el valor del puesto no esté vacío';
COMMENT ON CONSTRAINT ck_experiencia_anio_inicio_valido ON public.experiencia IS 'Se asegura de que la fecha de inicio esté entre los años 1900 y 2100';
COMMENT ON CONSTRAINT ck_experiencia_anio_fin_valido ON public.experiencia IS 'Se asegura de que la fecha de fin esté entre los años 1900 y 2100';
-- uq
COMMENT ON CONSTRAINT uq_experiencia ON public.experiencia IS 'Se asegura de que no haya dos experiencias laborales iguales';

---------------------------------------------------------
-- grado
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.grado (
    id_grado INTEGER GENERATED ALWAYS AS IDENTITY,
    titulo VARCHAR(100) NOT NULL,
    anio SMALLINT NOT NULL,
    id_nivel SMALLINT NOT NULL,
    id_institucion SMALLINT NOT NULL,
    id_pais SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_grado PRIMARY KEY (id_grado),
    -- fk
    CONSTRAINT fk_nivel FOREIGN KEY (id_nivel) REFERENCES public.nivel (id_nivel) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_institucion FOREIGN KEY (id_institucion) REFERENCES public.institucion (id_institucion) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_pais FOREIGN KEY (id_pais) REFERENCES public.pais (id_pais) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_grado_titulo_no_vacio CHECK (btrim(titulo) <> ''),
    CONSTRAINT ck_grado_anio_valido CHECK (anio > 1900 AND anio < 2100),
    -- uq
    CONSTRAINT uq_grado_titulo_academico UNIQUE (titulo,anio,id_nivel,id_institucion)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.grado IS 'Describe los tipos de grado que pueden tener los ponentes al participar en los eventos';
-- atributos
COMMENT ON COLUMN public.grado.id_grado IS 'Identificador del grado academico del ponente que participa en al menos un evento';
COMMENT ON COLUMN public.grado.titulo IS 'Titulo del grado academico';
COMMENT ON COLUMN public.grado.anio IS 'Año en el que se emitió el grado academico';
COMMENT ON COLUMN public.grado.id_nivel IS 'Nivel del grado academico';
COMMENT ON COLUMN public.grado.id_institucion IS 'Institución que emitió el grado academico';
COMMENT ON COLUMN public.grado.id_pais IS 'Pais en el que se emitió el grado academico';
-- ck
COMMENT ON CONSTRAINT ck_grado_titulo_no_vacio ON public.grado IS 'Se asegura de que el valor del titulo no esté vacío';
COMMENT ON CONSTRAINT ck_grado_anio_valido ON public.grado IS 'Se asegura de que el año del grado sea válido';
-- uq
COMMENT ON CONSTRAINT uq_grado_titulo_academico ON public.grado IS 'Se asegura de que no haya dos titulos academicos iguales';

---------------------------------------------------------
-- equipamiento
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.equipamiento (
    id_equipamiento SMALLINT GENERATED ALWAYS AS IDENTITY,
    foto VARCHAR(512) NOT NULL DEFAULT '/equipamiento/fotos/equipamiento_default.png',
    nombre VARCHAR(100) NOT NULL,
    existencia BOOLEAN NOT NULL DEFAULT False,
    -- pk
    CONSTRAINT pk_equipamiento PRIMARY KEY (id_equipamiento),
    -- ck
    CONSTRAINT ck_equipamiento_foto_no_vacio CHECK (btrim(foto) <> ''),
    CONSTRAINT ck_equipamiento_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    --  uq
    CONSTRAINT uq_equipamiento_nombre UNIQUE (nombre)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.equipamiento IS 'Equipamiento solicitado o con el que cuenta la facultad para atender un evento';
-- atributos
COMMENT ON COLUMN public.equipamiento.id_equipamiento IS 'Identificador del equipamiento';
COMMENT ON COLUMN public.equipamiento.foto IS 'Ruta del archivo que almacena la foto del equipamiento';
COMMENT ON COLUMN public.equipamiento.nombre IS 'Nombre del equipamiento';
COMMENT ON COLUMN public.equipamiento.existencia IS 'Indica si el equipamiento se encuentra esta en existencia o no';
-- ck
COMMENT ON CONSTRAINT ck_equipamiento_foto_no_vacio ON public.equipamiento IS 'Se asegura de que el valor de la foto no esté vacío';
COMMENT ON CONSTRAINT ck_equipamiento_nombre_no_vacio ON public.equipamiento IS 'Se asegura de que el valor del nombre no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_equipamiento_nombre ON public.equipamiento IS 'Se asegura de que no haya dos equipamientos con el mismo nombre';

---------------------------------------------------------
-- recinto
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.recinto (
    id_recinto SMALLINT GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(100) NOT NULL,
    latitud NUMERIC(9,6) NOT NULL,
    longitud NUMERIC(9,6) NOT NULL,
    aforo SMALLINT NOT NULL,
    croquis VARCHAR(512) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT True,
    id_tipo_recinto SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_recinto PRIMARY KEY (id_recinto),
    -- fk
    CONSTRAINT fk_tipo_recinto FOREIGN KEY (id_tipo_recinto) REFERENCES public.tipo_recinto (id_tipo_recinto) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_recinto_aforo CHECK (aforo > 0),
    CONSTRAINT ck_recinto_latitud CHECK (latitud BETWEEN -90 AND 90),
    CONSTRAINT ck_recinto_longitud CHECK (longitud BETWEEN -180 AND 180),
    CONSTRAINT ck_recinto_nombre_no_vacio CHECK (btrim(nombre) <> ''),
    CONSTRAINT ck_recinto_croquis_no_vacio CHECK (btrim(croquis) <> ''),
    -- uq
    CONSTRAINT uq_recinto_nombre UNIQUE (nombre)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.recinto IS 'Registra los recintos de la facultad que son usados para eventos academicos';
-- atributos
COMMENT ON COLUMN public.recinto.id_recinto IS 'Identificador del recinto';
COMMENT ON COLUMN public.recinto.nombre IS 'Nombre del recinto';
COMMENT ON COLUMN public.recinto.latitud IS 'Latitud en el que se encuentra ubicado geograficamente el recinto';
COMMENT ON COLUMN public.recinto.longitud IS 'Longitud en el que se encuentra ubicado geograficamente el recinto';
COMMENT ON COLUMN public.recinto.aforo IS 'Capacidad maxima de personas que pueden estar en el recinto';
COMMENT ON COLUMN public.recinto.croquis IS 'Ruta del archivo croquis que muestra como llegar al recinto';
COMMENT ON COLUMN public.recinto.activo IS 'Indica si el recinto esta activo o no';
COMMENT ON COLUMN public.recinto.id_tipo_recinto IS 'Tipo en el que se clasifica el recinto';
-- ck
COMMENT ON CONSTRAINT ck_recinto_aforo ON public.recinto IS 'Se asegura de que el aforo sea un valor positivo mayor a cero';
COMMENT ON CONSTRAINT ck_recinto_latitud ON public.recinto IS 'Se asegura de que la latitud este en el rango valido de -90 a 90';
COMMENT ON CONSTRAINT ck_recinto_longitud ON public.recinto IS 'Se asegura de que la longitud este en el rango valido de -180 a 180';
COMMENT ON CONSTRAINT ck_recinto_nombre_no_vacio ON public.recinto IS 'Se asegura de que el nombre no esté vacío';
COMMENT ON CONSTRAINT ck_recinto_croquis_no_vacio ON public.recinto IS 'Se asegura de que el croquis no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_recinto_nombre ON public.recinto IS 'Se asegura de que no haya dos recintos con el mismo nombre';

---------------------------------------------------------
-- TABLAS HIJA
---------------------------------------------------------
-- rolxpermiso
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.rolxpermiso (
    id_rol_usuario SMALLINT,
    id_permiso SMALLINT,
    -- pk
    CONSTRAINT pk_rolxpermiso PRIMARY KEY (id_rol_usuario, id_permiso),
    -- fk
    CONSTRAINT fk_rol_usuario FOREIGN KEY (id_rol_usuario) REFERENCES public.rol_usuario (id_rol_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_permiso FOREIGN KEY (id_permiso) REFERENCES public.permiso (id_permiso) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- documentacion
-- tabla
COMMENT ON TABLE public.rolxpermiso IS 'Registra los permisos que tienen cada uno de los roles';
-- atributos
COMMENT ON COLUMN public.rolxpermiso.id_rol_usuario IS 'Rol al que se asignara el permiso';
COMMENT ON COLUMN public.rolxpermiso.id_permiso IS 'Permiso al que se asignara al rol de usuario';

---------------------------------------------------------
-- evento_organizador
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.evento_organizador (
    id_evento INTEGER,
    id_usuario SMALLINT,
    numero_registro INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    -- pk
    CONSTRAINT pk_evento_organizador PRIMARY KEY (id_evento, id_usuario),
    -- fk
    CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento (id_evento) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- uq
    CONSTRAINT uq_evento_organizador_numero_registro UNIQUE (numero_registro)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.evento_organizador IS 'Registra todos los eventos organizados por el usuario';
-- atributos
COMMENT ON COLUMN public.evento_organizador.id_evento IS 'Identificador del evento en el que participa como organizador el usuario';
COMMENT ON COLUMN public.evento_organizador.id_usuario IS 'Identificador del usuario que participa en la organización del evento';
COMMENT ON COLUMN public.evento_organizador.numero_registro IS 'Indica el numero de registro';
-- uq
COMMENT ON CONSTRAINT uq_evento_organizador_numero_registro ON public.evento_organizador IS 'Se asegura de que no repetir el numero de registro';

---------------------------------------------------------
-- participacion
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.participacion (
    id_evento INTEGER,
    id_ponente INTEGER,
    reconocimiento VARCHAR (512) NULL,
    numero_registro INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    -- pk
    CONSTRAINT pk_participacion PRIMARY KEY (id_evento, id_ponente),
    -- fk
    CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento (id_evento) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ponente FOREIGN KEY (id_ponente) REFERENCES public.ponente (id_ponente) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_participacion_reconocimiento_no_vacio CHECK (btrim(reconocimiento) <> ''),
    -- uq
    CONSTRAINT uq_participacion_reconocimiento UNIQUE (reconocimiento),
    CONSTRAINT uq_participacion_numero_registro UNIQUE (numero_registro)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.participacion IS 'Registra las participaciones que tienen los ponentes en cada uno de los eventos';
-- atributos
COMMENT ON COLUMN public.participacion.id_evento IS 'Evento en el que partipa el ponente';
COMMENT ON COLUMN public.participacion.id_ponente IS 'ponente que participa en el evento';
COMMENT ON COLUMN public.participacion.reconocimiento IS 'Archivo que registra el reconocimiento de participacion de un ponente';
COMMENT ON COLUMN public.participacion.numero_registro IS 'Indica el numero de registro';
-- ck
COMMENT ON CONSTRAINT ck_participacion_reconocimiento_no_vacio ON public.participacion IS 'Se asegura de que el valor del reconocimiento no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_participacion_reconocimiento ON public.participacion IS 'Se asegura de no repetir el reconocimiento';
COMMENT ON CONSTRAINT uq_participacion_numero_registro ON public.participacion IS 'Se asegura de no repetir el numero de registro';

---------------------------------------------------------
-- semblanzaxreconocimiento
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.semblanzaxreconocimiento (
    id_semblanza INTEGER,
    id_reconocimiento INTEGER,
    -- pk
    CONSTRAINT pk_semblanzaxreconocimiento PRIMARY KEY (id_semblanza, id_reconocimiento),
    -- fk
    CONSTRAINT fk_semblanza FOREIGN KEY (id_semblanza) REFERENCES public.semblanza (id_semblanza) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_reconocimiento FOREIGN KEY (id_reconocimiento) REFERENCES public.reconocimiento (id_reconocimiento) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- documentacion
-- tabla
COMMENT ON TABLE public.semblanzaxreconocimiento IS 'Asocia las semblanzas con los reconocimientos obtenidos';
-- atributos
COMMENT ON COLUMN public.semblanzaxreconocimiento.id_semblanza IS 'Identificador de la semblanza';
COMMENT ON COLUMN public.semblanzaxreconocimiento.id_reconocimiento IS 'Identificador del reconocimiento asociado';

---------------------------------------------------------
-- semblanzaxexperiencia
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.semblanzaxexperiencia (
    id_semblanza INTEGER,
    id_experiencia INTEGER,
    -- pk
    CONSTRAINT pk_semblanzaxexperiencia PRIMARY KEY (id_semblanza, id_experiencia),
    -- fk
    CONSTRAINT fk_semblanza FOREIGN KEY (id_semblanza) REFERENCES public.semblanza (id_semblanza) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_experiencia FOREIGN KEY (id_experiencia) REFERENCES public.experiencia (id_experiencia) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- documentacion
-- tabla
COMMENT ON TABLE public.semblanzaxexperiencia IS 'Asocia las semblanzas con las experiencias obtenidas';
-- atributos
COMMENT ON COLUMN public.semblanzaxexperiencia.id_semblanza IS 'Identificador de la semblanza';
COMMENT ON COLUMN public.semblanzaxexperiencia.id_experiencia IS 'Identificador de la experiencia asociada';

---------------------------------------------------------
-- semblanzaxgrado
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.semblanzaxgrado (
    id_semblanza INTEGER,
    id_grado SMALLINT,
    -- pk
    CONSTRAINT pk_semblanzaxgrado PRIMARY KEY (id_semblanza, id_grado),
    -- fk
    CONSTRAINT fk_semblanza FOREIGN KEY (id_semblanza) REFERENCES public.semblanza (id_semblanza) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_grado FOREIGN KEY (id_grado) REFERENCES public.grado (id_grado) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- documentacion
-- tabla
COMMENT ON TABLE public.semblanzaxgrado IS 'Asocia las semblanzas con los grados obtenidos';
-- atributos
COMMENT ON COLUMN public.semblanzaxgrado.id_semblanza IS 'Identificador de la semblanza';
COMMENT ON COLUMN public.semblanzaxgrado.id_grado IS 'Identificador del grado asociado';

---------------------------------------------------------
-- reservacion
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.reservacion (
    id_evento INTEGER,
    id_recinto SMALLINT,
    fecha_solicitud TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    numero_registro INTEGER GENERATED ALWAYS AS IDENTITY,
    -- pk
    CONSTRAINT pk_reservacion PRIMARY KEY (id_evento, id_recinto),
    -- fk
    CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento (id_evento) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_recinto FOREIGN KEY (id_recinto) REFERENCES public.recinto (id_recinto) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- uq
    CONSTRAINT uq_reservacion_numero_registro UNIQUE (numero_registro)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.reservacion IS 'Registra las reservaciones (incluidas solicitudes rechazadas o aún no aprobadas) de recintos que hacen cada uno de los eventos de la facultad';
-- atributos
COMMENT ON COLUMN public.reservacion.id_evento IS 'Evento que realiza la reservación';
COMMENT ON COLUMN public.reservacion.id_recinto IS 'Recinto que se desea reservar';
COMMENT ON COLUMN public.reservacion.fecha_solicitud IS 'Fecha y hora en la que se realizó la solicitud de reservación';
COMMENT ON COLUMN public.reservacion.numero_registro IS 'Indica el numero de registro';
-- uq
COMMENT ON CONSTRAINT uq_reservacion_numero_registro ON public.reservacion IS 'Se asegura de que no repetir el numero de registro';

---------------------------------------------------------
-- eventoxequipamiento
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.eventoxequipamiento (
    id_evento INTEGER,
    id_equipamiento SMALLINT,
    cantidad SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_evento_x_equipamiento PRIMARY KEY (id_evento, id_equipamiento),
    -- fk
    CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento (id_evento) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_equipamiento FOREIGN KEY (id_equipamiento) REFERENCES public.equipamiento (id_equipamiento) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_eventoxequipamiento_cantidad CHECK (cantidad >= 0)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.eventoxequipamiento IS 'Registra el equipamiento solicitado en cada una de las reservaciones';
-- atributos
COMMENT ON COLUMN public.eventoxequipamiento.id_evento IS 'Evento en el que se solicita el equipamiento';
COMMENT ON COLUMN public.eventoxequipamiento.id_equipamiento IS 'Equipamiento que se solicita para el evento';
COMMENT ON COLUMN public.eventoxequipamiento.cantidad IS 'Cantidad del equipamiento solicitado para el evento';
-- ck
COMMENT ON CONSTRAINT ck_eventoxequipamiento_cantidad ON public.eventoxequipamiento IS 'Se asegura de que la cantidad solicitada sea un valor positivo mayor o igual a cero';

---------------------------------------------------------
-- inventario_area
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.inventario_area (
    id_equipamiento SMALLINT,
    id_area SMALLINT,
    cantidad SMALLINT NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT True,
    ultima_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    numero_registro INTEGER GENERATED ALWAYS AS IDENTITY, 
    -- pk
    CONSTRAINT pk_inventario_area PRIMARY KEY (id_equipamiento, id_area),
    -- fk
    CONSTRAINT fk_equipamiento FOREIGN KEY (id_equipamiento) REFERENCES public.equipamiento (id_equipamiento) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_area FOREIGN KEY (id_area) REFERENCES public.area (id_area) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_inventario_area_cantidad CHECK (cantidad >= 0),
    -- uq
    CONSTRAINT uq_inventario_area_numero_registro UNIQUE (numero_registro)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.inventario_area IS 'Registra la cantidad de equipamiento disponible en cada recinto';
-- atributos
COMMENT ON COLUMN public.inventario_area.id_equipamiento IS 'Equipamiento que se encuentra en el área';
COMMENT ON COLUMN public.inventario_area.id_area IS 'Area donde se encuentra el equipamiento';
COMMENT ON COLUMN public.inventario_area.cantidad IS 'Cantidad de equipamiento disponible en el área';
COMMENT ON COLUMN public.inventario_area.activo IS 'Indica si el registro de inventario está activo o no';
COMMENT ON COLUMN public.inventario_area.ultima_modificacion IS 'Indica la ultima modificacion del inventario';
COMMENT ON COLUMN public.inventario_area.numero_registro IS 'Indica el numero de registro';
-- ck
COMMENT ON CONSTRAINT ck_inventario_area_cantidad ON public.inventario_area IS 'Se asegura de que la cantidad sea un valor positivo mayor o igual a cero';
-- uq
COMMENT ON CONSTRAINT uq_inventario_area_numero_registro ON public.inventario_area IS 'Se asegura de que solo exista un numero de registro';

---------------------------------------------------------
-- inventario_recinto
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.inventario_recinto (
    id_equipamiento SMALLINT,
    id_recinto SMALLINT,
    cantidad SMALLINT NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT True,
    ultima_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    numero_registro INTEGER GENERATED ALWAYS AS IDENTITY,
    -- pk
    CONSTRAINT pk_inventario_recinto PRIMARY KEY (id_equipamiento, id_recinto),
    -- fk
    CONSTRAINT fk_equipamiento FOREIGN KEY (id_equipamiento) REFERENCES public.equipamiento (id_equipamiento) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_recinto FOREIGN KEY (id_recinto) REFERENCES public.recinto (id_recinto) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- ck
    CONSTRAINT ck_inventario_recinto_cantidad CHECK (cantidad >= 0),
    -- uq
    CONSTRAINT uq_inventario_recinto_numero_registro UNIQUE (numero_registro)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.inventario_recinto IS 'Registra la cantidad de equipamiento disponible en cada recinto';
-- atributos
COMMENT ON COLUMN public.inventario_recinto.id_equipamiento IS 'Equipamiento que se encuentra en el recinto';
COMMENT ON COLUMN public.inventario_recinto.id_recinto IS 'Recinto donde se encuentra el equipamiento';
COMMENT ON COLUMN public.inventario_recinto.cantidad IS 'Cantidad de equipamiento disponible en el recinto';
COMMENT ON COLUMN public.inventario_recinto.activo IS 'Indica si el registro de inventario está activo o no';
COMMENT ON COLUMN public.inventario_recinto.ultima_modificacion IS 'Indica la ultima modificacion del inventario';
COMMENT ON COLUMN public.inventario_recinto.numero_registro IS 'Indica el numero de registro';
-- ck
COMMENT ON CONSTRAINT ck_inventario_recinto_cantidad ON public.inventario_recinto IS 'Se asegura de que la cantidad sea un valor positivo mayor o igual a cero';
-- uq
COMMENT ON CONSTRAINT uq_inventario_recinto_numero_registro ON public.inventario_recinto IS 'Se asegura de que solo exista un numero de registro';

---------------------------------------------------------
-- fotografia
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.fotografia (
    id_fotografia SMALLINT GENERATED ALWAYS AS IDENTITY,
    fotografia VARCHAR(512) NOT NULL,
    id_recinto SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_fotografia PRIMARY KEY (id_fotografia),
    -- fk
    CONSTRAINT fk_recinto FOREIGN KEY (id_recinto) REFERENCES public.recinto (id_recinto) ON DELETE CASCADE ON UPDATE CASCADE,
    -- CK
    CONSTRAINT ck_fotografia_fotografia_no_vacio CHECK (btrim(fotografia) <> ''),
    -- uq
    CONSTRAINT uq_fotografia_recinto_fotografia UNIQUE (id_recinto,fotografia)
);
-- documentacion
-- tabla
COMMENT ON TABLE public.fotografia IS 'Registra las rutas donde estan almacenadas las fotografias de cada recinto';
--atributos
COMMENT ON COLUMN public.fotografia.id_fotografia IS 'Identificador de la fotografia del recinto';
COMMENT ON COLUMN public.fotografia.fotografia IS 'Ruta del archivo que almacena la fotografia del recinto';
COMMENT ON COLUMN public.fotografia.id_recinto IS 'Recinto al que pertenece la fotografia';
-- ck
COMMENT ON CONSTRAINT ck_fotografia_fotografia_no_vacio ON public.fotografia IS 'Se asegura de que el valor de la fotografia no esté vacío';
-- uq
COMMENT ON CONSTRAINT uq_fotografia_recinto_fotografia ON public.fotografia IS 'Se asegura de que un recinto no tenga las mismas fotografias';

---------------------------------------------------------
-- auditoria
---------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.auditoria(
    id_auditoria BIGINT GENERATED ALWAYS AS IDENTITY,
    nombre_tabla VARCHAR(50) NOT NULL,
    id_registro_afectado INTEGER NOT NULL,
    accion VARCHAR(50) NOT NULL,
    campo_modificado VARCHAR(50) NULL,
    valor_anterior TEXT NULL,
    valor_nuevo TEXT NULL,
    fecha_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario SMALLINT NOT NULL,
    id_puesto SMALLINT NOT NULL,
    -- pk
    CONSTRAINT pk_auditoria PRIMARY KEY (id_auditoria),
    -- fk
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario (id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_puesto FOREIGN KEY (id_puesto) REFERENCES public.puesto (id_puesto) ON DELETE RESTRICT ON UPDATE RESTRICT,
    -- ck
    CONSTRAINT ck_auditoria_accion CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    CONSTRAINT ck_auditoria_update_campos CHECK (accion <> 'UPDATE'  OR (campo_modificado IS NOT NULL AND valor_anterior IS NOT NULL AND valor_nuevo IS NOT NULL))
);
-- documentacion
-- tabla
COMMENT ON TABLE public.auditoria IS 'Registra las acciones de inserción, actualización y eliminación realizadas en las tablas del sistema para fines de auditoría y seguimiento';
-- atributos
COMMENT ON COLUMN public.auditoria.id_auditoria IS 'Identificador único de la entrada de auditoría';
COMMENT ON COLUMN public.auditoria.nombre_tabla IS 'Nombre de la tabla donde se realizó la acción';
COMMENT ON COLUMN public.auditoria.id_registro_afectado IS 'Identificador del registro afectado por la acción';
COMMENT ON COLUMN public.auditoria.accion IS 'Tipo de acción realizada (INSERT, UPDATE, DELETE)';
COMMENT ON COLUMN public.auditoria.campo_modificado IS 'Nombre del campo que fue modificado (solo para UPDATE)';
COMMENT ON COLUMN public.auditoria.valor_anterior IS 'Valor anterior del campo modificado (solo para UPDATE)';
COMMENT ON COLUMN public.auditoria.valor_nuevo IS 'Nuevo valor del campo modificado (solo para UPDATE)';
COMMENT ON COLUMN public.auditoria.id_usuario IS 'Usuario que realizó la acción';
COMMENT ON COLUMN public.auditoria.fecha_hora IS 'Fecha y hora en que se realizó la acción';
-- ck
COMMENT ON CONSTRAINT ck_auditoria_accion ON public.auditoria IS 'Se asegura de que la acción sea una de las permitidas: INSERT, UPDATE, DELETE';
COMMENT ON CONSTRAINT ck_auditoria_update_campos ON public.auditoria IS 'Se asegura de que los campos relacionados con la actualización solo se llenen cuando la acción sea UPDATE';

---------------------------------------------------------

COMMIT;