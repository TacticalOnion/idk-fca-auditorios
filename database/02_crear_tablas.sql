-- TABLAS PADRE
-- Tabla: permiso
CREATE TABLE IF NOT EXISTS public.permiso (
  id_permiso SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  recurso VARCHAR(20) NOT NULL,
  accion VARCHAR(20) NOT NULL,
  alcance VARCHAR(20) NOT NULL,
  descripcion VARCHAR(255) NOT NULL,
  CONSTRAINT pk_permiso PRIMARY KEY (id_permiso),
  CONSTRAINT ck_permiso_accion CHECK (accion IN ('crear', 'leer', 'editar', 'eliminar')),
  CONSTRAINT ck_permiso_alcance CHECK (alcance IN ('global', 'propietario')),
  CONSTRAINT uq_permiso UNIQUE (recurso, accion, alcance)
);
COMMENT ON TABLE public.permiso IS 'Registra los tipos de permisos que puede tener un rol';
COMMENT ON COLUMN public.permiso.id_permiso IS 'Identificador del permiso';
COMMENT ON COLUMN public.permiso.recurso IS 'Recurso al que se le asigna el permiso (por ejemplo: usuario, evento, reservacion, etc.)';
COMMENT ON COLUMN public.permiso.accion IS 'Acción que se permite realizar sobre el recurso (por ejemplo: crear, leer, editar, eliminar)';
COMMENT ON COLUMN public.permiso.alcance IS 'Alcance del permiso (por ejemplo: global, propietario)';
COMMENT ON COLUMN public.permiso.descripcion IS 'Descipcion de la función que otorga al usuario el permiso';
COMMENT ON CONSTRAINT ck_permiso_accion ON public.permiso IS 'Se asegura de que la acción sea una de las permitidas';
COMMENT ON CONSTRAINT ck_permiso_alcance ON public.permiso IS 'Se asegura de que el alcance sea uno de los permitidos';
COMMENT ON CONSTRAINT uq_permiso ON public.permiso IS 'Se asegura de que no haya permisos duplicados para un mismo recurso, acción y alcance';

 -- Tabla: rol_usuario
CREATE TABLE IF NOT EXISTS public.rol_usuario (
  id_rol_usuario SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  CONSTRAINT pk_rol_usuario PRIMARY KEY (id_rol_usuario)
);
COMMENT ON TABLE public.rol_usuario IS 'Registra los tipos de roles que puede tener un usuario';
COMMENT ON COLUMN public.rol_usuario.id_rol_usuario IS 'Identificador del rol de usuario';
COMMENT ON COLUMN public.rol_usuario.nombre IS 'Nombre del rol de usuario';
COMMENT ON CONSTRAINT uq_rol_usuario_nombre ON public.rol_usuario.nombre IS 'Se asegura de que no haya dos roles de usuario con el mismo nombre';

-- Tabla: area
CREATE TABLE IF NOT EXISTS public.area (
  id_area SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(150) NOT NULL UNIQUE,
  nombre_responsable VARCHAR(150) NOT NULL,
  correo_responsable VARCHAR(100) NOT NULL,
  activo BOOLEAN DEFAULT True NOT NULL,
  CONSTRAINT pkArea PRIMARY KEY (id_area)
);
COMMENT ON TABLE public.area IS 'Registra los tipos de area a las que puede pertenecer un usuario';
COMMENT ON COLUMN public.area.id_area IS 'Identificador del area al que pertenece el usuario';
COMMENT ON COLUMN public.area.nombre IS 'Nombre del area';
COMMENT ON COLUMN public.area.nombre_responsable IS 'Nombre del responsable del area';
COMMENT ON COLUMN public.area.correo_responsable IS 'Correo de contacto del responsable';
COMMENT ON COLUMN public.area.activo IS 'Indica si el area esta activa o no';
COMMENT ON CONSTRAINT uq_area_nombre ON public.area.nombre IS 'Se asegura de que no haya dos areas con el mismo nombre';

-- Tabla: rol_participacion
CREATE TABLE IF NOT EXISTS public.rol_participacion (
  id_rol_participacion SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  CONSTRAINT pk_rol_participacion PRIMARY KEY (id_rol_participacion)
);
COMMENT ON TABLE public.rol_participacion IS 'Registra los tipos de roles que puede tener un integrante al participar en un evento';
COMMENT ON COLUMN public.rol_participacion.id_rol_participacion IS 'Rol del integrante al participar en un evento';
COMMENT ON COLUMN public.rol_participacion.nombre IS 'Nombre del rol';
COMMENT ON CONSTRAINT uq_rol_participacion_nombre ON public.rol_participacion.nombre IS 'Se asegura de que no haya dos roles de participacion con el mismo nombre';

-- Tabla: nivel
CREATE TABLE IF NOT EXISTS public.nivel (
  id_nivel SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  siglas VARCHAR(15) NOT NULL UNIQUE,
  CONSTRAINT pk_nivel PRIMARY KEY (id_nivel)
);
COMMENT ON TABLE public.nivel IS 'Nivel de educación de un grado academico, por ejemplo: doctorado, maestría, etc.';
COMMENT ON COLUMN public.nivel.id_nivel IS 'Identificador del nivel de un grado academico';
COMMENT ON COLUMN public.nivel.nombre IS 'Nombre del nivel de un grado academico';
COMMENT ON COLUMN public.nivel.siglas IS 'Siglas del nivel de un grado academico';
COMMENT ON CONSTRAINT uq_nivel_nombre ON public.nivel.nombre IS 'Se asegura de que no haya dos niveles con el mismo nombre';
COMMENT ON CONSTRAINT uq_nivel_siglas ON public.nivel.siglas IS 'Se asegura de que no haya dos niveles con las mismas siglas';

-- Tabla: institucion
CREATE TABLE IF NOT EXISTS public.institucion (
  id_institucion SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  siglas VARCHAR(20) NOT NULL UNIQUE,
  CONSTRAINT pk_institucion PRIMARY KEY (id_institucion)
);
COMMENT ON TABLE public.institucion IS 'Catálogo de instituciones academicas';
COMMENT ON COLUMN public.institucion.id_institucion IS 'Identificador de la institución academica';
COMMENT ON COLUMN public.institucion.nombre IS 'Nombre de la institución academica';
COMMENT ON COLUMN public.institucion.siglas IS 'Siglas del nombre de la institución academica';
COMMENT ON CONSTRAINT uq_institucion_nombre ON public.institucion.nombre IS 'Se asegura de que no haya dos instituciones con el mismo nombre';
COMMENT ON CONSTRAINT uq_institucion_siglas ON public.institucion.siglas IS 'Se asegura de que no haya dos instituciones con las mismas siglas';

-- Tabla: categoria
CREATE TABLE IF NOT EXISTS public.categoria (
  id_categoria SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);
COMMENT ON TABLE public.categoria IS 'Registra las categorias en las que se puede clasificar un evento';
COMMENT ON COLUMN public.categoria.id_categoria IS 'Identificador de la categoria en la que se puede clasificar el evento';
COMMENT ON COLUMN public.categoria.nombre IS 'Nombre de la categoria';
COMMENT ON CONSTRAINT uq_categoria_nombre ON public.categoria.nombre IS 'Se asegura de que no haya dos categorias con el mismo nombre';

-- Tabla: integrante
CREATE TABLE IF NOT EXISTS public.integrante (
  id_integrante INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido_paterno VARCHAR(50) NOT NULL,
  apellido_materno VARCHAR(50) NOT NULL,
  semblanza VARCHAR(512) NULL UNIQUE,
  CONSTRAINT pk_integrante PRIMARY KEY (id_integrante),
  CONSTRAINT uq_integrante_nombre_completo UNIQUE (nombre, apellido_paterno, apellido_materno)
);
COMMENT ON TABLE public.integrante IS 'Registra a los integrantes que participan en los eventos';
COMMENT ON COLUMN public.integrante.id_integrante IS 'Identificador del integrante que participa en al menos un evento';
COMMENT ON COLUMN public.integrante.nombre IS 'Nombre del integrante';
COMMENT ON COLUMN public.integrante.apellido_paterno IS 'Apellido paterno del integrante';
COMMENT ON COLUMN public.integrante.apellido_materno IS 'Apellido materno del integrante';
COMMENT ON COLUMN public.integrante.semblanza IS 'Ruta del archivo pdf donde se almacena la semblanza del integrante';
COMMENT ON CONSTRAINT uq_integrante_nombre_completo ON public.integrante IS 'Se asegura de que no haya dos registros de una misma persona en el catálogo de personas';
COMMENT ON CONSTRAINT uq_integrante_semblanza ON public.integrante.semblanza IS 'Se asegura de que no haya dos integrantes con la misma semblanza';

-- Tabla: pais
CREATE TABLE IF NOT EXISTS public.pais (
  id_pais SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  CONSTRAINT pk_pais PRIMARY KEY (id_pais)
);
COMMENT ON TABLE public.pais IS 'Catálogo de paises';
COMMENT ON COLUMN public.pais.id_pais IS 'Identificador del país';
COMMENT ON COLUMN public.pais.nombre IS 'Nombre del país';
COMMENT ON CONSTRAINT uq_pais_nombre ON public.pais.nombre IS 'Se asegura de que no haya dos paises con el mismo nombre';

-- Tabla: estatus
CREATE TABLE IF NOT EXISTS public.estatus (
  id_estatus SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  CONSTRAINT pk_estatus PRIMARY KEY (id_estatus)
);
COMMENT ON TABLE public.estatus IS 'Catálogo de posibles estados que puede tener una reservación';
COMMENT ON COLUMN public.estatus.id_estatus IS 'Identificador del estatus de una reservación';
COMMENT ON COLUMN public.estatus.nombre IS 'Nombre del estatus';
COMMENT ON CONSTRAINT uq_estatus_nombre ON public.estatus.nombre IS 'Se asegura de que no haya dos estatus con el mismo nombre';

-- Tabla: tipo
CREATE TABLE IF NOT EXISTS public.tipo (
  id_tipo SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  CONSTRAINT pk_tipo PRIMARY KEY (id_tipo)
);
COMMENT ON TABLE public.tipo IS 'Registra los tipos en los que se puede clasificar un recinto';
COMMENT ON COLUMN public.tipo.id_tipo IS 'Identificador del tipo en el que se clasifica un recinto';
COMMENT ON COLUMN public.tipo.nombre IS 'Nombre del recinto';
COMMENT ON CONSTRAINT uq_tipo_nombre ON public.tipo.nombre IS 'Se asegura de que no haya dos tipos de recinto con el mismo nombre';

-- TABLAS PADRE-HIJA
-- Tabla: puesto
CREATE TABLE IF NOT EXISTS public.puesto (
  id_puesto SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  activo BOOLEAN DEFAULT True NOT NULL,
  id_area SMALLINT NOT NULL,
  CONSTRAINT pk_puesto PRIMARY KEY (id_puesto),
  CONSTRAINT fk_area FOREIGN KEY (id_area) REFERENCES public.area (id_area) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.puesto IS 'Registra los tipos de puesto que puede tener un usuario';
COMMENT ON COLUMN public.puesto.id_puesto IS 'Identificador del puesto en la facultad que ocupa el usuario';
COMMENT ON COLUMN public.puesto.nombre IS 'Nombre del puesto';
COMMENT ON COLUMN public.puesto.activo IS 'Indica si el puesto esta activo o no';
COMMENT ON COLUMN public.puesto.id_area IS 'Identificador del area al que pertenece el puesto';
COMMENT ON CONSTRAINT uq_puesto_nombre ON public.puesto.nombre IS 'Se asegura de que no haya dos puestos con el mismo nombre';

-- Tabla: usuario
CREATE TABLE IF NOT EXISTS public.usuario (
  id_usuario SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  foto_usuario VARCHAR(512) NOT NULL DEFAULT '/usuarios/foto_usuario_default.png',
  nombre_usuario VARCHAR(100) NOT NULL UNIQUE,
  rfc CHAR(13) NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL,
  apellido_paterno VARCHAR(50) NOT NULL,
  apellido_materno VARCHAR(50) NOT NULL,
  contrasenia CHAR(64) NOT NULL,
  telefono CHAR(10) NOT NULL UNIQUE,
  celular CHAR(10) NOT NULL UNIQUE,
  correo VARCHAR(100) NOT NULL UNIQUE,
  activo BOOLEAN DEFAULT True NOT NULL,
  id_rol_usuario SMALLINT NOT NULL,
  id_puesto SMALLINT NOT NULL,
  CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
  CONSTRAINT fk_rol_usuario FOREIGN KEY (id_rol_usuario) REFERENCES public.rol_usuario (id_rol_usuario) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_puesto FOREIGN KEY (id_puesto) REFERENCES public.puesto (id_puesto) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.usuario IS 'Registra los usuarios del sistema de gestión de recintos';
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
COMMENT ON COLUMN public.usuario.id_rol_usuario IS 'Identificador del rol del usuario';
COMMENT ON COLUMN public.usuario.id_puesto IS 'Identificador del puesto del usuario';
COMMENT ON CONSTRAINT uq_usuario_nombre_usuario ON public.usuario.nombre_usuario IS 'Se asegura de que no haya dos usuarios con el mismo nombre de usuario';
COMMENT ON CONSTRAINT uq_usuario_rfc ON public.usuario.rfc IS 'Se asegura de que no haya dos usuarios con el mismo RFC';
COMMENT ON CONSTRAINT uq_usuario_telefono ON public.usuario.telefono IS 'Se asegura de que no haya dos usuarios con el mismo telefono';
COMMENT ON CONSTRAINT uq_usuario_celular ON public.usuario.celular IS 'Se asegura de que no haya dos usuarios con el mismo celular';
COMMENT ON CONSTRAINT uq_usuario_correo ON public.usuario.correo IS 'Se asegura de que no haya dos usuarios con el mismo correo';

-- Tabla: evento
CREATE TABLE IF NOT EXISTS public.evento (
  id_evento INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  descripcion VARCHAR(500) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  horario_inicio TIME NULL,
  horario_fin TIME NULL,
  presencial BOOLEAN DEFAULT False NOT NULL,
  online BOOLEAN DEFAULT False NOT NULL,
  motivo VARCHAR(500) NULL,
  mega_evento BOOLEAN DEFAULT False NOT NULL,
  id_estatus SMALLINT NOT NULL,
  id_categoria SMALLINT NOT NULL,
  id_mega_evento INTEGER NULL,
  CONSTRAINT pk_evento PRIMARY KEY (id_evento),
  CONSTRAINT fk_estatus FOREIGN KEY (id_estatus) REFERENCES public.estatus (id_estatus) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria (id_categoria) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_mega_evento FOREIGN KEY (id_mega_evento) REFERENCES public.evento (id_evento) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_rango_fechas CHECK (fecha_inicio <= fecha_fin),
  CONSTRAINT ck_rango_horarios CHECK (horario_inicio < horario_fin),
  CONSTRAINT ck_horario_laboral CHECK (horario_inicio >= '07:00' AND horario_fin <= '22:00'),
  CONSTRAINT ck_duracion_evento CHECK (fecha_inicio <> fecha_fin OR (horario_fin - horario_inicio) >= INTERVAL '30 minutes')
);
COMMENT ON TABLE public.evento IS 'Registra los eventos academicos organizados en la facultad';
COMMENT ON COLUMN public.evento.id_evento IS 'Identificador del evento';
COMMENT ON COLUMN public.evento.nombre IS 'Nombre del evento';
COMMENT ON COLUMN public.evento.descripcion IS 'Descripción del evento';
COMMENT ON COLUMN public.evento.fecha_inicio IS 'Fecha de inicio del evento';
COMMENT ON COLUMN public.evento.fecha_fin IS 'Fecha de fin del evento';
COMMENT ON COLUMN public.evento.horario_inicio IS 'Hora de inicio del evento';
COMMENT ON COLUMN public.evento.horario_fin IS 'Hora de fin del evento';
COMMENT ON COLUMN public.evento.presencial IS 'Indica si el evento es de modalidad presencial';
COMMENT ON COLUMN public.evento.online IS 'Indica si el evento es de modalidad online';
COMMENT ON COLUMN public.evento.motivo IS 'Motivo de rechazo de la solicitud de evento';
COMMENT ON COLUMN public.evento.mega_evento IS 'Indica si el evento es un mega evento (que agrupa otros eventos)';
COMMENT ON COLUMN public.evento.id_estatus IS 'Identificador del estatus de la aprobación del evento';
COMMENT ON COLUMN public.evento.id_categoria IS 'Identificador de la categoria en la que se clasifica el evento';
COMMENT ON COLUMN public.evento.id_mega_evento IS 'Identificador del evento al que pertenece el evento. Sirve para casos en donde un evento agrupa otros eventos';
COMMENT ON CONSTRAINT uq_evento_nombre ON public.evento.nombre IS 'Se asegura de que no haya dos eventos con el mismo nombre';
COMMENT ON CONSTRAINT ck_rango_fechas ON public.evento IS 'Se asegura de que la fecha de inicio no sea posterior a la fecha de fin';
COMMENT ON CONSTRAINT ck_rango_horarios ON public.evento IS 'Se asegura de que la hora de inicio sea anterior a la hora de fin';
COMMENT ON CONSTRAINT ck_horario_laboral ON public.evento IS 'Se asegura de que el evento se realice dentro del horario laboral (07:00 a 22:00)';
COMMENT ON CONSTRAINT ck_duracion_evento ON public.evento IS 'Se asegura de que el evento tenga una duración mínima de 30 minutos si es en un solo día';

-- Tabla: grado
CREATE TABLE IF NOT EXISTS public.grado (
  id_grado SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  id_nivel SMALLINT NOT NULL,
  id_institucion SMALLINT NOT NULL,
  id_pais SMALLINT NOT NULL,
  CONSTRAINT pk_grado PRIMARY KEY (id_grado),
  CONSTRAINT fk_nivel FOREIGN KEY (id_nivel) REFERENCES public.nivel (id_nivel) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_institucion FOREIGN KEY (id_institucion) REFERENCES public.institucion (id_institucion) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_pais FOREIGN KEY (id_pais) REFERENCES public.pais (id_pais) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.grado IS 'Describe los tipos de grado que pueden tener los integrantes al participar en los eventos';
COMMENT ON COLUMN public.grado.id_grado IS 'Identificador del grado academico del integrante que participa en al menos un evento';
COMMENT ON COLUMN public.grado.titulo IS 'Titulo del grado academico';
COMMENT ON COLUMN public.grado.id_nivel IS 'Nivel del grado academico';
COMMENT ON COLUMN public.grado.id_institucion IS 'Institución que emitió el grado academico';
COMMENT ON COLUMN public.grado.id_pais IS 'Pais en el que se emitió el grado academico';

-- Tabla: equipamiento
CREATE TABLE IF NOT EXISTS public.equipamiento (
  id_equipamiento SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  activo BOOLEAN DEFAULT False NOT NULL,
  id_area SMALLINT NULL,
  CONSTRAINT pk_equipamiento PRIMARY KEY (id_equipamiento),
  CONSTRAINT fk_area FOREIGN KEY (id_area) REFERENCES public.area (id_area) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_activo_id_area CHECK (NOT activo OR id_area IS NOT NULL)
);
COMMENT ON TABLE public.equipamiento IS 'Equipamiento solicitado o con el que cuenta la facultad para atender un evento';
COMMENT ON COLUMN public.equipamiento.id_equipamiento IS 'Identificador del equipamiento';
COMMENT ON COLUMN public.equipamiento.nombre IS 'Nombre del equipamiento';
COMMENT ON COLUMN public.equipamiento.activo IS 'Indica si el equipamiento esta activo o no';
COMMENT ON COLUMN public.equipamiento.id_area IS 'Identificador del area que esta a cargo del equipamiento';
COMMENT ON CONSTRAINT uq_equipamiento_nombre ON public.equipamiento.nombre IS 'Se asegura de que no haya dos equipamientos con el mismo nombre';
COMMENT ON CONSTRAINT ck_activo_id_area ON public.equipamiento IS 'Se asegura de que si el equipamiento esta activo, entonces debe tener un area asignada';

-- Tabla: recinto
CREATE TABLE IF NOT EXISTS public.recinto (
  id_recinto SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  latitud NUMERIC(9,6) NOT NULL,
  longitud NUMERIC(9,6) NOT NULL,
  aforo SMALLINT NOT NULL CHECK (aforo > 0),
  croquis VARCHAR(512) NOT NULL,
  activo BOOLEAN DEFAULT True NOT NULL,
  id_tipo SMALLINT NOT NULL,
  CONSTRAINT pk_recinto PRIMARY KEY (id_recinto),
  CONSTRAINT fk_tipo FOREIGN KEY (id_tipo) REFERENCES public.tipo (id_tipo) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_recinto_latitud CHECK (latitud BETWEEN -90 AND 90),
  CONSTRAINT ck_recinto_longitud CHECK (longitud BETWEEN -180 AND 180)
);
COMMENT ON TABLE public.recinto IS 'Registra los recintos de la facultad que son usados para eventos academicos';
COMMENT ON COLUMN public.recinto.id_recinto IS 'Identificador del recinto';
COMMENT ON COLUMN public.recinto.nombre IS 'Nombre del recinto';
COMMENT ON COLUMN public.recinto.latitud IS 'Latitud en el que se encuentra ubicado geograficamente el recinto';
COMMENT ON COLUMN public.recinto.longitud IS 'Longitud en el que se encuentra ubicado geograficamente el recinto';
COMMENT ON COLUMN public.recinto.aforo IS 'Capacidad maxima de personas que pueden estar en el recinto';
COMMENT ON COLUMN public.recinto.croquis IS 'Ruta al archivo que almacena el croquis que muestra como llegar al recinto';
COMMENT ON COLUMN public.recinto.activo IS 'Indica si el recinto esta activo o no';
COMMENT ON COLUMN public.recinto.id_tipo IS 'Identificador del tipo en el que se clasifica el recinto';
COMMENT ON CONSTRAINT uq_recinto_nombre ON public.recinto.nombre IS 'Se asegura de que no haya dos recintos con el mismo nombre';
COMMENT ON CONSTRAINT ck_recinto_latitud ON public.recinto IS 'Se asegura de que la latitud este en el rango valido de -90 a 90';
COMMENT ON CONSTRAINT ck_recinto_aforo ON public.recinto IS 'Se asegura de que el aforo sea un valor positivo mayor a cero';
COMMENT ON CONSTRAINT ck_recinto_longitud ON public.recinto IS 'Se asegura de que la longitud este en el rango valido de -180 a 180';

-- TABLAS HIJA
-- Tabla: rolxpermiso
CREATE TABLE IF NOT EXISTS public.rolxpermiso (
  id_rol_usuario SMALLINT NOT NULL,
  id_permiso SMALLINT NOT NULL,
  CONSTRAINT pk_rolxpermiso PRIMARY KEY (id_rol_usuario, id_permiso),
  CONSTRAINT fk_rol_usuario FOREIGN KEY (id_rol_usuario) REFERENCES public.rol_usuario (id_rol_usuario) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_permiso FOREIGN KEY (id_permiso) REFERENCES public.permiso (id_permiso) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.rolxpermiso IS 'Registra los permisos que tienen cada uno de los roles';
COMMENT ON COLUMN public.rolxpermiso.id_rol_usuario IS 'Identificador del rol al que se asignara el permiso';
COMMENT ON COLUMN public.rolxpermiso.id_permiso IS 'Identificador del permiso al que se asignara al usuario';

-- Tabla: evento_organizador
CREATE TABLE IF NOT EXISTS public.evento_organizador (
  id_evento INTEGER NOT NULL,
  id_usuario SMALLINT NOT NULL,
  CONSTRAINT pk_evento_organizador PRIMARY KEY (id_evento, id_usuario),
  CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento (id_evento) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario (id_usuario) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.evento_organizador IS 'Registra todos los eventos organizados por el usuario';
COMMENT ON COLUMN public.evento_organizador.id_evento IS 'Identificador del evento organizado por el usuario';
COMMENT ON COLUMN public.evento_organizador.id_usuario IS 'Identificador del usuario que organizo ese evento';

-- Tabla: participacion
CREATE TABLE IF NOT EXISTS public.participacion (
  id_evento INTEGER NOT NULL,
  id_integrante INTEGER NOT NULL,
  id_rol_participacion SMALLINT NOT NULL,
  CONSTRAINT pk_participacion PRIMARY KEY (id_evento, id_integrante, id_rol_participacion),
  CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento (id_evento) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_integrante FOREIGN KEY (id_integrante) REFERENCES public.integrante (id_integrante) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_rol_participacion FOREIGN KEY (id_rol_participacion) REFERENCES public.rol_participacion (id_rol_participacion) ON UPDATE CASCADE ON DELETE RESTRICT);
COMMENT ON TABLE public.participacion IS 'Registra las participaciones que tienen los integrantes en cada uno de los eventos';
COMMENT ON COLUMN public.participacion.id_evento IS 'Identificador del evento';
COMMENT ON COLUMN public.participacion.id_integrante IS 'Identificador del integrante que participa en el evento';
COMMENT ON COLUMN public.participacion.id_rol_participacion IS 'Identificador del rol del integrante al participar en el evento';

-- Tabla: integrantexgrado
CREATE TABLE IF NOT EXISTS public.integrantexgrado (
  id_integrante INTEGER NOT NULL,
  id_grado SMALLINT NOT NULL,
  CONSTRAINT pk_integrante_x_grado PRIMARY KEY (id_integrante, id_grado),
  CONSTRAINT fk_integrante FOREIGN KEY (id_integrante) REFERENCES public.integrante (id_integrante) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_grado FOREIGN KEY (id_grado) REFERENCES public.grado (id_grado) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.integrantexgrado IS 'Registra los grados que tienen cada uno de los integrantes';
COMMENT ON COLUMN public.integrantexgrado.id_integrante IS 'Identificador del integrante que participa en al menos un evento';
COMMENT ON COLUMN public.integrantexgrado.id_grado IS 'Identificador del grado academico del integrante';

-- Tabla: reservacion
CREATE TABLE IF NOT EXISTS public.reservacion (
  id_evento INTEGER NOT NULL,
  id_recinto SMALLINT NOT NULL,
  fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  numero_solicitud INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE CHECK (numero_solicitud > 0),
  motivo VARCHAR(500) NULL,
  id_estatus SMALLINT NOT NULL,
  CONSTRAINT pk_reservacion PRIMARY KEY (id_evento, id_recinto),
  CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento (id_evento) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_recinto FOREIGN KEY (id_recinto) REFERENCES public.recinto (id_recinto) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_estatus FOREIGN KEY (id_estatus) REFERENCES public.estatus (id_estatus) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.reservacion IS 'Registra las reservaciones (incluidas solicitudes rechazadas o aún no aprobadas) de recintos que hacen cada uno de los eventos de la facultad';
COMMENT ON COLUMN public.reservacion.id_evento IS 'Identificador del evento que realiza la reservación';
COMMENT ON COLUMN public.reservacion.id_recinto IS 'Identificador del recinto que se desea reservar';
COMMENT ON COLUMN public.reservacion.fecha_solicitud IS 'Fecha y hora en la que se realizó la solicitud de reservación';
COMMENT ON COLUMN public.reservacion.numero_solicitud IS 'Numero de solicitud de la reservación';
COMMENT ON COLUMN public.reservacion.motivo IS 'Motivo de rechazo de la solicitud de reservación';
COMMENT ON COLUMN public.reservacion.id_estatus IS 'Identificador del estatus de la solicitud de reservación';

-- Tabla: reservacionxequipamiento
CREATE TABLE IF NOT EXISTS public.reservacionxequipamiento (
  id_evento INTEGER NOT NULL,
  id_recinto INTEGER NOT NULL,
  id_equipamiento SMALLINT NOT NULL,
  cantidad SMALLINT NOT NULL CHECK (cantidad >= 0),
  CONSTRAINT pk_reservacion_x_equipamiento PRIMARY KEY (id_evento, id_recinto, id_equipamiento),
  CONSTRAINT fk_reservacion FOREIGN KEY (id_evento,id_recinto) REFERENCES public.reservacion (id_evento,id_recinto) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_equipamiento FOREIGN KEY (id_equipamiento) REFERENCES public.equipamiento (id_equipamiento) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.reservacionxequipamiento IS 'Registra el equipamiento solicitado en cada una de las reservaciones';
COMMENT ON COLUMN public.reservacionxequipamiento.id_evento IS 'Identificador del evento';
COMMENT ON COLUMN public.reservacionxequipamiento.id_recinto IS 'Identificador del recinto en el que se realizara el evento';
COMMENT ON COLUMN public.reservacionxequipamiento.id_equipamiento IS 'Identificador del equipamiento que se solicita para el evento';
COMMENT ON COLUMN public.reservacionxequipamiento.cantidad IS 'Cantidad del equipamiento solicitado para el evento';
COMMENT ON CONSTRAINT ck_reservacionxequipamiento_cantidad ON public.reservacionxequipamiento IS 'Se asegura de que la cantidad solicitada sea un valor positivo mayor o igual a cero';

-- Tabla: area_inventario
CREATE TABLE IF NOT EXISTS public.area_inventario (
  id_area SMALLINT NOT NULL,
  id_equipamiento SMALLINT NOT NULL,
  cantidad SMALLINT NOT NULL CHECK (cantidad >= 0),
  CONSTRAINT pk_area_inventario PRIMARY KEY (id_area, id_equipamiento),
  CONSTRAINT fk_equipamiento FOREIGN KEY (id_equipamiento) REFERENCES public.equipamiento (id_equipamiento) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_area FOREIGN KEY (id_area) REFERENCES public.area (id_area) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.area_inventario IS 'Inventario de equipamiento de cada area';
COMMENT ON COLUMN public.area_inventario.id_area IS 'Identificador del area al que pertenece el equipamiento registrado en el inventario';
COMMENT ON COLUMN public.area_inventario.id_equipamiento IS 'Identificador del equipamiento que se regitra en el inventario';
COMMENT ON COLUMN public.area_inventario.cantidad IS 'Cantidad del equipamiento';
COMMENT ON CONSTRAINT ck_area_inventario_cantidad ON public.area_inventario IS 'Se asegura de que la cantidad registrada sea un valor positivo mayor o igual a cero';

-- Tabla: recinto_inventario
CREATE TABLE IF NOT EXISTS public.recinto_inventario (
  id_recinto SMALLINT NOT NULL,
  id_equipamiento SMALLINT NOT NULL,
  cantidad SMALLINT NOT NULL CHECK (cantidad >= 0),
  CONSTRAINT pk_recinto_inventario PRIMARY KEY (id_recinto, id_equipamiento),
  CONSTRAINT fk_recinto FOREIGN KEY (id_recinto) REFERENCES public.recinto (id_recinto) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_equipamiento FOREIGN KEY (id_equipamiento) REFERENCES public.equipamiento (id_equipamiento) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.recinto_inventario IS 'Invetario de equipamiento de los recintos';
COMMENT ON COLUMN public.recinto_inventario.id_recinto IS 'Identificador del recinto al que se le registrara su inventario de equipamiento';
COMMENT ON COLUMN public.recinto_inventario.id_equipamiento IS 'Identificador del equipamiento que sera registrado en el inventario';
COMMENT ON COLUMN public.recinto_inventario.cantidad IS 'Cantidad de equipamiento';
COMMENT ON CONSTRAINT ck_recinto_inventario_cantidad ON public.recinto_inventario IS 'Se asegura de que la cantidad registrada sea un valor positivo mayor o igual a cero';

-- Tabla: fotografia
CREATE TABLE IF NOT EXISTS public.fotografia (
  id_fotografia SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL,
  fotografia VARCHAR(512) NOT NULL UNIQUE,
  id_recinto SMALLINT NOT NULL,
  CONSTRAINT pk_fotografia PRIMARY KEY (id_fotografia),
  CONSTRAINT fk_recinto FOREIGN KEY (id_recinto) REFERENCES public.recinto (id_recinto) ON UPDATE CASCADE ON DELETE RESTRICT
);
COMMENT ON TABLE public.fotografia IS 'Registra las rutas donde estan almacenadas las fotografias de cada recinto';
COMMENT ON COLUMN public.fotografia.id_fotografia IS 'Identificador de la fotografia del recinto';
COMMENT ON COLUMN public.fotografia.fotografia IS 'Ruta del archivo que almacena la fotografia del recinto';
COMMENT ON COLUMN public.fotografia.id_recinto IS 'Identificador del recinto al que pertenece la fotografia';
COMMENT ON CONSTRAINT uq_fotografia_fotografia ON public.fotografia.fotografia IS 'Se asegura de que un recinto tenga las mismas fotografias';

-- Roles
-- DO $$ BEGIN IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'app_owner') THEN CREATE ROLE app_owner NOLOGIN; END IF; END $$;
-- COMMENT ON ROLE app_owner IS Rol dueño de objetos (DDL/migraciones). Propietario del esquema y tablas.;
-- DO $$ BEGIN IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'app_rw') THEN CREATE ROLE app_rw NOLOGIN; END IF; END $$;
-- COMMENT ON ROLE app_rw IS Rol de lectura/escritura (CRUD) usado por la aplicación en producción.;
-- DO $$ BEGIN IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'app_srv') THEN CREATE ROLE app_srv LOGIN; END IF; END $$;
-- COMMENT ON ROLE app_srv IS Cuenta de servicio de la aplicación (usa este usuario Spring Boot).;
-- DO $$ BEGIN IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'app_migrator') THEN CREATE ROLE app_migrator LOGIN; END IF; END $$;
-- COMMENT ON ROLE app_migrator IS Cuenta de migraciones (Flyway/Liquibase), puede crear/alterar objetos.;

-- Permisos
-- GRANT app_rw TO app_srv;
-- GRANT app_owner TO app_migrator;
-- REVOKE USAGE, CREATE ON SCHEMA public FROM PUBLIC;
-- GRANT USAGE, CREATE ON SCHEMA public TO app_owner;
-- GRANT USAGE ON SCHEMA public TO app_rw;
-- GRANT ALL ON ALL TABLES IN SCHEMA public TO app_owner;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_rw;
-- GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO app_owner;
-- GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO app_rw;
-- ALTER DEFAULT PRIVILEGES FOR ROLE app_owner IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO app_rw;
-- ALTER DEFAULT PRIVILEGES FOR ROLE app_owner IN SCHEMA public GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO app_rw;

-- Required for EXCLUDE constraints using '=' with GiST
CREATE EXTENSION IF NOT EXISTS btree_gist;
