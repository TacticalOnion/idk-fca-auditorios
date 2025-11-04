SET client_encoding to 'UTF8';
BEGIN;

---------------------------------------------------------
-- TABLAS PADRE
---------------------------------------------------------
-- permiso
---------------------------------------------------------
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
/*
    Recurso: usuario
    Descripcion:
        Usuarios del sistema
    Tablas involucradas:
        - usuario
    Notas:
        - Los superadministradores pueden gestionar cualquier tipo de usuario
        - Los administradores solo pueden gestionar funcionarios
        - Todos los usuarios pueden leer los datos de su usuario
            - Los funcionarios y administradores no pueden editar:
                - rol de usuario
                - puesto
                - activo
*/    
    ('usuario','crear','global','Crear usuario'),
    ('usuario','leer','global','Listar usuarios'),
    ('usuario','editar','global','Editar usuarios'),
    ('usuario','eliminar','global','Eliminar usuarios'),
    ('usuario','activar_desactivar','global','Activar o desactivar usuarios'),
    ('usuario','resetear_contrasenia','global','Resetear contraseña de usuarios'),

    ('usuario','leer','propietario','Leer datos de usuario propio'),
    ('usuario','editar_perfil','propietario','Editar los datos de perfil propio'),
    ('usuario','resetear_contrasenia','propietario','Cambiar contraseña propia'),

/*
    Recurso: organigrama
    Descripcion:
        Organigrama de la facultad a la que pertenecen los usuarios 
    Tablas involucradas:
        - puesto
        - area
        - responsable_area
    Notas:
        - Los superadministradores gestionan el organigrama
        - Los administradores y funcionarios solo lo pueden leer
*/
    ('organigrama','crear','global','Crear puestos, areas y responsables de area'),
    ('organigrama','leer','global','Listar puestos, areas y responsables de area'),
    ('organigrama','editar','global','Editar puestos, areas y responsables de area'),
    ('organigrama','eliminar','global','Eliminar puestos, areas y responsables de area'),

/*
    Recurso: Calendario escolar
    Descripcion:
        Calendario escolar que rige los eventos
    Tablas involucradas:
        - calendario_escolar
        - periodo
    Notas:
        - Solo el super administrador puede gestionar el calendario escolar
        - No se puede editar ni borrar para evitar problemas de consistencia
*/
    ('calendario_escolar','crear','global','Crear calendarios escolares y periodos'),
    ('calendario_escolar','leer','global','Listar calendarios escolares y periodos'),
    
/*
    Recurso: evento
    Descripcion:
        Eventos academicos de la facultad
    Tablas involucradas:
        - evento
        - participacion
        - reservacion
        - eventoxequipamiento
        - equipamiento
    Notas:
        - Solo los funcionarios pueden crear eventos
        - Solo los administradores pueden autorizar eventos
            - Implica cambiar estatus y motivo
        - Los funcionarios solo pueden gestionar sus propios eventos
        - Los funcionarios pueden solicitar equipamiento que no existe en el catalogo
*/

    ('evento','crear','global','Crear eventos'),
    ('evento','leer','global','Listar eventos'),
    ('evento','autorizar','global','Autorizar eventos'),

    ('evento','corregir','propietario','Corregir eventos'),
    ('evento','leer','propietario','Listar eventos propios'),
    ('evento','eliminar','propietario','Eliminar eventos propios'),
    ('evento','cancelar','propietario','Cancelar eventos propios'),

/*
    Recurso: ponente
    Descripcion:
        Ponentes que participan en los eventos
    Tablas involucradas:
        - ponente
        - semblanza
        - semblanzaxreconocimiento
        - reconocimiento
        - semblanzaxexperiencia
        - experiencia
        - semblanzaxgrado
        - grado
        - empresa
        - institucion
    Notas:
        - Solo los funcionarios pueden agregar ponentes
        - Los ponentes solo permanecen a la base de datos si participan
          en un evento autorizado
        - Una vez un ponente participa en un evento autorizado solo se le 
          pueden agregar grados, experiencia y reconocimientos, no se puede
          eliminar ni editar
*/

    ('ponente','crear','global','Crear ponentes y sus datos asociados'),
    ('ponente','leer','global','Listar ponentes y sus datos asociados'),
    ('ponente','agregar_datos','global','Agregar grados, experiencias y reconocimientos a ponentes existentes'),
    ('ponente','editar_biografia','global','Editar biografía de ponentes asociados a eventos propios'),

/*
    Recurso: recinto
    Descripcion:
        Recintos de la facultad utilizados para eventos académicos
    Tablas involucradas:
        - recinto
        - fotografia
    Notas:
        - Solo los superadministradores pueden gestionar recintos
        - Los administradores y funcionarios solo pueden leer recintos
        - No se puede editar ni borrar para evitar problemas de consistencia
*/

    ('recinto','crear','global','Crear recintos'),
    ('recinto','leer','global','Listar recintos'),
    ('recinto','editar_fotografia','global','Editar fotografía de recintos'),

/*
    Recurso: equipamiento
    Descripcion:
        Catalogos de equipamiento usados para eventos academicos o propios del recinto
    Tablas involucradas:
        - equipamiento
    Notas:
        - Los administradores pueden gestionar el catálogo de equipamiento
        - Los funcionarios pueden leer y agregar equipamiento no existente al catálogo
            - Cuando un funcionario agrega equipamiento nuevo, este queda inactivo hasta que un administrador lo active
        - No se puede editar ni borrar para evitar problemas de consistencia
        - Se puede activar o desactivar el equipamiento en el catálogo
            - Siempre que no esté asociado a un evento autorizado
*/
    ('equipamiento','crear','global','Crear equipamiento'),
    ('equipamiento','leer','global','Listar equipamiento'),
    ('equipamiento','activar_desactivar','global','Activar o desactivar equipamiento'),
    ('equipamiento','actualizar_inventario','global','Actualizar inventario de equipamiento'),
    ('equipamiento','editar_area','global','Editar área responsable del equipamiento'),

    ('equipamiento','solicitar','propietario','Solicitar equipamiento no existente en el catálogo'),
    ('equipamiento','leer','propietario','Listar equipamiento solicitado en el catálogo');

---------------------------------------------------------
-- rol_usuario
---------------------------------------------------------
INSERT INTO public.rol_usuario (nombre)
VALUES 
    ('superadministrador'),
    ('administrador'),
    ('funcionario');

---------------------------------------------------------
-- responsable_area
---------------------------------------------------------
INSERT INTO public.responsable_area (nombre,apellido_paterno,apellido_materno,correo)
VALUES
    ('Juan','Pérez','Gómez','juan.perez@fca.unam.mx'),
    ('María','López','Hernández','maria.lopez@fca.unam.mx'),
    ('Carlos','Martínez','Ramírez','carlos.martinez@fca.unam.mx'),
    ('Ana','García','Sánchez','ana.garcia@fca.unam.mx'),
    ('Luis','Rodríguez','Torres','luis.rodriguez@fca.unam.mx');

---------------------------------------------------------
-- nivel
---------------------------------------------------------
INSERT INTO public.nivel (nombre,siglas,jerarquia)
VALUES
    ('Técnico Superior Universitario', 'TSU', 1),
        ('Licenciatura', 'Lic', 2),
        ('Ingeniería', 'Ing', 2),
        ('Especialidad', 'Esp', 3),
        ('Maestría', 'Mtr', 4),
        ('Doctorado', 'Dr', 5),
        ('Posdoctorado', 'PDr', 6);

---------------------------------------------------------
-- institucion
---------------------------------------------------------
INSERT INTO public.institucion (nombre, siglas)
VALUES
    -- México
    ('Universidad Nacional Autónoma de México', 'UNAM'),
    ('Instituto Politécnico Nacional', 'IPN'),
    ('Universidad del Valle de México', 'UVM'),
    ('Universidad Autónoma de Guadalajara', 'UAG'),
    ('Instituto Tecnológico y de Estudios Superiores de Monterrey', 'ITESM'),
    ('Universidad Anáhuac', 'ANÁHUAC'),
    ('Universidad Iberoamericana', 'IBERO'),
    ('Benemérita Universidad Autónoma de Puebla', 'BUAP'),
    ('Universidad Autónoma Metropolitana', 'UAM'),
    ('Universidad Autónoma del Estado de México', 'UAEMex'),
    ('Universidad de las Américas Puebla', 'UDLAP'),
    ('Universidad Autónoma de Nuevo León', 'UANL'),
    ('Universidad de Guadalajara', 'UDG'),
    ('Universidad Autónoma de Baja California', 'UABC'),
    ('Universidad Veracruzana', 'UV'),
    ('Universidad Autónoma de Querétaro', 'UAQ'),
    ('Universidad Autónoma de San Luis Potosí', 'UASLP'),
    ('Universidad Autónoma de Chihuahua', 'UACH'),
    ('Universidad Autónoma de Coahuila', 'UAdeC'),
    ('Universidad Autónoma de Sinaloa', 'UAS'),
    ('Universidad Autónoma de Nayarit', 'UAN'),
    ('Universidad Autónoma de Yucatán', 'UADY'),
    ('Universidad de Sonora', 'UNISON'),
    ('Universidad Autónoma del Estado de Hidalgo', 'UAEH'),
    ('Universidad Autónoma de Zacatecas', 'UAZ'),
    ('Universidad Autónoma de Tamaulipas', 'UAT'),
    ('Universidad Autónoma de Baja California Sur', 'UABCS'),
    ('Universidad Autónoma de Campeche', 'UACAM'),
    ('Universidad Autónoma de Ciudad Juárez', 'UACJ'),
    ('Universidad Autónoma de Aguascalientes', 'UAA'),
    ('Universidad Autónoma de Guerrero', 'UAGro'),
    ('Universidad Autónoma de Tlaxcala', 'UATx'),
    ('Universidad Autónoma del Carmen', 'UNACAR'),
    ('Universidad de Colima', 'UCOL'),
    ('Universidad Autónoma de Chiapas', 'UNACH'),
    ('Universidad Juárez del Estado de Durango', 'UJED'),
    ('Universidad Michoacana de San Nicolás de Hidalgo', 'UMSNH'),
    ('Universidad Autónoma de Morelos', 'UAEM'),
    ('Universidad Tecnológica de México', 'UNITEC'),
    ('Universidad La Salle', 'ULSA'),
    ('Universidad Panamericana', 'UP'),
    ('Universidad del Valle de Atemajac', 'UNIVA'),
    ('Centro de Investigación y de Estudios Avanzados del IPN', 'CINVESTAV'),
    ('El Colegio de México', 'COLMEX'),
    ('Centro de Enseñanza Técnica y Superior', 'CETYS'),
    ('Universidad Autónoma Chapingo', 'UACh'),
    ('Universidad Autónoma Agraria Antonio Narro', 'UAAAN'),
    ('Universidad Pedagógica Nacional', 'UPN'),
    ('Universidad Tecnológica de León', 'UTL'),
    ('Universidad Tecnológica de Puebla', 'UTP'),
    ('Instituto Tecnológico Autónomo de México', 'ITAM'),
    ('Instituto Tecnológico de Estudios Superiores de Occidente', 'ITESO'),
    ('Universidad Autónoma del Estado de Quintana Roo', 'UQROO'),
    ('Universidad de Monterrey', 'UDEM'),
    ('Universidad del Mar', 'UMAR'),
    ('Universidad del Istmo', 'UNISTMO'),
    ('Universidad de Guanajuato', 'UGTO'),
    ('Universidad Autónoma de Oaxaca Benito Juárez', 'UABJO'),
    ('Universidad Politécnica de Querétaro', 'UPQ'),
    ('Universidad Politécnica de Pachuca', 'UPP'),
    ('Universidad Politécnica de San Luis Potosí', 'UPSLP'),
    ('Universidad Politécnica de Tlaxcala', 'UPTx'),
    ('Universidad Tecnológica de Cancún', 'UTCANCUN'),
    ('Universidad Tecnológica de Querétaro', 'UTEQ'),
    ('Universidad Tecnológica Metropolitana', 'UTM'),
    ('Universidad Politécnica Metropolitana de Hidalgo', 'UPMH'),
    ('Universidad Intercultural del Estado de México', 'UIEM'),
    ('Universidad Politécnica de Chiapas', 'UPCH'),
    ('Universidad Tecnológica del Valle de Toluca', 'UTVT'),
    ('Universidad Tecnológica del Sur del Estado de México', 'UTSEM'),
    ('Universidad Tecnológica del Estado de Zacatecas', 'UTZAC'),
    ('Universidad Tecnológica de Tula-Tepeji', 'UTTT'),
    ('Universidad Tecnológica de Nezahualcóyotl', 'UTN'),
    ('Universidad Tecnológica de la Huasteca Hidalguense', 'UTHH'),
    ('Universidad Tecnológica de Tabasco', 'UTTAB'),
    ('Universidad Tecnológica de San Juan del Río', 'UTSJR'),
    ('Universidad Tecnológica de la Selva', 'UTSELVA'),
    ('Universidad Politécnica de Puebla', 'UPPUE'),
    ('Universidad Tecnológica de Morelia', 'UTMOR'),
    ('Universidad Politécnica del Valle de México', 'UPVM'),
    ('Universidad Tecnológica de Aguascalientes', 'UTAGS'),
    ('Universidad Politécnica de Santa Rosa Jáuregui', 'UPSRJ'),
    ('Universidad Tecnológica de Tehuacán', 'UTTEHU'),
    ('Universidad Politécnica del Estado de Morelos', 'UPEMOR'),
    ('Universidad Tecnológica del Valle de Mezquital', 'UTVM'),
    ('Universidad Tecnológica de Hermosillo', 'UTH'),
    ('Universidad Tecnológica de Xicotepec de Juárez', 'UTXJ'),
    -- República Dominicana 
    ('Universidad Autónoma de Santo Domingo', 'UASD'),
    -- Colombia
    ('Universidad Nacional de Colombia', 'UNAL'),
    -- Japón
    ('Universidad de Tokio', 'UTokyo'),
    -- Canadá
    ('Universidad de Toronto', 'UofT'),
    -- Estados Unidos
    ('Universidad de Harvard', 'Harvard');

---------------------------------------------------------
-- reconocimiento
---------------------------------------------------------
INSERT INTO public.reconocimiento (titulo, organizacion, anio, descripcion) VALUES
    -- Administración
    ('Premio a la Innovación en Administración','Colegio Iberoamericano de Administración',1984,NULL),
    ('Excelencia en Gestión Administrativa','Asociación Latinoamericana de Administración',1998,'Reconoce estrategias eficaces y liderazgo en procesos organizacionales.'),
    ('Liderazgo en Administración','Consejo Internacional de Administración',2012,NULL),

    -- Contaduría
    ('Mérito en Contaduría','Instituto Panamericano de Contabilidad',1991,'Aportaciones a normas y prácticas contables.'),
    ('Excelencia en Auditoría','Colegio Nacional de Contadores',2005,NULL),
    ('Premio a la Ética Contable','Federación de Contadores de las Américas',2019,'Promoción de transparencia y ética profesional.'),

    -- Informática
    ('Innovación en Informática','Sociedad de Ingenierías de Software',1987,NULL),
    ('Excelencia en Tecnologías de la Información','Asociación de Profesionales TI',2001,'Desarrollo e implementación de soluciones escalables.'),
    ('Liderazgo en Transformación Digital','Cámara de Innovación Tecnológica',2016,NULL),

    -- Negocios Internacionales
    ('Mérito en Negocios Internacionales','Consejo de Comercio Global',1994,'Impulso a estrategias de internacionalización.'),
    ('Excelencia en Comercio Exterior','Cámara Panamericana de Comercio',2008,NULL),
    ('Liderazgo en Estrategia Global','Foro Iberoamericano de Negocios',2024,'Resultados destacados en expansión de mercados.');

---------------------------------------------------------
-- categoria
---------------------------------------------------------
INSERT INTO public.categoria (nombre)
VALUES
    ('Taller'),
    ('Conferencia'),
    ('Conversatorio'),
    ('Charla'),
    ('Semana académica'),
    ('Seminario'),
    ('Simposio'),
    ('Congreso'),
    ('Foro'),
    ('Presentación de libro');

---------------------------------------------------------
-- pais
---------------------------------------------------------
INSERT INTO public.pais (nombre) 
VALUES
    ('Afganistán'),
    ('Albania'),
    ('Alemania'),
    ('Andorra'),
    ('Angola'),
    ('Antigua y Barbuda'),
    ('Arabia Saudita'),
    ('Argelia'),
    ('Argentina'),
    ('Armenia'),
    ('Australia'),
    ('Austria'),
    ('Azerbaiyán'),
    ('Bahamas'),
    ('Bangladés'),
    ('Barbados'),
    ('Baréin'),
    ('Bélgica'),
    ('Belice'),
    ('Benín'),
    ('Bielorrusia'),
    ('Birmania'),
    ('Bolivia'),
    ('Bosnia y Herzegovina'),
    ('Botsuana'),
    ('Brasil'),
    ('Brunéi Darussalam'),
    ('Bulgaria'),
    ('Burkina Faso'),
    ('Burundi'),
    ('Bután'),
    ('Cabo Verde'),
    ('Camboya'),
    ('Camerún'),
    ('Canadá'),
    ('Catar'),
    ('Chad'),
    ('Chile'),
    ('China'),
    ('Chipre'),
    ('Colombia'),
    ('Comoras'),
    ('Corea del Norte'),
    ('Corea del Sur'),
    ('Costa de Marfil'),
    ('Costa Rica'),
    ('Croacia'),
    ('Cuba'),
    ('Dinamarca'),
    ('Dominica'),
    ('Ecuador'),
    ('Egipto'),
    ('El Salvador'),
    ('Emiratos Árabes Unidos'),
    ('Eritrea'),
    ('Eslovaquia'),
    ('Eslovenia'),
    ('España'),
    ('Estados Unidos'),
    ('Estonia'),
    ('Esuatini'),
    ('Etiopía'),
    ('Filipinas'),
    ('Finlandia'),
    ('Fiyi'),
    ('Francia'),
    ('Gabón'),
    ('Gambia'),
    ('Georgia'),
    ('Ghana'),
    ('Granada'),
    ('Grecia'),
    ('Guatemala'),
    ('Guinea'),
    ('Guinea Ecuatorial'),
    ('Guinea-Bisáu'),
    ('Guyana'),
    ('Haití'),
    ('Honduras'),
    ('Hungría'),
    ('India'),
    ('Indonesia'),
    ('Irak'),
    ('Irán'),
    ('Irlanda'),
    ('Islandia'),
    ('Islas Marshall'),
    ('Islas Salomón'),
    ('Israel'),
    ('Italia'),
    ('Jamaica'),
    ('Japón'),
    ('Jordania'),
    ('Kazajistán'),
    ('Kenia'),
    ('Kirguistán'),
    ('Kiribati'),
    ('Kuwait'),
    ('Laos'),
    ('Lesoto'),
    ('Letonia'),
    ('Líbano'),
    ('Liberia'),
    ('Libia'),
    ('Liechtenstein'),
    ('Lituania'),
    ('Luxemburgo'),
    ('Madagascar'),
    ('Malasia'),
    ('Malaui'),
    ('Maldivas'),
    ('Malí'),
    ('Malta'),
    ('Marruecos'),
    ('Mauricio'),
    ('Mauritania'),
    ('México'),
    ('Micronesia'),
    ('Moldavia'),
    ('Mónaco'),
    ('Mongolia'),
    ('Montenegro'),
    ('Mozambique'),
    ('Namibia'),
    ('Nauru'),
    ('Nepal'),
    ('Nicaragua'),
    ('Níger'),
    ('Nigeria'),
    ('Noruega'),
    ('Nueva Zelanda'),
    ('Omán'),
    ('Países Bajos'),
    ('Pakistán'),
    ('Palaos'),
    ('Palestina'),
    ('Panamá'),
    ('Papúa Nueva Guinea'),
    ('Paraguay'),
    ('Perú'),
    ('Polonia'),
    ('Portugal'),
    ('Reino Unido'),
    ('República Centroafricana'),
    ('República Checa'),
    ('República del Congo'),
    ('República Democrática del Congo'),
    ('República Dominicana'),
    ('Ruanda'),
    ('Rumania'),
    ('Rusia'),
    ('Samoa'),
    ('San Cristóbal y Nieves'),
    ('San Marino'),
    ('San Vicente y las Granadinas'),
    ('Santa Lucía'),
    ('Santa Sede'),
    ('Santo Tomé y Príncipe'),
    ('Senegal'),
    ('Serbia'),
    ('Seychelles'),
    ('Sierra Leona'),
    ('Singapur'),
    ('Siria'),
    ('Somalia'),
    ('Sri Lanka'),
    ('Sudáfrica'),
    ('Sudán'),
    ('Sudán del Sur'),
    ('Suecia'),
    ('Suiza'),
    ('Surinam'),
    ('Tailandia'),
    ('Tanzania'),
    ('Tayikistán'),
    ('Timor Oriental'),
    ('Togo'),
    ('Tonga'),
    ('Trinidad y Tobago'),
    ('Túnez'),
    ('Turkmenistán'),
    ('Turquía'),
    ('Tuvalu'),
    ('Ucrania'),
    ('Uganda'),
    ('Uruguay'),
    ('Uzbekistán'),
    ('Vanuatu'),
    ('Vaticano'),
    ('Venezuela'),
    ('Vietnam'),
    ('Yemen'),
    ('Yibuti'),
    ('Zambia'),
    ('Zimbabue');

---------------------------------------------------------
-- tipo_recinto
---------------------------------------------------------
INSERT INTO public.tipo_recinto (nombre)
VALUES
    ('Aula'),
    ('Auditorio'),
    ('Salas de conferencia'),
    ('Espacios tecnológicos');


---------------------------------------------------------
-- calendario_escolar
---------------------------------------------------------
INSERT INTO public.calendario_escolar (semestre,semestre_inicio,semestre_fin)
VALUES
    ('2025-1', '2025-08-11', '2026-02-02'),
    ('2026-2', '2026-02-03', '2026-08-07');

---------------------------------------------------------
-- tipo_periodo
---------------------------------------------------------
INSERT INTO public.tipo_periodo (nombre)
VALUES
    ('Días inhabiles'),
    ('Exámenes'),
    ('Asueto académico'),
    ('Vacaciones Administrativas'),
    ('Período Intersemestral');

---------------------------------------------------------
-- TABLAS PADRE-HIJA
---------------------------------------------------------
-- area
---------------------------------------------------------
-- areas con responsables asignados (equipamiento)
INSERT INTO public.area(nombre,id_responsable_area)
VALUES
    ('Actos',
        (SELECT id_responsable_area 
            FROM responsable_area 
            WHERE nombre='Juan' AND apellido_paterno='Pérez' AND apellido_materno='Gómez')),
    ('Centro de Informática',
        (SELECT id_responsable_area 
            FROM responsable_area 
            WHERE nombre='María' AND apellido_paterno='López' AND apellido_materno='Hernández')),
    ('Medios Audiovisuales',
        (SELECT id_responsable_area 
            FROM responsable_area 
            WHERE nombre='Carlos' AND apellido_paterno='Martínez' AND apellido_materno='Ramírez')),
    ('Publicaciones y Fomento Editorial',
        (SELECT id_responsable_area 
            FROM responsable_area 
            WHERE nombre='Ana' AND apellido_paterno='García' AND apellido_materno='Sánchez')),
    ('Secretaría Administrativa',
        (SELECT id_responsable_area 
            FROM responsable_area 
            WHERE nombre='Luis' AND apellido_paterno='Rodríguez' AND apellido_materno='Torres'));

-- areas del organigrama (puesto)
INSERT INTO public.area(nombre)
VALUES
    ('División de Educación Continua'),
    ('División de Estudios de Posgrado'),
    ('División de Investigación'),
    ('Coordinación de Asuntos Internacionales'),
    ('Coordinación de Mercadotecnia'),
    ('Coordinación de Recursos Humanos'),
    ('Coordinación del Programa de Posgrado en Ciencias de la Administración'),
    ('Jefatura de la Licenciatura en Administración'),
    ('Jefatura de la Licenciatura en Negocios Internacionales'),
    ('Secretaría Académica'),
    ('Secretaría de Planeación Académica'),
    ('Secretaría de Planeación y Evaluación Académica'),
    ('Secretaría de Difusión Cultural'),
    ('Secretaría de Vinculación'),
    ('Secretaría de Relaciones y Extensión Universitaria'),
    ('Secretaría de Cooperación Internacional'),
    ('Secretaría de Cooperación Internacional / Asociación Latinoamericana de Facultades y Escuelas de Contaduría y Administración'),
    ('Secretaría de Cooperación Internacional ALAFEC'),
    ('Secretaría de Intercambio Académico y ANFECA'),
    ('Secretaría Divulgación y Fomento Editorial'),
    ('Emprendedores'),
    ('Departamento de Servicios Generales y Mantenimiento'),
    ('Centro de Educación a Distancia y Gestión del Conocimiento (CEDIGEC)'),
    ('Coordinación de Informática'),
    ('Secretaría General');

---------------------------------------------------------
-- periodo
---------------------------------------------------------
INSERT INTO public.periodo (fecha_inicio, fecha_fin,id_tipo_periodo,id_calendario_escolar)
VALUES
    -- 2025-1
    -- Días inhabiles
    ('2025-09-15','2025-09-16',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2025-1')),
    ('2025-11-01','2025-11-02',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2025-1')),
    ('2025-11-17','2025-11-17',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2025-1')),
    ('2025-12-12','2025-12-12',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2025-1')),
    ('2025-12-25','2025-12-25',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2025-1')),
    ('2026-01-01','2026-01-01',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2025-1')),
    ('2026-02-02','2026-02-02',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2025-1')),
    -- Exámenes
    ('2025-12-01','2025-12-11',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Exámenes'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2025-1')),
    -- Vacaciones Administrativas
    ('2025-12-15','2026-01-02',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Vacaciones Administrativas'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2025-1')),
    -- Período Intersemestral
    ('2026-01-05','2026-01-30',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Período Intersemestral'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2025-1')),
    
    -- 2026-2
    -- Días inhabiles
    ('2026-03-16','2026-03-16',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2026-2')),
    ('2026-05-01','2026-05-01',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2026-2')),
    ('2026-05-10','2026-05-10',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2026-2')),
    ('2026-05-15','2026-05-15',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Días inhabiles'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2026-2')),
    -- Exámenes
    ('2026-06-01','2026-06-12',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Exámenes'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2026-2')),
    -- Asueto académico
    ('2026-03-30','2026-04-03',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Asueto académico'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2026-2')),
    -- Vacaciones Administrativas
    ('2026-07-06','2026-07-24',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Vacaciones Administrativas'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2026-2')),
    -- Período Intersemestral
    ('2026-06-15','2026-07-03',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Período Intersemestral'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2026-2')),
    ('2026-07-27','2026-08-07',
        (SELECT id_tipo_periodo
            FROM tipo_periodo
            WHERE nombre = 'Período Intersemestral'),
        (SELECT id_calendario_escolar
            FROM calendario_escolar
            WHERE semestre = '2026-2'));

---------------------------------------------------------
-- puesto
---------------------------------------------------------
-- Secretarios
INSERT INTO public.puesto (nombre, id_area, id_jefe) VALUES
    ('Secretario Académico',
        (SELECT id_area FROM area WHERE nombre='Secretaría Académica'),
        NULL),
    ('Secretario de Planeación Académica',
        (SELECT id_area FROM area WHERE nombre='Secretaría de Planeación Académica'),
        NULL),
    ('Secretario de Planeación y Evaluación Académica',
        (SELECT id_area FROM area WHERE nombre='Secretaría de Planeación y Evaluación Académica'),
        NULL),
    ('Secretario de Difusión Cultural',
        (SELECT id_area FROM area WHERE nombre='Secretaría de Difusión Cultural'),
        NULL),
    ('Secretario de Vinculación',
        (SELECT id_area FROM area WHERE nombre='Secretaría de Vinculación'),
        NULL),
    ('Secretario de Relaciones y Extensión Universitaria',
        (SELECT id_area FROM area WHERE nombre='Secretaría de Relaciones y Extensión Universitaria'),
        NULL),
    ('Secretario de Cooperación Internacional',
        (SELECT id_area FROM area WHERE nombre='Secretaría de Cooperación Internacional'),
        NULL),
    ('Secretario General',
        (SELECT id_area FROM area WHERE nombre='Secretaría General'),
        NULL);

-- Jefes
INSERT INTO public.puesto (nombre, id_area, id_jefe) VALUES
    ('Jefe de División de Educación Continua', 
        (SELECT id_area FROM area WHERE nombre='División de Educación Continua'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario Académico')),
    ('Jefe de División de Estudios de Posgrado', 
        (SELECT id_area FROM area WHERE nombre='División de Estudios de Posgrado'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario Académico')),
    ('Jefe de División de Investigación', 
        (SELECT id_area FROM area WHERE nombre='División de Investigación'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario Académico')),
    ('Jefe de Departamento de Servicios Generales y Mantenimiento', 
        (SELECT id_area FROM area WHERE nombre='Departamento de Servicios Generales y Mantenimiento'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario General')),
    ('Jefe de Carrera de la Licenciatura en Administración', 
        (SELECT id_area FROM area WHERE nombre='Jefatura de la Licenciatura en Administración'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario Académico')),
    ('Jefe de Carrera de la Licenciatura en Negocios Internacionales', 
        (SELECT id_area FROM area WHERE nombre='Jefatura de la Licenciatura en Negocios Internacionales'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario Académico'));

-- coordinadores, encargados
INSERT INTO public.puesto (nombre, id_area, id_jefe) VALUES
    -- Académicas y extensión
    ('Coordinador del CEDIGEC',
        (SELECT id_area FROM area WHERE nombre='Centro de Educación a Distancia y Gestión del Conocimiento (CEDIGEC)'),
        (SELECT id_puesto FROM puesto WHERE nombre='Jefe de División de Educación Continua')),
    ('Coordinador del Programa de Posgrado en Ciencias de la Administración', 
        (SELECT id_area FROM area WHERE nombre='Coordinación del Programa de Posgrado en Ciencias de la Administración'),
        (SELECT id_puesto FROM puesto WHERE nombre='Jefe de División de Estudios de Posgrado')),
    ('Coordinador de Asuntos Internacionales', 
        (SELECT id_area FROM area WHERE nombre='Coordinación de Asuntos Internacionales'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Relaciones y Extensión Universitaria')),
    ('Coordinador de Mercadotecnia', 
        (SELECT id_area FROM area WHERE nombre='Coordinación de Mercadotecnia'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Difusión Cultural')),
    ('Coordinador de Recursos Humanos', 
        (SELECT id_area FROM area WHERE nombre='Coordinación de Recursos Humanos'),
        (SELECT id_puesto FROM puesto WHERE nombre='Jefe de Departamento de Servicios Generales y Mantenimiento')),
    ('Coordinador de Informática', 
        (SELECT id_area FROM area WHERE nombre='Coordinación de Informática'),
        (SELECT id_puesto FROM puesto WHERE nombre='Jefe de Departamento de Servicios Generales y Mantenimiento')),
    ('Coordinador de Emprendedores', 
        (SELECT id_area FROM area WHERE nombre='Emprendedores'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Vinculación')),

    -- Vinculación, difusión y cooperación
    ('Secretario de Cooperación Internacional ALFECA', 
        (SELECT id_area FROM area WHERE nombre='Secretaría de Cooperación Internacional / Asociación Latinoamericana de Facultades y Escuelas de Contaduría y Administración'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Cooperación Internacional')),
    ('Secretario de Cooperación Internacional y Enlace ALAFEC', 
        (SELECT id_area FROM area WHERE nombre='Secretaría de Cooperación Internacional ALAFEC'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Cooperación Internacional')),
    ('Secretario de Intercambio Académico y ANFECA', 
        (SELECT id_area FROM area WHERE nombre='Secretaría de Intercambio Académico y ANFECA'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Relaciones y Extensión Universitaria')),
    ('Secretario de Divulgación y Fomento Editorial', 
        (SELECT id_area FROM area WHERE nombre='Secretaría Divulgación y Fomento Editorial'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Difusión Cultural')),

    -- Apoyo logístico
    ('Encargado de Actos', 
        (SELECT id_area FROM area WHERE nombre='Actos'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario General'));

-- Servicio social
INSERT INTO public.puesto (nombre,unico, id_area, id_jefe) VALUES
    ('Servicio Social Difusión Cultural',False,
        (SELECT id_area FROM area WHERE nombre='Secretaría de Difusión Cultural'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Difusión Cultural'));


---------------------------------------------------------
-- usuario
---------------------------------------------------------
INSERT INTO public.usuario (foto_usuario, nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    -- superadministrador
    ('/usuarios/fotos/alonso_cedeno_prieto.png','acedeno','CEPA800126B6C','Alonso','Cedeno','Prieto','5511000026','5588000026','acedeno@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='superadministrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario General')),

    -- administrador
    ('/usuarios/fotos/alejandro_torres_lopez.png','atorres','TOLA800101A1B','Alejandro','Torres','Lopez','5511000001','5588000001','atorres@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Jefe de División de Educación Continua')),

    ('/usuarios/fotos/beatriz_morales_diaz.png','bmorales','MODB800102B2C','Beatriz','Morales','Diaz','5511000002','5588000002','bmorales@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Jefe de División de Estudios de Posgrado')),

    ('/usuarios/fotos/carlos_rojas_perez.png','crojas','ROPC800103C3D','Carlos','Rojas','Perez','5511000003','5588000003','crojas@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Jefe de División de Investigación')),

    ('/usuarios/fotos/jorge_herrera_martin.png','jherrera','HEMA800110K0L','Jorge','Herrera','Martin','5511000010','5588000010','jherrera@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario Académico')),

    ('/usuarios/fotos/karla_dominguez_pineda.png','kdominguez','DOPK800111L1M','Karla','Dominguez','Pineda','5511000011','5588000011','kdominguez@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Planeación Académica')),

    ('/usuarios/fotos/luis_alberto_gomez_rivera.png','lgomez','GRLA800112M2N','Luis Alberto','Gomez','Rivera','5511000012','5588000012','lgomez@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Planeación y Evaluación Académica')),

    ('/usuarios/fotos/mariana_ortega_luna.png','mortega','ORLM800113N3P','Mariana','Ortega','Luna','5511000013','5588000013','mortega@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Difusión Cultural')),

    ('/usuarios/fotos/nicolas_pacheco_salas.png','npacheco','PASN800114P4Q','Nicolas','Pacheco','Salas','5511000014','5588000014','npacheco@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Vinculación')),

    ('/usuarios/fotos/olivia_quintana_rosales.png','oquintana','QURO800115Q5R','Olivia','Quintana','Rosales','5511000015','5588000015','oquintana@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Relaciones y Extensión Universitaria')),

    ('/usuarios/fotos/pablo_reyes_aguilar.png','preyes','REAP800116R6S','Pablo','Reyes','Aguilar','5511000016','5588000016','preyes@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Cooperación Internacional')),

    ('/usuarios/fotos/raul_serrano_ibanez.png','rserrano','SEIR800117S7T','Raul','Serrano','Ibanez','5511000017','5588000017','rserrano@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Cooperación Internacional ALFECA')),

    ('/usuarios/fotos/silvia_trevino_campos.png','strevino','TRCS800118T8U','Silvia','Trevino','Campos','5511000018','5588000018','strevino@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Cooperación Internacional y Enlace ALAFEC')),

    ('/usuarios/fotos/tomas_ugalde_neri.png','tugalde','UGNT800119U9V','Tomas','Ugalde','Neri','5511000019','5588000019','tugalde@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Intercambio Académico y ANFECA')),

    ('/usuarios/fotos/ursula_valdez_ibarra.png','uvaldez','VAIU800120V0W','Ursula','Valdez','Ibarra','5511000020','5588000020','uvaldez@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Secretario de Divulgación y Fomento Editorial')),

    ('/usuarios/fotos/ximena_zarate_ochoa.png','xzarate','ZAOX800123Y3Z','Ximena','Zarate','Ochoa','5511000023','5588000023','xzarate@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='administrador'),
        (SELECT id_puesto FROM puesto WHERE nombre='Jefe de Departamento de Servicios Generales y Mantenimiento')),

    -- funcionario
    ('/usuarios/fotos/daniela_vega_hernandez.png','dvega','VEHD800104D4E','Daniela','Vega','Hernandez','5511000004','5588000004','dvega@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre='Coordinador de Asuntos Internacionales')),

    ('/usuarios/fotos/eduardo_sanchez_castro.png','esanchez','SACE800105E5F','Eduardo','Sanchez','Castro','5511000005','5588000005','esanchez@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre='Coordinador de Mercadotecnia')),

    ('/usuarios/fotos/fernanda_lopez_garcia.png','flopez','LOGF800106F6G','Fernanda','Lopez','Garcia','5511000006','5588000006','flopez@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre='Coordinador de Recursos Humanos')),

    ('/usuarios/fotos/gabriela_navarro_ortiz.png','gnavarro','NAOG800107G7H','Gabriela','Navarro','Ortiz','5511000007','5588000007','gnavarro@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre='Coordinador del Programa de Posgrado en Ciencias de la Administración')),

    ('/usuarios/fotos/hector_ramirez_solis.png','hramirez','RASH800108H8J','Hector','Ramirez','Solis','5511000008','5588000008','hramirez@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre='Jefe de Carrera de la Licenciatura en Administración')),

    ('/usuarios/fotos/ivanna_castillo_mendez.png','icastillo','CAMI800109J9K','Ivanna','Castillo','Mendez','5511000009','5588000009','icastillo@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre='Jefe de Carrera de la Licenciatura en Negocios Internacionales')),

    ('/usuarios/fotos/victor_ximenez_lara.png','vximenez','XILV800121W1X','Victor','Ximenez','Lara','5511000021','5588000021','vximenez@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre='Encargado de Actos')),

    ('/usuarios/fotos/wendy_yanez_cabrera.png','wyanez','YACW800122X2Y','Wendy','Yanez','Cabrera','5511000022','5588000022','wyanez@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre='Coordinador de Emprendedores')),

    ('/usuarios/fotos/yair_acosta_molina.png','yacosta','ACMY800124Z4A','Yair','Acosta','Molina','5511000024','5588000024','yacosta@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre='Coordinador del CEDIGEC')),

    ('/usuarios/fotos/zoe_bautista_nunez.png','zbautista','BUNZ800125A5B','Zoe','Bautista','Nunez','5511000025','5588000025','zbautista@fca.unam.mx',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre='funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre='Coordinador de Informática')),

    --      chicos del servicio social
    ('/usuarios/fotos/ana_garcia_lopez.png','ana_garcia_lopez',NULL,'Ana','García','López','5512345678','5523456789','ana.garcia.lopez@gmail.com',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre = 'funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre = 'Servicio Social Difusión Cultural')),
    ('/usuarios/fotos/carlos_perez_mendoza.png','carlos_perez_mendoza',NULL,'Carlos','Pérez','Mendoza','5587654321','5598765432','carlos.perez.mendoza@gmail.com',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre = 'funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre = 'Servicio Social Difusión Cultural')),
    ('/usuarios/fotos/lucia_martinez_ramirez.png','lucia_martinez_ramirez',NULL,'Lucía','Martínez','Ramírez','5576543210','5565432109','lucia.martinez.ramirez@gmail.com',
        (SELECT id_rol_usuario FROM rol_usuario WHERE nombre = 'funcionario'),
        (SELECT id_puesto FROM puesto WHERE nombre = 'Servicio Social Difusión Cultural'));

---------------------------------------------------------
-- ponente
---------------------------------------------------------
INSERT INTO public.ponente (nombre, apellido_paterno, apellido_materno,correo, id_pais) 
VALUES
    ('Ana María','López','Rivera','anamaria.lopez.rivera@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Carlos Eduardo','Sánchez','Gómez','carloseduardo.sanchez.gomez@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Lucía','Fernández','Morales','lucia.fernandez.morales@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Jorge Alberto','Ramírez','Torres','jorgealberto.ramirez.torres@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Daniela','Pérez','Castillo','daniela.perez.castillo@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Miguel Ángel','Hernández','Cruz','miguelangel.hernandez.cruz@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Sofía','Navarro','Jiménez','sofia.navarro.jimenez@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Ricardo','Ortiz','Martínez','ricardo.ortiz.martinez@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Paola','Ruiz','Delgado','paola.ruiz.delgado@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Víctor Hugo','Cabrera','León','victorhugo.cabrera.leon@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Gabriela','Torres','Chávez','gabriela.torres.chavez@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Alonso','Medina','Rojas','alonso.medina.rojas@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Karla','Domínguez','Salas','karla.dominguez.salas@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Diego','Salazar','Varela','diego.salazar.varela@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Fernanda','Aguilar','Pineda','fernanda.aguilar.pineda@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Manuel','Andrade','Cortés','manuel.andrade.cortes@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Beatriz','Castañeda','Luna','beatriz.castaneda.luna@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Rodrigo','Fuentes','Valencia','rodrigo.fuentes.valencia@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Elena','Romero','Padilla','elena.romero.padilla@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Héctor','Bautista','Arriaga','hector.bautista.arriaga@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'México')),
    ('Camila','Herrera','Rosario','camila.herrera.rosario@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'República Dominicana')),
    ('Mateo','Núñez','Batista','mateo.nunez.batista@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'República Dominicana')),
    ('Juliana','Córdoba','Restrepo','juliana.cordoba.restrepo@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'Colombia')),
    ('Santiago','Vélez','Montoya','santiago.velez.montoya@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'Colombia')),
    ('Akira','Tanaka','Nakamura','akira.tanaka.nakamura@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'Japón')),
    ('Emily','Carter','Thompson','emily.carter.thompson@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'Canadá')),
    ('Michael','Johnson','Smith','michael.johnson.smith@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'Estados Unidos')),
    ('Sarah','Williams','Brown','sarah.williams.brown@gmail.com',
        (SELECT id_pais 
            FROM pais 
            WHERE nombre = 'Estados Unidos'));

---------------------------------------------------------
-- evento
---------------------------------------------------------
-- mega-eventos
---------------------------------------------------------
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, estatus, motivo, mega_evento, fecha_registro, id_categoria, id_mega_evento, id_calendario_escolar)
VALUES
    -- MEGA 1: Semana académica (Administración)
    ('Semana Académica de Administración 2025-1',
        'Ciclo de actividades, talleres y conferencias para la comunidad de Administración.',
        '2025-09-08','2025-09-12','09:00','17:00',
        TRUE, FALSE, 'pendiente', NULL, TRUE,
        '2025-09-04 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Semana académica'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- MEGA 2: Congreso (Contaduría) - híbrido
    ('Congreso de Contaduría 2025',
        'Encuentro académico-profesional en contaduría con ponentes nacionales e internacionales.',
        '2025-10-06','2025-10-08','09:00','18:00',
        TRUE, TRUE, 'pendiente', NULL, TRUE,
        '2025-09-25 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Congreso'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- MEGA 3: Seminario (Informática)
    ('Seminario de Informática 2025',
        'Seminario especializado en tendencias de desarrollo de software y arquitectura de sistemas.',
        '2025-11-04','2025-11-05','10:00','16:00',
        TRUE, FALSE, 'pendiente', NULL, TRUE,
        '2025-10-30 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Seminario'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- MEGA 4: Simposio (Negocios Internacionales)
    ('Simposio de Negocios Internacionales 2025',
        'Simposio multidisciplinario sobre comercio exterior y estrategias globales.',
        '2025-08-19','2025-08-20','09:00','15:00',
        TRUE, FALSE, 'pendiente', NULL, TRUE,
        '2025-08-14 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Simposio'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1'));

---------------------------------------------------------
-- eventos
---------------------------------------------------------
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, estatus, motivo, mega_evento, fecha_registro, id_categoria, id_mega_evento, id_calendario_escolar)
VALUES
    -- Administracion (10 eventos)
    -- Asociados al MEGA "Semana Académica de Administración 2025-1" (3)
    ('Taller de liderazgo ágil',
        'Dinámicas para fortalecer liderazgo y toma de decisiones en equipos de trabajo.',
        '2025-09-09','2025-09-09','10:00','12:00',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-09-04 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Taller'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Semana Académica de Administración 2025-1'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Conversatorio: Gestión del cambio',
        'Conversatorio con casos reales de transformación organizacional.',
        '2025-09-10','2025-09-10','11:00','13:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-09-04 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Conversatorio'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Semana Académica de Administración 2025-1'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Charla: OKRs en empresas medianas',
        'Implementación práctica de OKRs para impulsar resultados.',
        '2025-09-12','2025-09-12','09:00','10:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-09-04 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Charla'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Semana Académica de Administración 2025-1'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- Independientes (7)
    ('Seminario de Planeación Estratégica',
        'Herramientas y marcos para la planeación de ciclo anual.',
        '2025-08-26','2025-08-26','09:00','11:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-08-21 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Seminario'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Conferencia: Cultura organizacional',
        'Claves para diseñar y medir cultura organizacional.',
        '2025-09-03','2025-09-03','12:00','14:00',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-08-29 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Conferencia'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Foro: Innovación y productividad',
        'Foro de mejores prácticas para elevar productividad.',
        '2025-09-23','2025-09-23','10:00','12:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-09-18 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Foro'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Presentación de libro: Dirección Moderna',
        'Autor presenta casos y metodologías actuales de dirección.',
        '2025-10-14','2025-10-14','09:30','11:00',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-10-09 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Presentación de libro'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Taller de negociación',
        'Técnicas de negociación ganar-ganar.',
        '2025-10-21','2025-10-21','16:00','18:00',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-10-16 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Taller'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Conversatorio: Gestión del talento',
        'Perspectivas contemporáneas en atracción y retención.',
        '2025-11-11','2025-11-11','09:00','11:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-11-07 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Conversatorio'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Charla: Indicadores clave (KPIs)',
        'Selección y seguimiento de KPIs estratégicos.',
        '2025-11-25','2025-11-25','10:00','11:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-11-20 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Charla'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- Cancelado (1)
    ('Congreso estudiantil de innovación',
        'Proyectos de innovación y emprendimiento.',
        '2025-11-19','2025-11-19','09:00','12:00',
        TRUE, TRUE, 'cancelado', 'Cancelado por baja de participantes.', FALSE,
        '2025-11-14 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Congreso'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- Contaduria (10 eventos)
    -- Asociados al MEGA "Congreso de Contaduría 2025" (3)
    ('Taller de NIIF para PYMES',
        'Aplicación práctica de NIIF en estados financieros.',
        '2025-10-06','2025-10-06','10:00','12:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-09-25 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Taller'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Congreso de Contaduría 2025'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Foro: Auditoría continua',
        'Tecnologías y procesos para auditoría en tiempo real.',
        '2025-10-07','2025-10-07','11:00','13:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-09-25 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Foro'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Congreso de Contaduría 2025'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Conferencia: Ética profesional',
        'Retos éticos en la práctica de la contaduría.',
        '2025-10-08','2025-10-08','09:00','10:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-09-25 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Conferencia'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Congreso de Contaduría 2025'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- Independientes (7)
    ('Seminario de impuestos 2025',
        'Actualización en ISR e IVA para ejercicio 2025.',
        '2025-08-28','2025-08-28','09:00','11:00',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-08-21 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Seminario'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Charla: Contabilidad de costos',
        'Modelos de costeo para manufactura y servicios.',
        '2025-09-02','2025-09-02','16:00','18:00',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-08-29 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Charla'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Conversatorio: Controles internos',
        'Diseño de controles efectivos en procesos críticos.',
        '2025-09-24','2025-09-24','10:00','12:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-09-18 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Conversatorio'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Presentación de libro: Casos de auditoría',
        'Experiencias y aprendizajes en auditoría financiera.',
        '2025-10-15','2025-10-15','12:00','13:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-10-09 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Presentación de libro'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Taller de conciliaciones bancarias',
        'Prácticas y automatización de conciliaciones.',
        '2025-10-29','2025-10-29','09:00','11:00',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-10-24 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Taller'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Conferencia: Gobierno corporativo',
        'Rol del contador en el gobierno corporativo.',
        '2025-11-12','2025-11-12','11:00','12:30',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-11-07 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Conferencia'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Simposio de auditoría interna',
        'Nuevas metodologías de auditoría interna.',
        '2025-11-26','2025-11-26','10:00','12:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-11-20 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Simposio'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- Informática (10 eventos)
    -- Asociados al MEGA "Seminario de Informática 2025" (3)
    ('Taller: Microservicios en práctica',
        'Laboratorio práctico de diseño y despliegue de microservicios.',
        '2025-11-04','2025-11-04','10:00','11:30',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-10-30 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Taller'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Seminario de Informática 2025'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Conversatorio: IA Responsable',
        'Discusión sobre ética y cumplimiento en IA.',
        '2025-11-05','2025-11-05','11:00','13:00',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-10-30 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Conversatorio'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Seminario de Informática 2025'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Charla: Observabilidad moderna',
        'Trazas, métricas y logs para SRE.',
        '2025-11-05','2025-11-05','15:00','16:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-10-30 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Charla'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Seminario de Informática 2025'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- Independientes (7) - incluye 1 online-only y 1 cancelado
    ('Conferencia: Seguridad en la nube',
        'Mejores prácticas de seguridad en entornos cloud.',
        '2025-08-27','2025-08-27','10:00','12:00',
        FALSE, TRUE, 'pendiente', NULL, FALSE,  -- online-only #1
        '2025-08-21 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Conferencia'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Seminario: Ciencia de datos aplicada',
        'Casos de uso de ML en industria.',
        '2025-09-04','2025-09-04','12:00','14:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-08-29 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Seminario'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Foro: Ciberseguridad 2025',
        'Panel con especialistas en respuesta a incidentes.',
        '2025-09-30','2025-09-30','09:30','11:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-09-25 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Foro'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Taller: DevOps con contenedores',
        'Automatización de CI/CD con contenedores.',
        '2025-10-22','2025-10-22','10:00','12:30',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-10-16 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Taller'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Presentación de libro: Arquitecturas escalables',
        'Recopilación de patrones modernos de arquitectura.',
        '2025-10-28','2025-10-28','16:00','17:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-10-24 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Presentación de libro'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Simposio de Ingeniería de Software',
        'Tópicos avanzados en calidad y pruebas.',
        '2025-11-13','2025-11-13','09:00','11:30',
        TRUE, TRUE, 'cancelado', 'Cancelado por reprogramación del ponente.', FALSE,
        '2025-11-07 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Simposio'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Charla: Testing con IA',
        'Estrategias de generación automática de casos de prueba.',
        '2025-11-27','2025-11-27','15:00','16:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-11-20 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Charla'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- Negocios internacionales (10 eventos)
    -- Asociados al MEGA "Simposio de Negocios Internacionales 2025" (3)
    ('Taller: Estrategias de entrada a mercados',
        'Evaluación de modos de entrada y riesgos.',
        '2025-08-19','2025-08-19','11:00','13:00',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-08-14 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Taller'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Simposio de Negocios Internacionales 2025'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Conversatorio: Nearshoring en LatAm',
        'Oportunidades de inversión y cadenas de suministro.',
        '2025-08-20','2025-08-20','10:00','12:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-08-14 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Conversatorio'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Simposio de Negocios Internacionales 2025'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Charla: Reglas de origen (T-MEC)',
        'Aspectos clave para exportadores.',
        '2025-08-20','2025-08-20','13:00','14:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-08-14 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Charla'),
        (SELECT id_evento 
            FROM public.evento 
            WHERE nombre = 'Simposio de Negocios Internacionales 2025'),
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- Independientes (7) - incluye 1 online-only y 1 cancelado
    ('Seminario: Logística internacional',
        'Optimización de costos y tiempos en logística global.',
        '2025-09-05','2025-09-05','09:00','11:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-08-29 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Seminario'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Foro: Comercio electrónico transfronterizo',
        'Experiencias en marketplaces internacionales.',
        '2025-09-24','2025-09-24','12:00','13:30',
        FALSE, TRUE, 'pendiente', NULL, FALSE,  -- online-only #2
        '2025-09-18 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Foro'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Presentación de libro: Estrategia Global',
        'Casos de internacionalización de empresas latinoamericanas.',
        '2025-10-08','2025-10-08','16:00','17:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-10-02 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Presentación de libro'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Seminario: Tratados comerciales emergentes',
        'Tendencias en acuerdos comerciales.',
        '2025-10-23','2025-10-23','10:00','12:00',
        TRUE, TRUE, 'pendiente', NULL, FALSE,
        '2025-10-16 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Seminario'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Conferencia: Gestión de riesgo país',
        'Metodologías para evaluar riesgo macroeconómico.',
        '2025-11-06','2025-11-06','09:30','11:00',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-10-31 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Conferencia'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Simposio: Negociación intercultural',
        'Herramientas para negociaciones efectivas.',
        '2025-11-18','2025-11-18','10:00','12:00',
        TRUE, TRUE, 'cancelado', 'Cancelado por contingencia logística.', FALSE,
        '2025-11-14 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Simposio'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    ('Charla: Inteligencia de mercados',
        'Uso de datos para la selección de mercados objetivo.',
        '2025-11-26','2025-11-26','15:00','16:30',
        TRUE, FALSE, 'pendiente', NULL, FALSE,
        '2025-11-20 18:00',
        (SELECT id_categoria 
            FROM categoria 
            WHERE nombre = 'Charla'),
        NULL,
        (SELECT id_calendario_escolar 
            FROM calendario_escolar 
            WHERE semestre = '2025-1')),

    -- eventos con traslape   
    -- Coincide con "Taller de liderazgo ágil" (2025-09-09 10:00-12:00)
    ('Clínica de liderazgo colaborativo',
     'Prácticas de liderazgo distribuido, feedback efectivo y coordinación de equipos.',
     '2025-09-09','2025-09-09','10:00','12:00',
     TRUE, TRUE, 'pendiente', NULL, FALSE,
     '2025-09-01 18:00',
     (SELECT id_categoria FROM categoria WHERE nombre = 'Taller'),
     NULL,
     (SELECT id_calendario_escolar FROM calendario_escolar WHERE semestre = '2025-1')),

    -- Coincide con "Conversatorio: Gestión del cambio" (2025-09-10 11:00-13:00)
    ('Conversatorio: Innovación y cambio cultural',
     'Casos y tácticas para impulsar innovación sostenida durante procesos de cambio.',
     '2025-09-10','2025-09-10','11:00','13:00',
     TRUE, TRUE, 'pendiente', NULL, FALSE,
     '2025-09-04 18:00',
     (SELECT id_categoria FROM categoria WHERE nombre = 'Conversatorio'),
     NULL,
     (SELECT id_calendario_escolar FROM calendario_escolar WHERE semestre = '2025-1')),

    -- Coincide con "Charla: OKRs en empresas medianas" (2025-09-12 09:00-10:30)
    ('Charla: KPIs y accountability en equipos ágiles',
     'Relación entre indicadores líderes/rezagados y responsabilidad colectiva.',
     '2025-09-12','2025-09-12','09:00','10:30',
     TRUE, FALSE, 'pendiente', NULL, FALSE,
     '2025-09-05 18:00',
     (SELECT id_categoria FROM categoria WHERE nombre = 'Charla'),
     NULL,
     (SELECT id_calendario_escolar FROM calendario_escolar WHERE semestre = '2025-1')),

    -- Coincide con "Seminario de Planeación Estratégica" (2025-08-26 09:00-11:00)
    ('Seminario de Diseño de Estrategia Competitiva',
     'Formulación, ejecución y monitoreo de estrategia a nivel unidad de negocio.',
     '2025-08-26','2025-08-26','09:00','11:00',
     TRUE, TRUE, 'pendiente', NULL, FALSE,
     '2025-08-20 18:00',
     (SELECT id_categoria FROM categoria WHERE nombre = 'Seminario'),
     NULL,
     (SELECT id_calendario_escolar FROM calendario_escolar WHERE semestre = '2025-1')),

    -- Coincide con "Conferencia: Cultura organizacional" (2025-09-03 12:00-14:00)
    ('Conferencia: Liderazgo y pertenencia organizacional',
     'Estrategias para construir seguridad psicológica y sentido de pertenencia.',
     '2025-09-03','2025-09-03','12:00','14:00',
     TRUE, TRUE, 'pendiente', NULL, FALSE,
     '2025-08-29 18:00',
     (SELECT id_categoria FROM categoria WHERE nombre = 'Conferencia'),
     NULL,
     (SELECT id_calendario_escolar FROM calendario_escolar WHERE semestre = '2025-1'));

---------------------------------------------------------
-- empresa
---------------------------------------------------------
INSERT INTO public.empresa (nombre, id_pais) VALUES
    -- México (10)
    ('Azteca Administración S.A. de C.V.', (SELECT id_pais FROM pais WHERE nombre = 'México')),
    ('Norte Contadores Asociados', (SELECT id_pais FROM pais WHERE nombre = 'México')),
    ('TecnoBajío Informática', (SELECT id_pais FROM pais WHERE nombre = 'México')),
    ('Global MX Negocios', (SELECT id_pais FROM pais WHERE nombre = 'México')),
    ('Valle Innovación Digital', (SELECT id_pais FROM pais WHERE nombre = 'México')),
    ('Pacífico Finanzas', (SELECT id_pais FROM pais WHERE nombre = 'México')),
    ('Capital del Centro Consultores', (SELECT id_pais FROM pais WHERE nombre = 'México')),
    ('Oriente Sistemas Empresariales', (SELECT id_pais FROM pais WHERE nombre = 'México')),
    ('Occidente Servicios Contables', (SELECT id_pais FROM pais WHERE nombre = 'México')),
    ('Yucatán Comercio Internacional', (SELECT id_pais FROM pais WHERE nombre = 'México')),

    -- República Dominicana (2)
    ('Caribe Gestión Empresarial', (SELECT id_pais FROM pais WHERE nombre = 'República Dominicana')),
    ('Quisqueya Tecnología', (SELECT id_pais FROM pais WHERE nombre = 'República Dominicana')),

    -- Colombia (2)
    ('Andina Soluciones Contables', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),
    ('Café Digital Innovación', (SELECT id_pais FROM pais WHERE nombre = 'Colombia')),

    -- Japón (2)
    ('Sakura Global Business', (SELECT id_pais FROM pais WHERE nombre = 'Japón')),
    ('Nippon Systems', (SELECT id_pais FROM pais WHERE nombre = 'Japón')),

    -- Canadá (2)
    ('Maple Accounting Group', (SELECT id_pais FROM pais WHERE nombre = 'Canadá')),
    ('Northern Tech Solutions', (SELECT id_pais FROM pais WHERE nombre = 'Canadá')),

    -- Estados Unidos (2)
    ('Eagle International Trade', (SELECT id_pais FROM pais WHERE nombre = 'Estados Unidos')),
    ('Pacific Data Corp', (SELECT id_pais FROM pais WHERE nombre = 'Estados Unidos'));


---------------------------------------------------------
-- semblanza
---------------------------------------------------------
-- Ana María López Rivera
INSERT INTO public.semblanza (archivo, biografia, id_ponente) VALUES
('ponentes/semblanzas/ana_maria_lopez_rivera.pdf',
 'Profesional con experiencia en gestión de proyectos y formación universitaria. Ha colaborado en iniciativas de impacto social y académico.',
 (SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera')),

-- Carlos Eduardo Sánchez Gómez
('ponentes/semblanzas/carlos_eduardo_sanchez_gomez.pdf',
 'Especialista en mejora de procesos y análisis organizacional. Enfoca su práctica en innovación con métricas de desempeño sostenibles.',
 (SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez')),

-- Lucía Fernández Morales
('ponentes/semblanzas/lucia_fernandez_morales.pdf',
 'Investigadora en temas de liderazgo y cultura organizacional. Sus proyectos promueven la colaboración y el aprendizaje continuo.',
 (SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales')),

-- Jorge Aleberto Ramírez Torres
('ponentes/semblanzas/jorge_alberto_ramirez_torres.pdf',
 'Consultor en planeación estratégica con énfasis en la toma de decisiones basada en datos y mejora del rendimiento.',
 (SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres')),

-- Daniela Pérez Castillo
('ponentes/semblanzas/daniela_perez_castillo.pdf',
 'Docente y conferencista. Impulsa metodologías activas y transformación digital en entornos académicos y empresariales.',
 (SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo')),

-- Miguel Ángel Hernández Cruz
('ponentes/semblanzas/miguel_angel_hernandez_cruz.pdf',
 'Ingeniero con trayectoria en TI y gestión del cambio. Lidera proyectos de automatización y adopción tecnológica.',
 (SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz')),

-- Sofía Navarro Jiménez
('ponentes/semblanzas/sofia_navarro_jimenez.pdf',
 'Enfocada en experiencias de usuario y analítica aplicada. Promueve prácticas inclusivas y diseño centrado en las personas.',
 (SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez')),

-- Ricardo Ortiz Martínez
('ponentes/semblanzas/ricardo_ortiz_martinez.pdf',
 'Estratega de negocios con enfoque en escalabilidad y alianzas. Ha apoyado startups y corporativos en expansión regional.',
 (SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez')),

-- Paola Ruiz Delgado
('ponentes/semblanzas/paola_ruiz_delgado.pdf',
 'Contadora pública con experiencia en auditoría y cumplimiento. Orientada a la gobernanza y la transparencia.',
 (SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado')),

-- Víctor Hugo Cabrera León
('ponentes/semblanzas/victor_hugo_cabrera_leon.pdf',
 'Especialista en logística y operaciones. Optimiza cadenas de suministro mediante analítica y colaboración interfuncional.',
 (SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León')),

-- Gabriela Torres Chávez
('ponentes/semblanzas/gabriela_torres_chavez.pdf',
 'Ha coordinado proyectos de vinculación academia-industria con foco en impacto regional y sostenibilidad.',
 (SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez')),

-- Alonso Medina Rojas
('ponentes/semblanzas/alonso_medina_rojas.pdf',
 'Consultor en finanzas corporativas. Impulsa decisiones con modelos cuantitativos y comunicación efectiva.',
 (SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas')),

-- Karla Domínguez Salas
('ponentes/semblanzas/karla_dominguez_salas.pdf',
 'Diseña e implementa iniciativas de aprendizaje organizacional y desarrollo del talento con métricas de impacto.',
 (SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas')),

-- Diego Salazar Varela
('ponentes/semblanzas/diego_salazar_varela.pdf',
 'Profesional de análisis de datos y BI. Transforma información en decisiones accionables para el negocio.',
 (SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela')),

-- Fernanda Aguilar Pineda
('ponentes/semblanzas/fernanda_aguilar_pineda.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda')),

-- Manuel Andrade Cortés
('ponentes/semblanzas/manuel_andrade_cortes.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés')),

-- Beatriz Castañeda Luna
('ponentes/semblanzas/beatriz_castaneda_luna.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna')),

-- Rodrigo Fuentes Valencia
('ponentes/semblanzas/rodrigo_fuentes_valencia.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia')),

-- Elena Romero Padilla
('ponentes/semblanzas/elena_romero_padilla.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla')),

-- Hector Bautista Arriaga
('ponentes/semblanzas/hector_bautista_arriaga.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga')),

-- Camila Herrera Rosario
('ponentes/semblanzas/camila_herrera_rosario.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario')),

-- Mateo Núñez Batista
('ponentes/semblanzas/mateo_nunez_batista.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista')),

-- Juliana Córdoba Restrepo
('ponentes/semblanzas/juliana_cordoba_restrepo.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo')),

-- Santiago Vélez Montoya
('ponentes/semblanzas/santiago_velez_montoya.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya')),

-- Akira Tanaka Nakamura
('ponentes/semblanzas/akira_tanaka_nakamura.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura')),

-- Emily Carter Thompson
('ponentes/semblanzas/emily_carter_thompson.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson')),

-- Michael Johnson Smith
('ponentes/semblanzas/michael_johnson_smith.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith')),

-- Sarah Williams Brown
('ponentes/semblanzas/sarah_williams_brown.pdf',
 NULL,
 (SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown'));


---------------------------------------------------------
-- experiencia
---------------------------------------------------------
INSERT INTO public.experiencia (puesto, puesto_actual, fecha_inicio, fecha_fin, id_empresa) VALUES
    -- 1) Ana María López Rivera (Plantilla A)  i=1  empresas: 1,2,3,4
    ('Administración', false, '1990-01-01', '1994-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Azteca Administración S.A. de C.V.')),
    ('Contaduría',    false, '1995-01-01', '1999-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Norte Contadores Asociados')),
    ('Informática',   false, '2000-01-01', '2005-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'TecnoBajío Informática')),
    ('Negocios Internacionales', True, '2006-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Global MX Negocios')),

    -- 2) Carlos Eduardo Sánchez Gómez (B) i=2 empresas: 2,3,4,5
    ('Administración', false, '1991-01-01', '1995-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Norte Contadores Asociados')),
    ('Contaduría',    false, '1996-01-01', '2000-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'TecnoBajío Informática')),
    ('Informática',   false, '2001-01-01', '2006-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Global MX Negocios')),
    ('Negocios Internacionales', True, '2007-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Valle Innovación Digital')),

    -- 3) Lucía Fernández Morales (C) i=3 empresas: 3,4,5,6
    ('Administración', false, '1992-01-01', '1996-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'TecnoBajío Informática')),
    ('Contaduría',    false, '1997-01-01', '2001-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Global MX Negocios')),
    ('Informática',   false, '2002-01-01', '2007-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Valle Innovación Digital')),
    ('Negocios Internacionales', True, '2008-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacífico Finanzas')),

    -- 4) Jorge Alberto Ramírez Torres (D) i=4 empresas: 4,5,6,7
    ('Administración', false, '1993-01-01', '1997-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Global MX Negocios')),
    ('Contaduría',    false, '1998-01-01', '2002-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Valle Innovación Digital')),
    ('Informática',   false, '2003-01-01', '2008-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacífico Finanzas')),
    ('Negocios Internacionales', True, '2009-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Capital del Centro Consultores')),

    -- 5) Daniela Pérez Castillo (E) i=5 empresas: 5,6,7,8
    ('Administración', false, '1994-01-01', '1998-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Valle Innovación Digital')),
    ('Contaduría',    false, '1999-01-01', '2003-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacífico Finanzas')),
    ('Informática',   false, '2004-01-01', '2009-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Capital del Centro Consultores')),
    ('Negocios Internacionales', True, '2010-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Oriente Sistemas Empresariales')),

    -- 6) Miguel Ángel Hernández Cruz (F) i=6 empresas: 6,7,8,9
    ('Administración', false, '1995-01-01', '1999-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacífico Finanzas')),
    ('Contaduría',    false, '2000-01-01', '2004-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Capital del Centro Consultores')),
    ('Informática',   false, '2005-01-01', '2010-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Oriente Sistemas Empresariales')),
    ('Negocios Internacionales', True, '2011-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Occidente Servicios Contables')),

    -- 7) Sofía Navarro Jiménez (G) i=7 empresas: 7,8,9,10
    ('Administración', false, '1996-01-01', '2000-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Capital del Centro Consultores')),
    ('Contaduría',    false, '2001-01-01', '2005-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Oriente Sistemas Empresariales')),
    ('Informática',   false, '2006-01-01', '2011-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Occidente Servicios Contables')),
    ('Negocios Internacionales', True, '2012-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Yucatán Comercio Internacional')),

    -- 8) Ricardo Ortiz Martínez (H) i=8 empresas: 8,9,10,11
    ('Administración', false, '1997-01-01', '2001-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Oriente Sistemas Empresariales')),
    ('Contaduría',    false, '2002-01-01', '2006-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Occidente Servicios Contables')),
    ('Informática',   false, '2007-01-01', '2012-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Yucatán Comercio Internacional')),
    ('Negocios Internacionales', True, '2013-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Caribe Gestión Empresarial')),

    -- 9) Paola Ruiz Delgado (A) i=9 empresas: 9,10,11,12
    ('Administración', false, '1990-01-01', '1994-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Occidente Servicios Contables')),
    ('Contaduría',    false, '1995-01-01', '1999-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Yucatán Comercio Internacional')),
    ('Informática',   false, '2000-01-01', '2005-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Caribe Gestión Empresarial')),
    ('Negocios Internacionales', True, '2006-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Quisqueya Tecnología')),

    -- 10) Víctor Hugo Cabrera León (B) i=10 empresas: 10,11,12,13
    ('Administración', false, '1991-01-01', '1995-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Yucatán Comercio Internacional')),
    ('Contaduría',    false, '1996-01-01', '2000-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Caribe Gestión Empresarial')),
    ('Informática',   false, '2001-01-01', '2006-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Quisqueya Tecnología')),
    ('Negocios Internacionales', True, '2007-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Andina Soluciones Contables')),

    -- 11) Gabriela Torres Chávez (C) i=11 empresas: 11,12,13,14
    ('Administración', false, '1992-01-01', '1996-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Caribe Gestión Empresarial')),
    ('Contaduría',    false, '1997-01-01', '2001-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Quisqueya Tecnología')),
    ('Informática',   false, '2002-01-01', '2007-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Andina Soluciones Contables')),
    ('Negocios Internacionales', True, '2008-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Café Digital Innovación')),

    -- 12) Alonso Medina Rojas (D) i=12 empresas: 12,13,14,15
    ('Administración', false, '1993-01-01', '1997-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Quisqueya Tecnología')),
    ('Contaduría',    false, '1998-01-01', '2002-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Andina Soluciones Contables')),
    ('Informática',   false, '2003-01-01', '2008-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Café Digital Innovación')),
    ('Negocios Internacionales', True, '2009-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Sakura Global Business')),

    -- 13) Karla Domínguez Salas (E) i=13 empresas: 13,14,15,16
    ('Administración', false, '1994-01-01', '1998-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Andina Soluciones Contables')),
    ('Contaduría',    false, '1999-01-01', '2003-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Café Digital Innovación')),
    ('Informática',   false, '2004-01-01', '2009-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Sakura Global Business')),
    ('Negocios Internacionales', True, '2010-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Nippon Systems')),

    -- 14) Diego Salazar Varela (F) i=14 empresas: 14,15,16,17
    ('Administración', false, '1995-01-01', '1999-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Café Digital Innovación')),
    ('Contaduría',    false, '2000-01-01', '2004-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Sakura Global Business')),
    ('Informática',   false, '2005-01-01', '2010-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Nippon Systems')),
    ('Negocios Internacionales', True, '2011-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Maple Accounting Group')),

    -- 15) Fernanda Aguilar Pineda (G) i=15 empresas: 15,16,17,18
    ('Administración', false, '1996-01-01', '2000-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Sakura Global Business')),
    ('Contaduría',    false, '2001-01-01', '2005-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Nippon Systems')),
    ('Informática',   false, '2006-01-01', '2011-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Maple Accounting Group')),
    ('Negocios Internacionales', True, '2012-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Northern Tech Solutions')),

    -- 16) Manuel Andrade Cortés (H) i=16 empresas: 16,17,18,19
    ('Administración', false, '1997-01-01', '2001-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Nippon Systems')),
    ('Contaduría',    false, '2002-01-01', '2006-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Maple Accounting Group')),
    ('Informática',   false, '2007-01-01', '2012-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Northern Tech Solutions')),
    ('Negocios Internacionales', True, '2013-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Eagle International Trade')),

    -- 17) Beatriz Castañeda Luna (A) i=17 empresas: 17,18,19,20
    ('Administración', false, '1990-01-01', '1994-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Maple Accounting Group')),
    ('Contaduría',    false, '1995-01-01', '1999-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Northern Tech Solutions')),
    ('Informática',   false, '2000-01-01', '2005-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Eagle International Trade')),
    ('Negocios Internacionales', True, '2006-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacific Data Corp')),

    -- 18) Rodrigo Fuentes Valencia (B) i=18 empresas: 18,19,20,1
    ('Administración', false, '1991-01-01', '1995-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Northern Tech Solutions')),
    ('Contaduría',    false, '1996-01-01', '2000-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Eagle International Trade')),
    ('Informática',   false, '2001-01-01', '2006-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacific Data Corp')),
    ('Negocios Internacionales', True, '2007-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Azteca Administración S.A. de C.V.')),

    -- 19) Elena Romero Padilla (C) i=19 empresas: 19,20,1,2
    ('Administración', false, '1992-01-01', '1996-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Eagle International Trade')),
    ('Contaduría',    false, '1997-01-01', '2001-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacific Data Corp')),
    ('Informática',   false, '2002-01-01', '2007-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Azteca Administración S.A. de C.V.')),
    ('Negocios Internacionales', True, '2008-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Norte Contadores Asociados')),

    -- 20) Héctor Bautista Arriaga (D) i=20 empresas: 20,1,2,3
    ('Administración', false, '1993-01-01', '1997-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacific Data Corp')),
    ('Contaduría',    false, '1998-01-01', '2002-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Azteca Administración S.A. de C.V.')),
    ('Informática',   false, '2003-01-01', '2008-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Norte Contadores Asociados')),
    ('Negocios Internacionales', True, '2009-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'TecnoBajío Informática')),

    -- 21) Camila Herrera Rosario (E) i=21 empresas: 1,2,3,4
    ('Administración', false, '1994-01-01', '1998-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Azteca Administración S.A. de C.V.')),
    ('Contaduría',    false, '1999-01-01', '2003-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Norte Contadores Asociados')),
    ('Informática',   false, '2004-01-01', '2009-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'TecnoBajío Informática')),
    ('Negocios Internacionales', True, '2010-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Global MX Negocios')),

    -- 22) Mateo Núñez Batista (F) i=22 empresas: 2,3,4,5
    ('Administración', false, '1995-01-01', '1999-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Norte Contadores Asociados')),
    ('Contaduría',    false, '2000-01-01', '2004-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'TecnoBajío Informática')),
    ('Informática',   false, '2005-01-01', '2010-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Global MX Negocios')),
    ('Negocios Internacionales', True, '2011-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Valle Innovación Digital')),

    -- 23) Juliana Córdoba Restrepo (G) i=23 empresas: 3,4,5,6
    ('Administración', false, '1996-01-01', '2000-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'TecnoBajío Informática')),
    ('Contaduría',    false, '2001-01-01', '2005-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Global MX Negocios')),
    ('Informática',   false, '2006-01-01', '2011-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Valle Innovación Digital')),
    ('Negocios Internacionales', True, '2012-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacífico Finanzas')),

    -- 24) Santiago Vélez Montoya (H) i=24 empresas: 4,5,6,7
    ('Administración', false, '1997-01-01', '2001-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Global MX Negocios')),
    ('Contaduría',    false, '2002-01-01', '2006-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Valle Innovación Digital')),
    ('Informática',   false, '2007-01-01', '2012-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacífico Finanzas')),
    ('Negocios Internacionales', True, '2013-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Capital del Centro Consultores')),

    -- 25) Akira Tanaka Nakamura (A) i=25 empresas: 5,6,7,8
    ('Administración', false, '1990-01-01', '1994-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Valle Innovación Digital')),
    ('Contaduría',    false, '1995-01-01', '1999-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacífico Finanzas')),
    ('Informática',   false, '2000-01-01', '2005-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Capital del Centro Consultores')),
    ('Negocios Internacionales', True, '2006-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Oriente Sistemas Empresariales')),

    -- 26) Emily Carter Thompson (B) i=26 empresas: 6,7,8,9
    ('Administración', false, '1991-01-01', '1995-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Pacífico Finanzas')),
    ('Contaduría',    false, '1996-01-01', '2000-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Capital del Centro Consultores')),
    ('Informática',   false, '2001-01-01', '2006-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Oriente Sistemas Empresariales')),
    ('Negocios Internacionales', True, '2007-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Occidente Servicios Contables')),

    -- 27) Michael Johnson Smith (C) i=27 empresas: 7,8,9,10
    ('Administración', false, '1992-01-01', '1996-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Capital del Centro Consultores')),
    ('Contaduría',    false, '1997-01-01', '2001-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Oriente Sistemas Empresariales')),
    ('Informática',   false, '2002-01-01', '2007-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Occidente Servicios Contables')),
    ('Negocios Internacionales', True, '2008-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Yucatán Comercio Internacional')),

    -- 28) Sarah Williams Brown (D) i=28 empresas: 8,9,10,11
    ('Administración', false, '1993-01-01', '1997-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Oriente Sistemas Empresariales')),
    ('Contaduría',    false, '1998-01-01', '2002-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Occidente Servicios Contables')),
    ('Informática',   false, '2003-01-01', '2008-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Yucatán Comercio Internacional')),
    ('Negocios Internacionales', True, '2009-01-01', '2024-12-31', (SELECT id_empresa FROM empresa WHERE nombre = 'Caribe Gestión Empresarial'));

---------------------------------------------------------
-- grado
---------------------------------------------------------
INSERT INTO public.grado (titulo, anio, id_nivel, id_institucion, id_pais) VALUES
    -- === MÉXICO ===
    -- 1) Ana María López Rivera (México) - Patrón A (Lic, Esp, Ing, Mtr) instituciones rotativas (UNAM, IPN, UDG, UANL)
    ('Licenciatura en Administración', 2002, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Especialidad en Contaduría', 2005, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2008, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Negocios Internacionales', 2012, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 2) Carlos Eduardo Sánchez Gómez (México) - Patrón B (TSU, Lic, Mtr, Dr)
    ('TSU en Administración', 1999, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Licenciatura en Contaduría', 2003, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Informática', 2007, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Doctorado en Negocios Internacionales', 2013, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 3) Lucía Fernández Morales (México) - Patrón C (Mtr, TSU, Lic, Esp)
    ('Maestría en Administración', 2010, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('TSU en Contaduría', 2001, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Licenciatura en Informática', 2004, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Especialidad en Negocios Internacionales', 2015, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 4) Jorge Alberto Ramírez Torres (México) - Patrón D (Dr, Mtr, Ing, PDr)
    ('Doctorado en Administración', 2011, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Contaduría', 2006, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2002, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Posdoctorado en Negocios Internacionales', 2018, (SELECT id_nivel FROM nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 5) Daniela Pérez Castillo (México) - Patrón A
    ('Licenciatura en Administración', 2000, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Especialidad en Contaduría', 2004, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2009, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Negocios Internacionales', 2013, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 6) Miguel Ángel Hernández Cruz (México) - Patrón B
    ('TSU en Administración', 1998, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Licenciatura en Contaduría', 2002, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Informática', 2006, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Doctorado en Negocios Internacionales', 2016, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 7) Sofía Navarro Jiménez (México)
    ('TSU en Administración', 2003, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Licenciatura en Contaduría', 2007, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma Metropolitana'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Informática', 2012, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico y de Estudios Superiores de Monterrey'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Doctorado en Negocios Internacionales', 2018, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 8) Ricardo Ortiz Martínez (México)
    ('Licenciatura en Administración', 1998, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Especialidad en Contaduría', 2001, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Benemérita Universidad Autónoma de Puebla'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2005, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Negocios Internacionales', 2010, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 9) Paola Ruiz Delgado (México)
    ('TSU en Administración', 2000, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad del Valle de México'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Licenciatura en Contaduría', 2004, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma del Estado de México'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2008, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Negocios Internacionales', 2014, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico y de Estudios Superiores de Monterrey'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 10) Víctor Hugo Cabrera León (México)
    ('Licenciatura en Administración', 1995, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Contaduría', 2000, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2003, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Posdoctorado en Negocios Internacionales', 2022, (SELECT id_nivel FROM nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 11) Gabriela Torres Chávez (México)
    ('TSU en Administración', 1999, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Tecnológica de Querétaro'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Licenciatura en Contaduría', 2003, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Querétaro'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Informática', 2009, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de las Américas Puebla'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Doctorado en Negocios Internacionales', 2015, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico Autónomo de México'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 12) Alonso Medina Rojas (México)
    ('Licenciatura en Administración', 2006, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Chihuahua'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Especialidad en Contaduría', 2010, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de San Luis Potosí'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2012, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Baja California'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Negocios Internacionales', 2017, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Monterrey'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 13) Karla Domínguez Salas (México)
    ('TSU en Administración', 2004, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Tecnológica de Puebla'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Licenciatura en Contaduría', 2008, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Colima'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Informática', 2013, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma del Estado de México'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Doctorado en Negocios Internacionales', 2021, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 14) Diego Salazar Varela (México)
    ('Licenciatura en Administración', 2001, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Guadalajara'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Especialidad en Contaduría', 2006, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Aguascalientes'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2009, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico de Estudios Superiores de Occidente'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Negocios Internacionales', 2016, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico y de Estudios Superiores de Monterrey'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 15) Fernanda Aguilar Pineda (México)
    ('TSU en Administración', 2005, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Tecnológica de Tula-Tepeji'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Licenciatura en Contaduría', 2009, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Zacatecas'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Informática', 2014, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Yucatán'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Posdoctorado en Negocios Internacionales', 2023, (SELECT id_nivel FROM nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM institucion WHERE nombre='El Colegio de México'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 16) Manuel Andrade Cortés (México)
    ('Licenciatura en Administración', 1997, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Benemérita Universidad Autónoma de Puebla'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Contaduría', 2002, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2006, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma Metropolitana'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Doctorado en Negocios Internacionales', 2012, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 17) Beatriz Castañeda Luna (México)
    ('TSU en Administración', 1993, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Tecnológica del Valle de Toluca'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Licenciatura en Contaduría', 1997, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Oaxaca Benito Juárez'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Informática', 2003, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Michoacana de San Nicolás de Hidalgo'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Doctorado en Negocios Internacionales', 2011, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Iberoamericana'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 18) Rodrigo Fuentes Valencia (México)
    ('Licenciatura en Administración', 2000, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Coahuila'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Especialidad en Contaduría', 2004, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Juárez del Estado de Durango'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2007, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Centro de Enseñanza Técnica y Superior'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Negocios Internacionales', 2013, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Panamericana'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 19) Elena Romero Padilla (México)
    ('TSU en Administración', 1996, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Baja California'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Licenciatura en Contaduría', 2000, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Colima'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Informática', 2008, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma del Estado de Quintana Roo'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Doctorado en Negocios Internacionales', 2016, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico Autónomo de México'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- 20) Héctor Bautista Arriaga (México)
    ('Licenciatura en Administración', 1994, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Morelos'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Especialidad en Contaduría', 1998, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Sinaloa'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Ingeniería en Informática', 2002, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Centro de Investigación y de Estudios Avanzados del IPN'), (SELECT id_pais FROM pais WHERE nombre='México')),
    ('Maestría en Negocios Internacionales', 2007, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Tecnológica de México'), (SELECT id_pais FROM pais WHERE nombre='México')),

    -- === REPÚBLICA DOMINICANA ===
    -- 21) Camila Herrera Rosario (República Dominicana) - cubrir 4 disciplinas, incluir PDr en conjunto global
    ('Licenciatura en Administración', 2009, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo'), (SELECT id_pais FROM pais WHERE nombre='República Dominicana')),
    ('Especialidad en Contaduría', 2013, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo'), (SELECT id_pais FROM pais WHERE nombre='República Dominicana')),
    ('Ingeniería en Informática', 2015, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo'), (SELECT id_pais FROM pais WHERE nombre='República Dominicana')),
    ('Maestría en Negocios Internacionales', 2019, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo'), (SELECT id_pais FROM pais WHERE nombre='República Dominicana')),

    -- 22) Mateo Núñez Batista (República Dominicana)
    ('TSU en Administración', 2001, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo'), (SELECT id_pais FROM pais WHERE nombre='República Dominicana')),
    ('Licenciatura en Contaduría', 2005, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo'), (SELECT id_pais FROM pais WHERE nombre='República Dominicana')),
    ('Maestría en Informática', 2010, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo'), (SELECT id_pais FROM pais WHERE nombre='República Dominicana')),
    ('Doctorado en Negocios Internacionales', 2017, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo'), (SELECT id_pais FROM pais WHERE nombre='República Dominicana')),

    -- === COLOMBIA ===
    -- 23) Juliana Córdoba Restrepo (Colombia)
    ('Licenciatura en Administración', 2004, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia'), (SELECT id_pais FROM pais WHERE nombre='Colombia')),
    ('Especialidad en Contaduría', 2008, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia'), (SELECT id_pais FROM pais WHERE nombre='Colombia')),
    ('Ingeniería en Informática', 2011, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia'), (SELECT id_pais FROM pais WHERE nombre='Colombia')),
    ('Maestría en Negocios Internacionales', 2016, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia'), (SELECT id_pais FROM pais WHERE nombre='Colombia')),

    -- 24) Santiago Vélez Montoya (Colombia)
    ('TSU en Administración', 1997, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia'), (SELECT id_pais FROM pais WHERE nombre='Colombia')),
    ('Licenciatura en Contaduría', 2001, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia'), (SELECT id_pais FROM pais WHERE nombre='Colombia')),
    ('Maestría en Informática', 2009, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia'), (SELECT id_pais FROM pais WHERE nombre='Colombia')),
    ('Doctorado en Negocios Internacionales', 2018, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia'), (SELECT id_pais FROM pais WHERE nombre='Colombia')),

    -- === JAPÓN ===
    -- 25) Akira Tanaka Nakamura (Japón)
    ('Licenciatura en Administración', 2003, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Tokio'), (SELECT id_pais FROM pais WHERE nombre='Japón')),
    ('Especialidad en Contaduría', 2007, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Tokio'), (SELECT id_pais FROM pais WHERE nombre='Japón')),
    ('Ingeniería en Informática', 2012, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Tokio'), (SELECT id_pais FROM pais WHERE nombre='Japón')),
    ('Posdoctorado en Negocios Internacionales', 2021, (SELECT id_nivel FROM nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Tokio'), (SELECT id_pais FROM pais WHERE nombre='Japón')),

    -- === CANADÁ ===
    -- 26) Emily Carter Thompson (Canadá)
    ('Licenciatura en Administración', 2006, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Toronto'), (SELECT id_pais FROM pais WHERE nombre='Canadá')),
    ('Especialidad en Contaduría', 2010, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Toronto'), (SELECT id_pais FROM pais WHERE nombre='Canadá')),
    ('Maestría en Informática', 2014, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Toronto'), (SELECT id_pais FROM pais WHERE nombre='Canadá')),
    ('Doctorado en Negocios Internacionales', 2020, (SELECT id_nivel FROM nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Toronto'), (SELECT id_pais FROM pais WHERE nombre='Canadá')),

    -- === ESTADOS UNIDOS ===
    -- 27) Michael Johnson Smith (Estados Unidos)
    ('TSU en Administración', 1995, (SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard'), (SELECT id_pais FROM pais WHERE nombre='Estados Unidos')),
    ('Licenciatura en Contaduría', 1999, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard'), (SELECT id_pais FROM pais WHERE nombre='Estados Unidos')),
    ('Ingeniería en Informática', 2004, (SELECT id_nivel FROM nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard'), (SELECT id_pais FROM pais WHERE nombre='Estados Unidos')),
    ('Maestría en Negocios Internacionales', 2011, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard'), (SELECT id_pais FROM pais WHERE nombre='Estados Unidos')),

    -- 28) Sarah Williams Brown (Estados Unidos)
    ('Licenciatura en Administración', 2008, (SELECT id_nivel FROM nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard'), (SELECT id_pais FROM pais WHERE nombre='Estados Unidos')),
    ('Especialidad en Contaduría', 2013, (SELECT id_nivel FROM nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard'), (SELECT id_pais FROM pais WHERE nombre='Estados Unidos')),
    ('Maestría en Informática', 2016, (SELECT id_nivel FROM nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard'), (SELECT id_pais FROM pais WHERE nombre='Estados Unidos')),
    ('Posdoctorado en Negocios Internacionales', 2023, (SELECT id_nivel FROM nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard'), (SELECT id_pais FROM pais WHERE nombre='Estados Unidos'));

---------------------------------------------------------
-- equipamiento
---------------------------------------------------------
-- equipamiento activo
INSERT INTO public.equipamiento (foto, nombre, existencia)
VALUES
    ('/equipamiento/fotos/pano_azul.png','Paño azul',True),
    ('/equipamiento/fotos/mesa_adicional.png','Mesa adicional',True),
    ('/equipamiento/fotos/personalizadores.png','Personalizadores',True),
    ('/equipamiento/fotos/laptop.png','Laptop',True),
    ('/equipamiento/fotos/zoom.png','Zoom',True),
    ('/equipamiento/fotos/equipo_sonido.png','Equipo de sonido',True),
    ('/equipamiento/fotos/pantalla.png','Pantalla',True),
    ('/equipamiento/fotos/videoproyector.png','Videoproyector',True),
    ('/equipamiento/fotos/fotografo.png','Fotógrafo',True),
    ('/equipamiento/fotos/boletin.png','Boletín algo más (reportero)',True),
    ('/equipamiento/fotos/vigilancia.png','Vigilancia',True),
    ('/equipamiento/fotos/presidium.png','Presidium',True),
    ('/equipamiento/fotos/limpieza_entrada.png','Limpieza entrada',True),
    ('/equipamiento/fotos/limpieza_auditorio.png','Limpieza de auditorio',True),
    ('/equipamiento/fotos/limpieza_banos.png','Limpieza baños',True),
    ('/equipamiento/fotos/limpieza_vestidores.png','Limpieza vestidores',True),
    ('/equipamiento/fotos/abrir_auditorio.png','Abrir auditorio',True);

-- equipamiento inactivo
INSERT INTO public.equipamiento (nombre)
VALUES
    ('Atril'),
    ('Lámpara de pie'),
    ('Lámpara de mesa'),
    ('Cañón de luz'),
    ('Cañón de humo'),
    ('Cañón de burbujas'),
    ('Cañón de confeti'),
    ('Pantalla verde'),
    ('Telón rojo');

-- equipamiento de recintos y activo
INSERT INTO public.equipamiento (foto, nombre, existencia) 
VALUES
    ('/equipamiento/fotos/microfono_inalambrico.png', 'Micrófono inalámbrico', True),
    ('/equipamiento/fotos/microfono_de_solapa.png', 'Micrófono de solapa', True),
    ('/equipamiento/fotos/silla_plegable.png', 'Silla plegable', True),
    ('/equipamiento/fotos/mesa_plegable.png', 'Mesa plegable', True),
    ('/equipamiento/fotos/pizarron_acrilico.png', 'Pizarrón acrílico', True),
    ('/equipamiento/fotos/marcadores_para_pizarron.png', 'Marcadores para pizarrón', True),
    ('/equipamiento/fotos/switch_de_red.png', 'Switch de red', True),
    ('/equipamiento/fotos/punto_de_acceso_wifi.png', 'Punto de acceso WiFi', True),
    ('/equipamiento/fotos/camara_ptz.png', 'Cámara PTZ', True),
    ('/equipamiento/fotos/sistema_de_videoconferencia.png', 'Sistema de videoconferencia', True),
    ('/equipamiento/fotos/cortina_blackout.png', 'Cortina blackout', True),
    ('/equipamiento/fotos/auriculares_de_estudio.png', 'Auriculares de estudio', True),
    ('/equipamiento/fotos/grabadora_de_audio_digital.png', 'Grabadora de audio digital', True);

---------------------------------------------------------
-- recinto
---------------------------------------------------------
INSERT INTO public.recinto (nombre,latitud,longitud,aforo,croquis,id_tipo_recinto)
VALUES
    ('Auditorio Mtro. Carlos Pérez del Toro',19.324278712159654,-99.18503538465767,480,
        'https://www.google.com/maps?q=19.324278712159654,-99.18503538465767',
        (SELECT id_tipo_recinto FROM public.tipo_recinto WHERE nombre = 'Auditorio')),
    ('Aula Magna de Profesores Eméritos',19.3245169609446,-99.18476376157348,50,
        'https://www.google.com/maps?q=19.3245169609446,-99.18476376157348',
        (SELECT id_tipo_recinto FROM public.tipo_recinto WHERE nombre = 'Aula')),
    ('Auditorio C.P. Tomás López Sánchez',19.32569018583663,-99.18458590493218,50,
        'https://www.google.com/maps?q=19.32569018583663,-99.18458590493218',
        (SELECT id_tipo_recinto FROM public.tipo_recinto WHERE nombre = 'Auditorio')),
    ('Centro de Informática (CIFCA)',19.326002426331637,-99.18422689328244,80,
        'https://www.google.com/maps?q=19.326002426331637,-99.18422689328244',
        (SELECT id_tipo_recinto FROM public.tipo_recinto WHERE nombre = 'Aula')),
    ('Auditorio C.P. Alfonso Ochoa Ravizé',19.324491252154367,-99.1854765779373,100,
        'https://www.google.com/maps?q=19.324491252154367,-99.1854765779373',
        (SELECT id_tipo_recinto FROM public.tipo_recinto WHERE nombre = 'Auditorio')),
    ('Centro de Idiomas (CEDI)',19.32423975000072,-99.18554360862876,40,
        'https://www.google.com/maps?q=19.32423975000072,-99.18554360862876',
        (SELECT id_tipo_recinto FROM public.tipo_recinto WHERE nombre = 'Aula')),
    ('Aula Magna de Investigación',19.32309769543537,-99.18318304205229,50,
        'https://www.google.com/maps?q=19.32309769543537,-99.18318304205229',
        (SELECT id_tipo_recinto FROM public.tipo_recinto WHERE nombre = 'Aula')),
    ('Auditorio C.P. Arturo Elizundia Charles',19.32308553191999,-99.18310449475594,50,
        'https://www.google.com/maps?q=19.32308553191999,-99.18310449475594',
        (SELECT id_tipo_recinto FROM public.tipo_recinto WHERE nombre = 'Auditorio'));

---------------------------------------------------------
-- TABLAS HIJA
---------------------------------------------------------
-- rolxpermiso
---------------------------------------------------------
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    -- superadministrador
    --      usuario
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'crear' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'leer' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'editar' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'eliminar' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'activar_desactivar' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'resetear_contrasenia' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'leer' AND alcance = 'propietario')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'editar_perfil' AND alcance = 'propietario')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'resetear_contrasenia' AND alcance = 'propietario')),
    
    --      organigrama
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'organigrama' AND accion = 'crear' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'organigrama' AND accion = 'leer' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'organigrama' AND accion = 'editar' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'organigrama' AND accion = 'eliminar' AND alcance = 'global')),

    --      calendario_escolar
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'calendario_escolar' AND accion = 'crear' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'calendario_escolar' AND accion = 'leer' AND alcance = 'global')),

    --      evento
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'evento' AND accion = 'leer' AND alcance = 'global')),
   
    --      ponente
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'ponente' AND accion = 'leer' AND alcance = 'global')),


    --      recinto
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'recinto' AND accion = 'crear' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'recinto' AND accion = 'leer' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'recinto' AND accion = 'editar_fotografia' AND alcance = 'global')),

    --      equipamiento
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'crear' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'leer' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'activar_desactivar' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'actualizar_inventario' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'superadministrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'editar_area' AND alcance = 'global')),
    
    -- administrador
    --      usuario
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'crear' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'leer' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'eliminar' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'activar_desactivar' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'resetear_contrasenia' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'leer' AND alcance = 'propietario')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'editar_perfil' AND alcance = 'propietario')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'resetear_contrasenia' AND alcance = 'propietario')),
    
    --      organigrama
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'organigrama' AND accion = 'leer' AND alcance = 'global')),

    --      calendario_escolar
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'calendario_escolar' AND accion = 'leer' AND alcance = 'global')),

    --      evento
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'evento' AND accion = 'leer' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'evento' AND accion = 'autorizar' AND alcance = 'global')),

    --      ponente
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'ponente' AND accion = 'leer' AND alcance = 'global')),    

    --      recinto
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'recinto' AND accion = 'leer' AND alcance = 'global')),

    --      equipamiento
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'crear' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'leer' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'activar_desactivar' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'actualizar_inventario' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'administrador'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'editar_area' AND alcance = 'global')),
    
    -- funcionario
    --      usuario
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'leer' AND alcance = 'propietario')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'editar_perfil' AND alcance = 'propietario')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'usuario' AND accion = 'resetear_contrasenia' AND alcance = 'propietario')),

    --      calendario_escolar
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'calendario_escolar' AND accion = 'leer' AND alcance = 'global')),

    --      evento
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'evento' AND accion = 'crear' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'evento' AND accion = 'leer' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'evento' AND accion = 'corregir' AND alcance = 'propietario')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'evento' AND accion = 'leer' AND alcance = 'propietario')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'evento' AND accion = 'eliminar' AND alcance = 'propietario')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'evento' AND accion = 'cancelar' AND alcance = 'propietario')),

    --      ponente
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'ponente' AND accion = 'crear' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'ponente' AND accion = 'leer' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'ponente' AND accion = 'agregar_datos' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'ponente' AND accion = 'editar_biografia' AND alcance = 'global')),

    --      recinto
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'recinto' AND accion = 'leer' AND alcance = 'global')),

    --      equipamiento
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'leer' AND alcance = 'global')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'solicitar' AND alcance = 'propietario')),
    (
        (SELECT id_rol_usuario 
            FROM rol_usuario 
            WHERE nombre = 'funcionario'),
        (SELECT id_permiso 
            FROM permiso 
            WHERE recurso = 'equipamiento' AND accion = 'leer' AND alcance = 'propietario'));

---------------------------------------------------------
-- evento_organizador
---------------------------------------------------------
INSERT INTO public.evento_organizador (id_evento, id_usuario)
VALUES
    -- Megaeventos (5 c/u)
    -- Semana Académica de Administración 2025-1
    ((SELECT id_evento FROM evento WHERE nombre='Semana Académica de Administración 2025-1'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Semana Académica de Administración 2025-1'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='esanchez')),
    ((SELECT id_evento FROM evento WHERE nombre='Semana Académica de Administración 2025-1'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='flopez')),
    ((SELECT id_evento FROM evento WHERE nombre='Semana Académica de Administración 2025-1'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='gnavarro')),
    ((SELECT id_evento FROM evento WHERE nombre='Semana Académica de Administración 2025-1'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='hramirez')),

    -- Congreso de Contaduría 2025
    ((SELECT id_evento FROM evento WHERE nombre='Congreso de Contaduría 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo')),
    ((SELECT id_evento FROM evento WHERE nombre='Congreso de Contaduría 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='vximenez')),
    ((SELECT id_evento FROM evento WHERE nombre='Congreso de Contaduría 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='wyanez')),
    ((SELECT id_evento FROM evento WHERE nombre='Congreso de Contaduría 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='yacosta')),
    ((SELECT id_evento FROM evento WHERE nombre='Congreso de Contaduría 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='zbautista')),

    -- Seminario de Informática 2025
    ((SELECT id_evento FROM evento WHERE nombre='Seminario de Informática 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Seminario de Informática 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='esanchez')),
    ((SELECT id_evento FROM evento WHERE nombre='Seminario de Informática 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='flopez')),
    ((SELECT id_evento FROM evento WHERE nombre='Seminario de Informática 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='gnavarro')),
    ((SELECT id_evento FROM evento WHERE nombre='Seminario de Informática 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='hramirez')),

    -- Simposio de Negocios Internacionales 2025
    ((SELECT id_evento FROM evento WHERE nombre='Simposio de Negocios Internacionales 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo')),
    ((SELECT id_evento FROM evento WHERE nombre='Simposio de Negocios Internacionales 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='vximenez')),
    ((SELECT id_evento FROM evento WHERE nombre='Simposio de Negocios Internacionales 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='wyanez')),
    ((SELECT id_evento FROM evento WHERE nombre='Simposio de Negocios Internacionales 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='yacosta')),
    ((SELECT id_evento FROM evento WHERE nombre='Simposio de Negocios Internacionales 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='zbautista')),

    -- Resto de eventos (2 c/u)
    -- Taller de liderazgo ágil
    ((SELECT id_evento FROM evento WHERE nombre='Taller de liderazgo ágil'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Taller de liderazgo ágil'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo')),

    -- Conversatorio: Gestión del cambio
    ((SELECT id_evento FROM evento WHERE nombre='Conversatorio: Gestión del cambio'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='esanchez')),
    ((SELECT id_evento FROM evento WHERE nombre='Conversatorio: Gestión del cambio'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='vximenez')),

    -- Charla: OKRs en empresas medianas
    ((SELECT id_evento FROM evento WHERE nombre='Charla: OKRs en empresas medianas'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='flopez')),
    ((SELECT id_evento FROM evento WHERE nombre='Charla: OKRs en empresas medianas'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='wyanez')),

    -- Seminario de Planeación Estratégica
    ((SELECT id_evento FROM evento WHERE nombre='Seminario de Planeación Estratégica'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='gnavarro')),
    ((SELECT id_evento FROM evento WHERE nombre='Seminario de Planeación Estratégica'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='yacosta')),

    -- Conferencia: Cultura organizacional
    ((SELECT id_evento FROM evento WHERE nombre='Conferencia: Cultura organizacional'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='hramirez')),
    ((SELECT id_evento FROM evento WHERE nombre='Conferencia: Cultura organizacional'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='zbautista')),

    -- Foro: Innovación y productividad
    ((SELECT id_evento FROM evento WHERE nombre='Foro: Innovación y productividad'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Foro: Innovación y productividad'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo')),

    -- Presentación de libro: Dirección Moderna
    ((SELECT id_evento FROM evento WHERE nombre='Presentación de libro: Dirección Moderna'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='esanchez')),
    ((SELECT id_evento FROM evento WHERE nombre='Presentación de libro: Dirección Moderna'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='vximenez')),

    -- Taller de negociación
    ((SELECT id_evento FROM evento WHERE nombre='Taller de negociación'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='flopez')),
    ((SELECT id_evento FROM evento WHERE nombre='Taller de negociación'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='wyanez')),

    -- Conversatorio: Gestión del talento
    ((SELECT id_evento FROM evento WHERE nombre='Conversatorio: Gestión del talento'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='gnavarro')),
    ((SELECT id_evento FROM evento WHERE nombre='Conversatorio: Gestión del talento'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='yacosta')),

    -- Charla: Indicadores clave (KPIs)
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Indicadores clave (KPIs)'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='hramirez')),
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Indicadores clave (KPIs)'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='zbautista')),

    -- Congreso estudiantil de innovación
    ((SELECT id_evento FROM evento WHERE nombre='Congreso estudiantil de innovación'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Congreso estudiantil de innovación'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo')),

    -- Taller de NIIF para PYMES
    ((SELECT id_evento FROM evento WHERE nombre='Taller de NIIF para PYMES'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='esanchez')),
    ((SELECT id_evento FROM evento WHERE nombre='Taller de NIIF para PYMES'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='vximenez')),

    -- Foro: Auditoría continua
    ((SELECT id_evento FROM evento WHERE nombre='Foro: Auditoría continua'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='flopez')),
    ((SELECT id_evento FROM evento WHERE nombre='Foro: Auditoría continua'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='wyanez')),

    -- Conferencia: Ética profesional
    ((SELECT id_evento FROM evento WHERE nombre='Conferencia: Ética profesional'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='gnavarro')),
    ((SELECT id_evento FROM evento WHERE nombre='Conferencia: Ética profesional'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='yacosta')),

    -- Seminario de impuestos 2025
    ((SELECT id_evento FROM evento WHERE nombre='Seminario de impuestos 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='hramirez')),
    ((SELECT id_evento FROM evento WHERE nombre='Seminario de impuestos 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='zbautista')),

    -- Charla: Contabilidad de costos
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Contabilidad de costos'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Contabilidad de costos'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo')),

    -- Conversatorio: Controles internos
    ((SELECT id_evento FROM evento WHERE nombre='Conversatorio: Controles internos'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='esanchez')),
    ((SELECT id_evento FROM evento WHERE nombre='Conversatorio: Controles internos'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='vximenez')),

    -- Presentación de libro: Casos de auditoría
    ((SELECT id_evento FROM evento WHERE nombre='Presentación de libro: Casos de auditoría'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='flopez')),
    ((SELECT id_evento FROM evento WHERE nombre='Presentación de libro: Casos de auditoría'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='wyanez')),

    -- Taller de conciliaciones bancarias
    ((SELECT id_evento FROM evento WHERE nombre='Taller de conciliaciones bancarias'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='gnavarro')),
    ((SELECT id_evento FROM evento WHERE nombre='Taller de conciliaciones bancarias'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='yacosta')),

    -- Conferencia: Gobierno corporativo
    ((SELECT id_evento FROM evento WHERE nombre='Conferencia: Gobierno corporativo'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='hramirez')),
    ((SELECT id_evento FROM evento WHERE nombre='Conferencia: Gobierno corporativo'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='zbautista')),

    -- Simposio de auditoría interna
    ((SELECT id_evento FROM evento WHERE nombre='Simposio de auditoría interna'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Simposio de auditoría interna'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo')),

    -- Taller: Microservicios en práctica
    ((SELECT id_evento FROM evento WHERE nombre='Taller: Microservicios en práctica'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='esanchez')),
    ((SELECT id_evento FROM evento WHERE nombre='Taller: Microservicios en práctica'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='vximenez')),

    -- Conversatorio: IA Responsable
    ((SELECT id_evento FROM evento WHERE nombre='Conversatorio: IA Responsable'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='flopez')),
    ((SELECT id_evento FROM evento WHERE nombre='Conversatorio: IA Responsable'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='wyanez')),

    -- Charla: Observabilidad moderna
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Observabilidad moderna'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='gnavarro')),
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Observabilidad moderna'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='yacosta')),

    -- Conferencia: Seguridad en la nube
    ((SELECT id_evento FROM evento WHERE nombre='Conferencia: Seguridad en la nube'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='hramirez')),
    ((SELECT id_evento FROM evento WHERE nombre='Conferencia: Seguridad en la nube'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='zbautista')),

    -- Seminario: Ciencia de datos aplicada
    ((SELECT id_evento FROM evento WHERE nombre='Seminario: Ciencia de datos aplicada'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Seminario: Ciencia de datos aplicada'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo')),

    -- Foro: Ciberseguridad 2025
    ((SELECT id_evento FROM evento WHERE nombre='Foro: Ciberseguridad 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='esanchez')),
    ((SELECT id_evento FROM evento WHERE nombre='Foro: Ciberseguridad 2025'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='vximenez')),

    -- Taller: DevOps con contenedores
    ((SELECT id_evento FROM evento WHERE nombre='Taller: DevOps con contenedores'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='flopez')),
    ((SELECT id_evento FROM evento WHERE nombre='Taller: DevOps con contenedores'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='wyanez')),

    -- Presentación de libro: Arquitecturas escalables
    ((SELECT id_evento FROM evento WHERE nombre='Presentación de libro: Arquitecturas escalables'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='gnavarro')),
    ((SELECT id_evento FROM evento WHERE nombre='Presentación de libro: Arquitecturas escalables'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='yacosta')),

    -- Simposio de Ingeniería de Software
    ((SELECT id_evento FROM evento WHERE nombre='Simposio de Ingeniería de Software'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='hramirez')),
    ((SELECT id_evento FROM evento WHERE nombre='Simposio de Ingeniería de Software'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='zbautista')),

    -- Charla: Testing con IA
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Testing con IA'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Testing con IA'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo')),

    -- Taller: Estrategias de entrada a mercados
    ((SELECT id_evento FROM evento WHERE nombre='Taller: Estrategias de entrada a mercados'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='esanchez')),
    ((SELECT id_evento FROM evento WHERE nombre='Taller: Estrategias de entrada a mercados'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='vximenez')),

    -- Conversatorio: Nearshoring en LatAm
    ((SELECT id_evento FROM evento WHERE nombre='Conversatorio: Nearshoring en LatAm'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='flopez')),
    ((SELECT id_evento FROM evento WHERE nombre='Conversatorio: Nearshoring en LatAm'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='wyanez')),

    -- Charla: Reglas de origen (T-MEC)
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Reglas de origen (T-MEC)'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='gnavarro')),
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Reglas de origen (T-MEC)'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='yacosta')),

    -- Seminario: Logística internacional
    ((SELECT id_evento FROM evento WHERE nombre='Seminario: Logística internacional'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='hramirez')),
    ((SELECT id_evento FROM evento WHERE nombre='Seminario: Logística internacional'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='zbautista')),

    -- Foro: Comercio electrónico transfronterizo
    ((SELECT id_evento FROM evento WHERE nombre='Foro: Comercio electrónico transfronterizo'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Foro: Comercio electrónico transfronterizo'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo')),

    -- Presentación de libro: Estrategia Global
    ((SELECT id_evento FROM evento WHERE nombre='Presentación de libro: Estrategia Global'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='esanchez')),
    ((SELECT id_evento FROM evento WHERE nombre='Presentación de libro: Estrategia Global'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='vximenez')),

    -- Seminario: Tratados comerciales emergentes
    ((SELECT id_evento FROM evento WHERE nombre='Seminario: Tratados comerciales emergentes'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='flopez')),
    ((SELECT id_evento FROM evento WHERE nombre='Seminario: Tratados comerciales emergentes'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='wyanez')),

    -- Conferencia: Gestión de riesgo país
    ((SELECT id_evento FROM evento WHERE nombre='Conferencia: Gestión de riesgo país'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='gnavarro')),
    ((SELECT id_evento FROM evento WHERE nombre='Conferencia: Gestión de riesgo país'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='yacosta')),

    -- Simposio: Negociación intercultural
    ((SELECT id_evento FROM evento WHERE nombre='Simposio: Negociación intercultural'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='hramirez')),
    ((SELECT id_evento FROM evento WHERE nombre='Simposio: Negociación intercultural'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='zbautista')),

    -- Charla: Inteligencia de mercados
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Inteligencia de mercados'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='dvega')),
    ((SELECT id_evento FROM evento WHERE nombre='Charla: Inteligencia de mercados'), (SELECT id_usuario FROM usuario WHERE nombre_usuario='icastillo'));

---------------------------------------------------------
-- participacion
---------------------------------------------------------
INSERT INTO public.participacion (id_evento, id_ponente, reconocimiento) 
VALUES
    -- 1. Taller de liderazgo ágil
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller de liderazgo ágil'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera'),
        '/eventos/reconocimientos/taller_de_liderazgo_agil.ana_maria_lopez_rivera.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller de liderazgo ágil'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez'),
        '/eventos/reconocimientos/taller_de_liderazgo_agil.carlos_eduardo_sanchez_gomez.pdf'),

    -- 2. Conversatorio: Gestión del cambio
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conversatorio: Gestión del cambio'),
        (SELECT id_ponente 
            FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales'),
        '/eventos/reconocimientos/conversatorio_gestion_del_cambio.lucia_fernandez_morales.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conversatorio: Gestión del cambio'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres'),
        '/eventos/reconocimientos/conversatorio_gestion_del_cambio.jorge_alberto_ramirez_torres.pdf'),

    -- 3. Charla: OKRs en empresas medianas
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: OKRs en empresas medianas'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo'),
        '/eventos/reconocimientos/charla_okrs_en_empresas_medianas.daniela_perez_castillo.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: OKRs en empresas medianas'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz'),
        '/eventos/reconocimientos/charla_okrs_en_empresas_medianas.miguel_angel_hernandez_cruz.pdf'),

    -- 4. Seminario de Planeación Estratégica
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Seminario de Planeación Estratégica'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez'),
        '/eventos/reconocimientos/seminario_de_planeacion_estrategica.sofia_navarro_jimenez.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Seminario de Planeación Estratégica'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez'),
        '/eventos/reconocimientos/seminario_de_planeacion_estrategica.ricardo_ortiz_martinez.pdf'),

    -- 5. Conferencia: Cultura organizacional
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conferencia: Cultura organizacional'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado'),
        '/eventos/reconocimientos/conferencia_cultura_organizacional.paola_ruiz_delgado.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conferencia: Cultura organizacional'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León'),
        '/eventos/reconocimientos/conferencia_cultura_organizacional.victor_hugo_cabrera_leon.pdf'),

    -- 6. Foro: Innovación y productividad
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Foro: Innovación y productividad'),
        (SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez'),
        '/eventos/reconocimientos/foro_innovacion_y_productividad.gabriela_torres_chavez.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Foro: Innovación y productividad'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas'),
        '/eventos/reconocimientos/foro_innovacion_y_productividad.alonso_medina_rojas.pdf'),

    -- 7. Presentación de libro: Dirección Moderna
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Presentación de libro: Dirección Moderna'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas'),
        '/eventos/reconocimientos/presentacion_de_libro_direccion_moderna.karla_dominguez_salas.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Presentación de libro: Dirección Moderna'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela'),
        '/eventos/reconocimientos/presentacion_de_libro_direccion_moderna.diego_salazar_varela.pdf'),

    -- 8. Taller de negociación
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller de negociación'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda'),
        '/eventos/reconocimientos/taller_de_negociacion.fernanda_aguilar_pineda.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller de negociación'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés'),
        '/eventos/reconocimientos/taller_de_negociacion.manuel_andrade_cortes.pdf'),

    -- 9. Conversatorio: Gestión del talento
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conversatorio: Gestión del talento'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna'),
        '/eventos/reconocimientos/conversatorio_gestion_del_talento.beatriz_castaneda_luna.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conversatorio: Gestión del talento'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia'),
        '/eventos/reconocimientos/conversatorio_gestion_del_talento.rodrigo_fuentes_valencia.pdf'),

    -- 10. Charla: Indicadores clave (KPIs)
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Indicadores clave (KPIs)'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla'),
        '/eventos/reconocimientos/charla_indicadores_clave_kpis.elena_romero_padilla.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Indicadores clave (KPIs)'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga'),
        '/eventos/reconocimientos/charla_indicadores_clave_kpis.hector_bautista_arriaga.pdf'),

    -- 11. Congreso estudiantil de innovación
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Congreso estudiantil de innovación'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario'),
        '/eventos/reconocimientos/congreso_estudiantil_de_innovacion.camila_herrera_rosario.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Congreso estudiantil de innovación'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista'),
        '/eventos/reconocimientos/congreso_estudiantil_de_innovacion.mateo_nunez_batista.pdf'),

    -- 12. Taller de NIIF para PYMES
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller de NIIF para PYMES'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo'),
        '/eventos/reconocimientos/taller_de_niif_para_pymes.juliana_cordoba_restrepo.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller de NIIF para PYMES'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya'),
        '/eventos/reconocimientos/taller_de_niif_para_pymes.santiago_velez_montoya.pdf'),

    -- 13. Foro: Auditoría continua
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Foro: Auditoría continua'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura'),
        '/eventos/reconocimientos/foro_auditoria_continua.akira_tanaka_nakamura.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Foro: Auditoría continua'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson'),
        '/eventos/reconocimientos/foro_auditoria_continua.emily_carter_thompson.pdf'),

    -- 14. Conferencia: Ética profesional
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conferencia: Ética profesional'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith'),
        '/eventos/reconocimientos/conferencia_etica_profesional.michael_johnson_smith.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conferencia: Ética profesional'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown'),
        '/eventos/reconocimientos/conferencia_etica_profesional.sarah_williams_brown.pdf'),

    -- 15. Seminario de impuestos 2025
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Seminario de impuestos 2025'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera'),
        '/eventos/reconocimientos/seminario_de_impuestos_2025.ana_maria_lopez_rivera.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Seminario de impuestos 2025'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales'),
        '/eventos/reconocimientos/seminario_de_impuestos_2025.lucia_fernandez_morales.pdf'),

    -- 16. Charla: Contabilidad de costos
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Contabilidad de costos'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez'),
        '/eventos/reconocimientos/charla_contabilidad_de_costos.carlos_eduardo_sanchez_gomez.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Contabilidad de costos'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres'),
        '/eventos/reconocimientos/charla_contabilidad_de_costos.jorge_alberto_ramirez_torres.pdf'),

    -- 17. Conversatorio: Controles internos
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conversatorio: Controles internos'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo'),
        '/eventos/reconocimientos/conversatorio_controles_internos.daniela_perez_castillo.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conversatorio: Controles internos'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez'),
        '/eventos/reconocimientos/conversatorio_controles_internos.sofia_navarro_jimenez.pdf'),

    -- 18. Presentación de libro: Casos de auditoría
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Presentación de libro: Casos de auditoría'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz'),
        '/eventos/reconocimientos/presentacion_de_libro_casos_de_auditoria.miguel_angel_hernandez_cruz.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Presentación de libro: Casos de auditoría'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez'),
        '/eventos/reconocimientos/presentacion_de_libro_casos_de_auditoria.ricardo_ortiz_martinez.pdf'),

    -- 19. Taller de conciliaciones bancarias
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller de conciliaciones bancarias'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado'),
        '/eventos/reconocimientos/taller_de_conciliaciones_bancarias.paola_ruiz_delgado.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller de conciliaciones bancarias'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez'),
        '/eventos/reconocimientos/taller_de_conciliaciones_bancarias.gabriela_torres_chavez.pdf'),

    -- 20. Conferencia: Gobierno corporativo
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conferencia: Gobierno corporativo'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León'),
        '/eventos/reconocimientos/conferencia_gobierno_corporativo.victor_hugo_cabrera_leon.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conferencia: Gobierno corporativo'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas'),
        '/eventos/reconocimientos/conferencia_gobierno_corporativo.alonso_medina_rojas.pdf'),

    -- 21. Simposio de auditoría interna
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Simposio de auditoría interna'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas'),
        '/eventos/reconocimientos/simposio_de_auditoria_interna.karla_dominguez_salas.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Simposio de auditoría interna'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda'),
        '/eventos/reconocimientos/simposio_de_auditoria_interna.fernanda_aguilar_pineda.pdf'),

    -- 22. Taller: Microservicios en práctica
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller: Microservicios en práctica'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés'),
        '/eventos/reconocimientos/taller_microservicios_en_practica.manuel_andrade_cortes.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller: Microservicios en práctica'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia'),
        '/eventos/reconocimientos/taller_microservicios_en_practica.rodrigo_fuentes_valencia.pdf'),

    -- 23. Conversatorio: IA Responsable
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conversatorio: IA Responsable'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela'),
        '/eventos/reconocimientos/conversatorio_ia_responsable.diego_salazar_varela.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conversatorio: IA Responsable'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna'),
        '/eventos/reconocimientos/conversatorio_ia_responsable.beatriz_castaneda_luna.pdf'),

    -- 24. Charla: Observabilidad moderna
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Observabilidad moderna'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla'),
        '/eventos/reconocimientos/charla_observabilidad_moderna.elena_romero_padilla.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Observabilidad moderna'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario'),
        '/eventos/reconocimientos/charla_observabilidad_moderna.camila_herrera_rosario.pdf'),

    -- 25. Conferencia: Seguridad en la nube
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conferencia: Seguridad en la nube'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga'),
        '/eventos/reconocimientos/conferencia_seguridad_en_la_nube.hector_bautista_arriaga.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conferencia: Seguridad en la nube'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista'),
        '/eventos/reconocimientos/conferencia_seguridad_en_la_nube.mateo_nunez_batista.pdf'),

    -- 26. Seminario: Ciencia de datos aplicada
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Seminario: Ciencia de datos aplicada'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo'),
        '/eventos/reconocimientos/seminario_ciencia_de_datos_aplicada.juliana_cordoba_restrepo.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Seminario: Ciencia de datos aplicada'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura'),
        '/eventos/reconocimientos/seminario_ciencia_de_datos_aplicada.akira_tanaka_nakamura.pdf'),

    -- 27. Foro: Ciberseguridad 2025
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Foro: Ciberseguridad 2025'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya'),
        '/eventos/reconocimientos/foro_ciberseguridad_2025.santiago_velez_montoya.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Foro: Ciberseguridad 2025'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson'),
        '/eventos/reconocimientos/foro_ciberseguridad_2025.emily_carter_thompson.pdf'),

    -- 28. Taller: DevOps con contenedores
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller: DevOps con contenedores'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith'),
        '/eventos/reconocimientos/taller_devops_con_contenedores.michael_johnson_smith.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller: DevOps con contenedores'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera'),
        '/eventos/reconocimientos/taller_devops_con_contenedores.ana_maria_lopez_rivera.pdf'),

    -- 29. Presentación de libro: Arquitecturas escalables
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Presentación de libro: Arquitecturas escalables'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez'),
        '/eventos/reconocimientos/presentacion_de_libro_arquitecturas_escalables.carlos_eduardo_sanchez_gomez.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Presentación de libro: Arquitecturas escalables'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales'),
        '/eventos/reconocimientos/presentacion_de_libro_arquitecturas_escalables.lucia_fernandez_morales.pdf'),

    -- 30. Simposio de Ingeniería de Software
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Simposio de Ingeniería de Software'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres'),
        '/eventos/reconocimientos/simposio_de_ingenieria_de_software.jorge_alberto_ramirez_torres.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Simposio de Ingeniería de Software'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo'),
        '/eventos/reconocimientos/simposio_de_ingenieria_de_software.daniela_perez_castillo.pdf'),

    -- 31. Charla: Testing con IA
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Testing con IA'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz'),
        '/eventos/reconocimientos/charla_testing_con_ia.miguel_angel_hernandez_cruz.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Testing con IA'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado'),
        '/eventos/reconocimientos/charla_testing_con_ia.paola_ruiz_delgado.pdf'),

    -- 32. Taller: Estrategias de entrada a mercados
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller: Estrategias de entrada a mercados'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez'),
        '/eventos/reconocimientos/taller_estrategias_de_entrada_a_mercados.sofia_navarro_jimenez.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Taller: Estrategias de entrada a mercados'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León'),
        '/eventos/reconocimientos/taller_estrategias_de_entrada_a_mercados.victor_hugo_cabrera_leon.pdf'),

    -- 33. Conversatorio: Nearshoring en LatAm
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conversatorio: Nearshoring en LatAm'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez'),
        '/eventos/reconocimientos/conversatorio_nearshoring_en_latam.ricardo_ortiz_martinez.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conversatorio: Nearshoring en LatAm'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez'),
        '/eventos/reconocimientos/conversatorio_nearshoring_en_latam.gabriela_torres_chavez.pdf'),

    -- 34. Charla: Reglas de origen (T-MEC)
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Reglas de origen (T-MEC)'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas'),
        '/eventos/reconocimientos/charla_reglas_de_origen_t_mec.karla_dominguez_salas.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Reglas de origen (T-MEC)'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés'),
        '/eventos/reconocimientos/charla_reglas_de_origen_t_mec.manuel_andrade_cortes.pdf'),

    -- 35. Seminario: Logística internacional
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Seminario: Logística internacional'),
        (SELECT id_ponente FROM ponente 
            WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda'),
        '/eventos/reconocimientos/seminario_logistica_internacional.fernanda_aguilar_pineda.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Seminario: Logística internacional'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés'),
        '/eventos/reconocimientos/seminario_logistica_internacional.manuel_andrade_cortes.pdf'),

    -- 36. Foro: Comercio electrónico transfronterizo
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Foro: Comercio electrónico transfronterizo'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela'),
        '/eventos/reconocimientos/foro_comercio_electronico_transfronterizo.diego_salazar_varela.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Foro: Comercio electrónico transfronterizo'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna'),
        '/eventos/reconocimientos/foro_comercio_electronico_transfronterizo.beatriz_castaneda_luna.pdf'),

    -- 37. Presentación de libro: Estrategia Global
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Presentación de libro: Estrategia Global'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia'),
        '/eventos/reconocimientos/presentacion_de_libro_estrategia_global.rodrigo_fuentes_valencia.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Presentación de libro: Estrategia Global'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla'),
        '/eventos/reconocimientos/presentacion_de_libro_estrategia_global.elena_romero_padilla.pdf'),

    -- 38. Seminario: Tratados comerciales emergentes
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Seminario: Tratados comerciales emergentes'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga'),
        '/eventos/reconocimientos/seminario_tratados_comerciales_emergentes.hector_bautista_arriaga.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Seminario: Tratados comerciales emergentes'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo'),
        '/eventos/reconocimientos/seminario_tratados_comerciales_emergentes.juliana_cordoba_restrepo.pdf'),

    -- 39. Conferencia: Gestión de riesgo país
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conferencia: Gestión de riesgo país'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario'),
        '/eventos/reconocimientos/conferencia_gestion_de_riesgo_pais.camila_herrera_rosario.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Conferencia: Gestión de riesgo país'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya'),
        '/eventos/reconocimientos/conferencia_gestion_de_riesgo_pais.santiago_velez_montoya.pdf'),

    -- 40. Simposio: Negociación intercultural
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Simposio: Negociación intercultural'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista'),
        '/eventos/reconocimientos/simposio_negociacion_intercultural.mateo_nunez_batista.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Simposio: Negociación intercultural'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson'),
        '/eventos/reconocimientos/simposio_negociacion_intercultural.emily_carter_thompson.pdf'),

    -- 41. Charla: Inteligencia de mercados
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Inteligencia de mercados'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura'),
        '/eventos/reconocimientos/charla_inteligencia_de_mercados.akira_tanaka_nakamura.pdf'),
    ((SELECT id_evento 
        FROM evento 
        WHERE nombre = 'Charla: Inteligencia de mercados'),
        (SELECT id_ponente 
            FROM ponente 
            WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith'),
        '/eventos/reconocimientos/charla_inteligencia_de_mercados.michael_johnson_smith.pdf'),

    -- eventos con traslape
    -- Clínica de liderazgo colaborativo
    ((SELECT id_evento FROM evento WHERE nombre = 'Clínica de liderazgo colaborativo'),
     (SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda'),
     '/eventos/reconocimientos/clinica_liderazgo_colaborativo.fernanda_aguilar_pineda.pdf'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Clínica de liderazgo colaborativo'),
     (SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés'),
     '/eventos/reconocimientos/clinica_liderazgo_colaborativo.manuel_andrade_cortes.pdf'),

    -- Conversatorio: Innovación y cambio cultural
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Innovación y cambio cultural'),
     (SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna'),
     '/eventos/reconocimientos/conversatorio_innovacion_cambio_cultural.beatriz_castaneda_luna.pdf'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Innovación y cambio cultural'),
     (SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia'),
     '/eventos/reconocimientos/conversatorio_innovacion_cambio_cultural.rodrigo_fuentes_valencia.pdf'),

    -- Charla: KPIs y accountability en equipos ágiles
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: KPIs y accountability en equipos ágiles'),
     (SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla'),
     '/eventos/reconocimientos/charla_kpis_accountability.elena_romero_padilla.pdf'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: KPIs y accountability en equipos ágiles'),
     (SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga'),
     '/eventos/reconocimientos/charla_kpis_accountability.hector_bautista_arriaga.pdf'),

    -- Seminario de Diseño de Estrategia Competitiva
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de Diseño de Estrategia Competitiva'),
     (SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario'),
     '/eventos/reconocimientos/seminario_diseno_estrategia_competitiva.camila_herrera_rosario.pdf'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de Diseño de Estrategia Competitiva'),
     (SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista'),
     '/eventos/reconocimientos/seminario_diseno_estrategia_competitiva.mateo_nunez_batista.pdf'),

    -- Conferencia: Liderazgo y pertenencia organizacional
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Liderazgo y pertenencia organizacional'),
     (SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo'),
     '/eventos/reconocimientos/conferencia_liderazgo_pertenencia.juliana_cordoba_restrepo.pdf'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Liderazgo y pertenencia organizacional'),
     (SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya'),
     '/eventos/reconocimientos/conferencia_liderazgo_pertenencia.santiago_velez_montoya.pdf');



---------------------------------------------------------
-- semblanzaxreconocimiento
---------------------------------------------------------
INSERT INTO public.semblanzaxreconocimiento (id_semblanza, id_reconocimiento) VALUES
    -- 1. Ana María López Rivera1, C1, I1, N1
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Innovación en Administración' AND organizacion='Colegio Iberoamericano de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Contaduría' AND organizacion='Instituto Panamericano de Contabilidad')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Innovación en Informática' AND organizacion='Sociedad de Ingenierías de Software')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Negocios Internacionales' AND organizacion='Consejo de Comercio Global')),

    -- 2. Carlos Eduardo Sánchez Gómez2, C2, I2, N2
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Gestión Administrativa' AND organizacion='Asociación Latinoamericana de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Auditoría' AND organizacion='Colegio Nacional de Contadores')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Tecnologías de la Información' AND organizacion='Asociación de Profesionales TI')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Comercio Exterior' AND organizacion='Cámara Panamericana de Comercio')),

    -- 3. Lucía Fernández Morales3, C3, I3, N3
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Administración' AND organizacion='Consejo Internacional de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Ética Contable' AND organizacion='Federación de Contadores de las Américas')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Transformación Digital' AND organizacion='Cámara de Innovación Tecnológica')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Estrategia Global' AND organizacion='Foro Iberoamericano de Negocios')),

    -- 4. Jorge Alberto Ramírez Torres1, C1, I1, N1
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Innovación en Administración' AND organizacion='Colegio Iberoamericano de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Contaduría' AND organizacion='Instituto Panamericano de Contabilidad')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Innovación en Informática' AND organizacion='Sociedad de Ingenierías de Software')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Negocios Internacionales' AND organizacion='Consejo de Comercio Global')),

    -- 5. Daniela Pérez Castillo2, C2, I2, N2
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Gestión Administrativa' AND organizacion='Asociación Latinoamericana de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Auditoría' AND organizacion='Colegio Nacional de Contadores')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Tecnologías de la Información' AND organizacion='Asociación de Profesionales TI')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Comercio Exterior' AND organizacion='Cámara Panamericana de Comercio')),

    -- 6. Miguel Ángel Hernández Cruz3, C3, I3, N3
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Administración' AND organizacion='Consejo Internacional de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Ética Contable' AND organizacion='Federación de Contadores de las Américas')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Transformación Digital' AND organizacion='Cámara de Innovación Tecnológica')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Estrategia Global' AND organizacion='Foro Iberoamericano de Negocios')),

    -- 7. Sofía Navarro Jiménez1, C1, I1, N1
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Innovación en Administración' AND organizacion='Colegio Iberoamericano de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Contaduría' AND organizacion='Instituto Panamericano de Contabilidad')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Innovación en Informática' AND organizacion='Sociedad de Ingenierías de Software')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Negocios Internacionales' AND organizacion='Consejo de Comercio Global')),

    -- 8. Ricardo Ortiz Martínez2, C2, I2, N2
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Gestión Administrativa' AND organizacion='Asociación Latinoamericana de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Auditoría' AND organizacion='Colegio Nacional de Contadores')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Tecnologías de la Información' AND organizacion='Asociación de Profesionales TI')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Comercio Exterior' AND organizacion='Cámara Panamericana de Comercio')),

    -- 9. Paola Ruiz Delgado3, C3, I3, N3
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Administración' AND organizacion='Consejo Internacional de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Ética Contable' AND organizacion='Federación de Contadores de las Américas')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Transformación Digital' AND organizacion='Cámara de Innovación Tecnológica')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Estrategia Global' AND organizacion='Foro Iberoamericano de Negocios')),

    -- 10. Víctor Hugo Cabrera León1, C1, I1, N1
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Innovación en Administración' AND organizacion='Colegio Iberoamericano de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Contaduría' AND organizacion='Instituto Panamericano de Contabilidad')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Innovación en Informática' AND organizacion='Sociedad de Ingenierías de Software')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Negocios Internacionales' AND organizacion='Consejo de Comercio Global')),

    -- 11. Gabriela Torres Chávez2, C2, I2, N2
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Gestión Administrativa' AND organizacion='Asociación Latinoamericana de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Auditoría' AND organizacion='Colegio Nacional de Contadores')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Tecnologías de la Información' AND organizacion='Asociación de Profesionales TI')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Comercio Exterior' AND organizacion='Cámara Panamericana de Comercio')),

    -- 12. Alonso Medina Rojas3, C3, I3, N3
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Administración' AND organizacion='Consejo Internacional de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Ética Contable' AND organizacion='Federación de Contadores de las Américas')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Transformación Digital' AND organizacion='Cámara de Innovación Tecnológica')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Estrategia Global' AND organizacion='Foro Iberoamericano de Negocios')),

    -- 13. Karla Domínguez Salas1, C1, I1, N1
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Innovación en Administración' AND organizacion='Colegio Iberoamericano de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Contaduría' AND organizacion='Instituto Panamericano de Contabilidad')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Innovación en Informática' AND organizacion='Sociedad de Ingenierías de Software')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Negocios Internacionales' AND organizacion='Consejo de Comercio Global')),

    -- 14. Diego Salazar Varela2, C2, I2, N2
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Gestión Administrativa' AND organizacion='Asociación Latinoamericana de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Auditoría' AND organizacion='Colegio Nacional de Contadores')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Tecnologías de la Información' AND organizacion='Asociación de Profesionales TI')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Comercio Exterior' AND organizacion='Cámara Panamericana de Comercio')),

    -- 15. Fernanda Aguilar Pineda3, C3, I3, N3
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Administración' AND organizacion='Consejo Internacional de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Ética Contable' AND organizacion='Federación de Contadores de las Américas')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Transformación Digital' AND organizacion='Cámara de Innovación Tecnológica')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Estrategia Global' AND organizacion='Foro Iberoamericano de Negocios')),

    -- 16. Manuel Andrade Cortés1, C1, I1, N1
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Innovación en Administración' AND organizacion='Colegio Iberoamericano de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Contaduría' AND organizacion='Instituto Panamericano de Contabilidad')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Innovación en Informática' AND organizacion='Sociedad de Ingenierías de Software')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Negocios Internacionales' AND organizacion='Consejo de Comercio Global')),

    -- 17. Beatriz Castañeda Luna2, C2, I2, N2
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Gestión Administrativa' AND organizacion='Asociación Latinoamericana de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Auditoría' AND organizacion='Colegio Nacional de Contadores')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Tecnologías de la Información' AND organizacion='Asociación de Profesionales TI')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Comercio Exterior' AND organizacion='Cámara Panamericana de Comercio')),

    -- 18. Rodrigo Fuentes Valencia3, C3, I3, N3
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Administración' AND organizacion='Consejo Internacional de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Ética Contable' AND organizacion='Federación de Contadores de las Américas')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Transformación Digital' AND organizacion='Cámara de Innovación Tecnológica')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Estrategia Global' AND organizacion='Foro Iberoamericano de Negocios')),

    -- 19. Elena Romero Padilla1, C1, I1, N1
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Innovación en Administración' AND organizacion='Colegio Iberoamericano de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Contaduría' AND organizacion='Instituto Panamericano de Contabilidad')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Innovación en Informática' AND organizacion='Sociedad de Ingenierías de Software')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Negocios Internacionales' AND organizacion='Consejo de Comercio Global')),

    -- 20. Héctor Bautista Arriaga2, C2, I2, N2
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Gestión Administrativa' AND organizacion='Asociación Latinoamericana de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Auditoría' AND organizacion='Colegio Nacional de Contadores')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Tecnologías de la Información' AND organizacion='Asociación de Profesionales TI')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Comercio Exterior' AND organizacion='Cámara Panamericana de Comercio')),

    -- 21. Camila Herrera Rosario3, C3, I3, N3
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Administración' AND organizacion='Consejo Internacional de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Ética Contable' AND organizacion='Federación de Contadores de las Américas')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Transformación Digital' AND organizacion='Cámara de Innovación Tecnológica')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Estrategia Global' AND organizacion='Foro Iberoamericano de Negocios')),

    -- 22. Mateo Núñez Batista1, C1, I1, N1
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Innovación en Administración' AND organizacion='Colegio Iberoamericano de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Contaduría' AND organizacion='Instituto Panamericano de Contabilidad')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Innovación en Informática' AND organizacion='Sociedad de Ingenierías de Software')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Negocios Internacionales' AND organizacion='Consejo de Comercio Global')),

    -- 23. Juliana Córdoba Restrepo2, C2, I2, N2
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Gestión Administrativa' AND organizacion='Asociación Latinoamericana de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Auditoría' AND organizacion='Colegio Nacional de Contadores')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Tecnologías de la Información' AND organizacion='Asociación de Profesionales TI')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Comercio Exterior' AND organizacion='Cámara Panamericana de Comercio')),

    -- 24. Santiago Vélez Montoya3, C3, I3, N3
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Administración' AND organizacion='Consejo Internacional de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Ética Contable' AND organizacion='Federación de Contadores de las Américas')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Transformación Digital' AND organizacion='Cámara de Innovación Tecnológica')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Estrategia Global' AND organizacion='Foro Iberoamericano de Negocios')),

    -- 25. Akira Tanaka Nakamura1, C1, I1, N1
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Innovación en Administración' AND organizacion='Colegio Iberoamericano de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Contaduría' AND organizacion='Instituto Panamericano de Contabilidad')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Innovación en Informática' AND organizacion='Sociedad de Ingenierías de Software')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Negocios Internacionales' AND organizacion='Consejo de Comercio Global')),

    -- 26. Emily Carter Thompson2, C2, I2, N2
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Gestión Administrativa' AND organizacion='Asociación Latinoamericana de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Auditoría' AND organizacion='Colegio Nacional de Contadores')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Tecnologías de la Información' AND organizacion='Asociación de Profesionales TI')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Excelencia en Comercio Exterior' AND organizacion='Cámara Panamericana de Comercio')),

    -- 27. Michael Johnson Smith3, C3, I3, N3
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Administración' AND organizacion='Consejo Internacional de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Ética Contable' AND organizacion='Federación de Contadores de las Américas')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Transformación Digital' AND organizacion='Cámara de Innovación Tecnológica')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Liderazgo en Estrategia Global' AND organizacion='Foro Iberoamericano de Negocios')),

    -- 28. Sarah Williams Brown1, C1, I1, N1
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Premio a la Innovación en Administración' AND organizacion='Colegio Iberoamericano de Administración')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Contaduría' AND organizacion='Instituto Panamericano de Contabilidad')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Innovación en Informática' AND organizacion='Sociedad de Ingenierías de Software')),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente=(SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown')),
    (SELECT id_reconocimiento FROM reconocimiento WHERE titulo='Mérito en Negocios Internacionales' AND organizacion='Consejo de Comercio Global'));


---------------------------------------------------------
-- semblanzaxexperiencia
---------------------------------------------------------
INSERT INTO public.semblanzaxexperiencia (id_semblanza, id_experiencia) VALUES
    -- 1) Ana María López Rivera (A) empresas: Azteca, Norte, TecnoBajío, Global MX
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1990-01-01' AND fecha_fin='1994-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Azteca Administración S.A. de C.V.'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1995-01-01' AND fecha_fin='1999-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Norte Contadores Asociados'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2000-01-01' AND fecha_fin='2005-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='TecnoBajío Informática'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2006-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Global MX Negocios'))),

    -- 2) Carlos Eduardo Sánchez Gómez (B)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1991-01-01' AND fecha_fin='1995-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Norte Contadores Asociados'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1996-01-01' AND fecha_fin='2000-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='TecnoBajío Informática'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2001-01-01' AND fecha_fin='2006-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Global MX Negocios'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2007-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Valle Innovación Digital'))),

    -- 3) Lucía Fernández Morales (C)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1992-01-01' AND fecha_fin='1996-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='TecnoBajío Informática'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1997-01-01' AND fecha_fin='2001-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Global MX Negocios'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2002-01-01' AND fecha_fin='2007-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Valle Innovación Digital'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2008-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacífico Finanzas'))),

    -- 4) Jorge Alberto Ramírez Torres (D)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1993-01-01' AND fecha_fin='1997-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Global MX Negocios'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1998-01-01' AND fecha_fin='2002-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Valle Innovación Digital'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2003-01-01' AND fecha_fin='2008-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacífico Finanzas'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2009-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Capital del Centro Consultores'))),

    -- 5) Daniela Pérez Castillo (E)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1994-01-01' AND fecha_fin='1998-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Valle Innovación Digital'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1999-01-01' AND fecha_fin='2003-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacífico Finanzas'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2004-01-01' AND fecha_fin='2009-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Capital del Centro Consultores'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2010-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Oriente Sistemas Empresariales'))),

    -- 6) Miguel Ángel Hernández Cruz (F)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1995-01-01' AND fecha_fin='1999-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacífico Finanzas'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='2000-01-01' AND fecha_fin='2004-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Capital del Centro Consultores'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2005-01-01' AND fecha_fin='2010-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Oriente Sistemas Empresariales'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2011-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Occidente Servicios Contables'))),

    -- 7) Sofía Navarro Jiménez (G)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1996-01-01' AND fecha_fin='2000-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Capital del Centro Consultores'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='2001-01-01' AND fecha_fin='2005-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Oriente Sistemas Empresariales'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2006-01-01' AND fecha_fin='2011-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Occidente Servicios Contables'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2012-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Yucatán Comercio Internacional'))),

    -- 8) Ricardo Ortiz Martínez (H)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1997-01-01' AND fecha_fin='2001-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Oriente Sistemas Empresariales'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='2002-01-01' AND fecha_fin='2006-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Occidente Servicios Contables'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2007-01-01' AND fecha_fin='2012-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Yucatán Comercio Internacional'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2013-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Caribe Gestión Empresarial'))),

    -- 9) Paola Ruiz Delgado (A)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1990-01-01' AND fecha_fin='1994-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Occidente Servicios Contables'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1995-01-01' AND fecha_fin='1999-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Yucatán Comercio Internacional'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2000-01-01' AND fecha_fin='2005-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Caribe Gestión Empresarial'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2006-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Quisqueya Tecnología'))),

    -- 10) Víctor Hugo Cabrera León (B)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1991-01-01' AND fecha_fin='1995-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Yucatán Comercio Internacional'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1996-01-01' AND fecha_fin='2000-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Caribe Gestión Empresarial'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2001-01-01' AND fecha_fin='2006-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Quisqueya Tecnología'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2007-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Andina Soluciones Contables'))),

    -- 11) Gabriela Torres Chávez (C)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1992-01-01' AND fecha_fin='1996-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Caribe Gestión Empresarial'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1997-01-01' AND fecha_fin='2001-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Quisqueya Tecnología'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2002-01-01' AND fecha_fin='2007-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Andina Soluciones Contables'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2008-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Café Digital Innovación'))),

    -- 12) Alonso Medina Rojas (D)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1993-01-01' AND fecha_fin='1997-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Quisqueya Tecnología'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1998-01-01' AND fecha_fin='2002-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Andina Soluciones Contables'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2003-01-01' AND fecha_fin='2008-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Café Digital Innovación'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2009-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Sakura Global Business'))),

    -- 13) Karla Domínguez Salas (E)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1994-01-01' AND fecha_fin='1998-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Andina Soluciones Contables'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1999-01-01' AND fecha_fin='2003-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Café Digital Innovación'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2004-01-01' AND fecha_fin='2009-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Sakura Global Business'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2010-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Nippon Systems'))),

    -- 14) Diego Salazar Varela (F)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1995-01-01' AND fecha_fin='1999-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Café Digital Innovación'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='2000-01-01' AND fecha_fin='2004-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Sakura Global Business'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2005-01-01' AND fecha_fin='2010-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Nippon Systems'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2011-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Maple Accounting Group'))),

    -- 15) Fernanda Aguilar Pineda (G)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1996-01-01' AND fecha_fin='2000-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Sakura Global Business'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='2001-01-01' AND fecha_fin='2005-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Nippon Systems'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2006-01-01' AND fecha_fin='2011-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Maple Accounting Group'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2012-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Northern Tech Solutions'))),

    -- 16) Manuel Andrade Cortés (H)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1997-01-01' AND fecha_fin='2001-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Nippon Systems'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='2002-01-01' AND fecha_fin='2006-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Maple Accounting Group'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2007-01-01' AND fecha_fin='2012-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Northern Tech Solutions'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2013-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Eagle International Trade'))),

    -- 17) Beatriz Castañeda Luna (A)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1990-01-01' AND fecha_fin='1994-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Maple Accounting Group'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1995-01-01' AND fecha_fin='1999-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Northern Tech Solutions'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2000-01-01' AND fecha_fin='2005-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Eagle International Trade'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2006-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacific Data Corp'))),

    -- 18) Rodrigo Fuentes Valencia (B)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1991-01-01' AND fecha_fin='1995-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Northern Tech Solutions'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1996-01-01' AND fecha_fin='2000-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Eagle International Trade'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2001-01-01' AND fecha_fin='2006-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacific Data Corp'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2007-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Azteca Administración S.A. de C.V.'))),

    -- 19) Elena Romero Padilla (C)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1992-01-01' AND fecha_fin='1996-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Eagle International Trade'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1997-01-01' AND fecha_fin='2001-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacific Data Corp'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2002-01-01' AND fecha_fin='2007-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Azteca Administración S.A. de C.V.'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2008-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Norte Contadores Asociados'))),

    -- 20) Héctor Bautista Arriaga (D)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1993-01-01' AND fecha_fin='1997-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacific Data Corp'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1998-01-01' AND fecha_fin='2002-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Azteca Administración S.A. de C.V.'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2003-01-01' AND fecha_fin='2008-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Norte Contadores Asociados'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2009-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='TecnoBajío Informática'))),

    -- 21) Camila Herrera Rosario (E)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1994-01-01' AND fecha_fin='1998-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Azteca Administración S.A. de C.V.'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1999-01-01' AND fecha_fin='2003-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Norte Contadores Asociados'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2004-01-01' AND fecha_fin='2009-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='TecnoBajío Informática'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2010-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Global MX Negocios'))),

    -- 22) Mateo Núñez Batista (F)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1995-01-01' AND fecha_fin='1999-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Norte Contadores Asociados'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='2000-01-01' AND fecha_fin='2004-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='TecnoBajío Informática'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2005-01-01' AND fecha_fin='2010-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Global MX Negocios'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2011-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Valle Innovación Digital'))),

    -- 23) Juliana Córdoba Restrepo (G)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1996-01-01' AND fecha_fin='2000-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='TecnoBajío Informática'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='2001-01-01' AND fecha_fin='2005-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Global MX Negocios'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2006-01-01' AND fecha_fin='2011-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Valle Innovación Digital'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2012-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacífico Finanzas'))),

    -- 24) Santiago Vélez Montoya (H)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1997-01-01' AND fecha_fin='2001-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Global MX Negocios'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='2002-01-01' AND fecha_fin='2006-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Valle Innovación Digital'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2007-01-01' AND fecha_fin='2012-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacífico Finanzas'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2013-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Capital del Centro Consultores'))),

    -- 25) Akira Tanaka Nakamura (A)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1990-01-01' AND fecha_fin='1994-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Valle Innovación Digital'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1995-01-01' AND fecha_fin='1999-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacífico Finanzas'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2000-01-01' AND fecha_fin='2005-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Capital del Centro Consultores'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2006-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Oriente Sistemas Empresariales'))),

    -- 26) Emily Carter Thompson (B)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1991-01-01' AND fecha_fin='1995-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Pacífico Finanzas'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1996-01-01' AND fecha_fin='2000-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Capital del Centro Consultores'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2001-01-01' AND fecha_fin='2006-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Oriente Sistemas Empresariales'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2007-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Occidente Servicios Contables'))),

    -- 27) Michael Johnson Smith (C)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1992-01-01' AND fecha_fin='1996-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Capital del Centro Consultores'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1997-01-01' AND fecha_fin='2001-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Oriente Sistemas Empresariales'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2002-01-01' AND fecha_fin='2007-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Occidente Servicios Contables'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2008-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Yucatán Comercio Internacional'))),

    -- 28) Sarah Williams Brown (D)
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Administración' AND fecha_inicio='1993-01-01' AND fecha_fin='1997-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Oriente Sistemas Empresariales'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Contaduría' AND fecha_inicio='1998-01-01' AND fecha_fin='2002-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Occidente Servicios Contables'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Informática' AND fecha_inicio='2003-01-01' AND fecha_fin='2008-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Yucatán Comercio Internacional'))),
    ((SELECT id_semblanza FROM semblanza WHERE id_ponente = (SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown')),
    (SELECT id_experiencia FROM experiencia WHERE puesto='Negocios Internacionales' AND fecha_inicio='2009-01-01' AND fecha_fin='2024-12-31' AND id_empresa=(SELECT id_empresa FROM empresa WHERE nombre='Caribe Gestión Empresarial')));


---------------------------------------------------------
-- semblanzaxgrado
---------------------------------------------------------
INSERT INTO public.semblanzaxgrado (id_semblanza, id_grado) VALUES
    -- === MÉXICO ===
    -- 1) Ana María López Rivera
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=2002
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2005
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2008
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Ana María' AND apellido_paterno='López' AND apellido_materno='Rivera'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2012
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 2) Carlos Eduardo Sánchez Gómez
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=1999
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=2003
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2007
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Carlos Eduardo' AND apellido_paterno='Sánchez' AND apellido_materno='Gómez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2013
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 3) Lucía Fernández Morales
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Administración'
        AND anio=2010
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Contaduría'
        AND anio=2001
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Informática'
        AND anio=2004
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Lucía' AND apellido_paterno='Fernández' AND apellido_materno='Morales'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Negocios Internacionales'
        AND anio=2015
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 4) Jorge Alberto Ramírez Torres
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Administración'
        AND anio=2011
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Contaduría'
        AND anio=2006
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2002
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Jorge Alberto' AND apellido_paterno='Ramírez' AND apellido_materno='Torres'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Posdoctorado en Negocios Internacionales'
        AND anio=2018
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Posdoctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 5) Daniela Pérez Castillo
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=2000
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2004
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2008
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Daniela' AND apellido_paterno='Pérez' AND apellido_materno='Castillo'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2013
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 6) Miguel Ángel Hernández Cruz
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=1998
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=2002
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2006
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Miguel Ángel' AND apellido_paterno='Hernández' AND apellido_materno='Cruz'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2016
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 7) Sofía Navarro Jiménez
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=2003
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=2007
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma Metropolitana')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2012
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico y de Estudios Superiores de Monterrey')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Sofía' AND apellido_paterno='Navarro' AND apellido_materno='Jiménez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2018
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 8) Ricardo Ortiz Martínez
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=1998
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2001
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Benemérita Universidad Autónoma de Puebla')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2005
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Ricardo' AND apellido_paterno='Ortiz' AND apellido_materno='Martínez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2010
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 9) Paola Ruiz Delgado
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=2000
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad del Valle de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=2004
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma del Estado de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2008
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Paola' AND apellido_paterno='Ruiz' AND apellido_materno='Delgado'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2014
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico y de Estudios Superiores de Monterrey')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 10) Víctor Hugo Cabrera León
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=1995
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Contaduría'
        AND anio=2000
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2003
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Politécnico Nacional')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Víctor Hugo' AND apellido_paterno='Cabrera' AND apellido_materno='León'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Posdoctorado en Negocios Internacionales'
        AND anio=2022
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Posdoctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Guadalajara')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 11) Gabriela Torres Chávez
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=1999
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Tecnológica de Querétaro')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=2003
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Querétaro')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2009
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de las Américas Puebla')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Gabriela' AND apellido_paterno='Torres' AND apellido_materno='Chávez'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2015
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico Autónomo de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 12) Alonso Medina Rojas
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=2006
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Chihuahua')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2010
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de San Luis Potosí')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2012
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Baja California')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Alonso' AND apellido_paterno='Medina' AND apellido_materno='Rojas'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2017
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Monterrey')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 13) Karla Domínguez Salas
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=2004
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Tecnológica de Puebla')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=2008
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Colima')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2013
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma del Estado de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Karla' AND apellido_paterno='Domínguez' AND apellido_materno='Salas'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2021
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 14) Diego Salazar Varela
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=2001
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Guadalajara')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2006
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Aguascalientes')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2009
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico de Estudios Superiores de Occidente')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Diego' AND apellido_paterno='Salazar' AND apellido_materno='Varela'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2016
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico y de Estudios Superiores de Monterrey')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 15) Fernanda Aguilar Pineda
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=2005
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Tecnológica de Tula-Tepeji')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=2009
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Zacatecas')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2014
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Yucatán')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Fernanda' AND apellido_paterno='Aguilar' AND apellido_materno='Pineda'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Posdoctorado en Negocios Internacionales'
        AND anio=2023
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Posdoctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='El Colegio de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 16) Manuel Andrade Cortés
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=1997
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Benemérita Universidad Autónoma de Puebla')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Contaduría'
        AND anio=2002
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Nuevo León')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2006
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma Metropolitana')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Manuel' AND apellido_paterno='Andrade' AND apellido_materno='Cortés'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2012
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional Autónoma de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 17) Beatriz Castañeda Luna
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=1993
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Tecnológica del Valle de Toluca')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=1997
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Oaxaca Benito Juárez')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2003
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Michoacana de San Nicolás de Hidalgo')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Beatriz' AND apellido_paterno='Castañeda' AND apellido_materno='Luna'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2011
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Iberoamericana')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 18) Rodrigo Fuentes Valencia
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=2000
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Coahuila')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2004
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Juárez del Estado de Durango')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2007
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Centro de Enseñanza Técnica y Superior')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Rodrigo' AND apellido_paterno='Fuentes' AND apellido_materno='Valencia'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2013
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Panamericana')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 19) Elena Romero Padilla
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=1996
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Baja California')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=2000
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Colima')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2008
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma del Estado de Quintana Roo')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Elena' AND apellido_paterno='Romero' AND apellido_materno='Padilla'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2016
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Instituto Tecnológico Autónomo de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),

    -- 20) Héctor Bautista Arriaga
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=1994
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Morelos')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=1998
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Sinaloa')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2002
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Centro de Investigación y de Estudios Avanzados del IPN')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Héctor' AND apellido_paterno='Bautista' AND apellido_materno='Arriaga'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2007
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Tecnológica de México')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='México'))
    ),
    -- === REPÚBLICA DOMINICANA ===
    -- 21) Camila Herrera Rosario
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=2009
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='República Dominicana'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2013
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='República Dominicana'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2015
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='República Dominicana'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Camila' AND apellido_paterno='Herrera' AND apellido_materno='Rosario'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2019
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='República Dominicana'))
    ),

    -- 22) Mateo Núñez Batista
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=2001
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='República Dominicana'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=2005
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='República Dominicana'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2010
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='República Dominicana'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Mateo' AND apellido_paterno='Núñez' AND apellido_materno='Batista'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2017
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Autónoma de Santo Domingo')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='República Dominicana'))
    ),

    -- === COLOMBIA ===
    -- 23) Juliana Córdoba Restrepo
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=2004
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Colombia'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2008
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Colombia'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2011
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Colombia'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Juliana' AND apellido_paterno='Córdoba' AND apellido_materno='Restrepo'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2016
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Colombia'))
    ),

    -- 24) Santiago Vélez Montoya
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=1997
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Colombia'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=2001
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Colombia'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2009
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Colombia'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Santiago' AND apellido_paterno='Vélez' AND apellido_materno='Montoya'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2018
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad Nacional de Colombia')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Colombia'))
    ),

    -- === JAPÓN ===
    -- 25) Akira Tanaka Nakamura
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=2003
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Tokio')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Japón'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2007
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Tokio')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Japón'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2012
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Tokio')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Japón'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Akira' AND apellido_paterno='Tanaka' AND apellido_materno='Nakamura'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Posdoctorado en Negocios Internacionales'
        AND anio=2021
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Posdoctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Tokio')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Japón'))
    ),

    -- === CANADÁ ===
    -- 26) Emily Carter Thompson
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=2006
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Toronto')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Canadá'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2010
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Toronto')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Canadá'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2014
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Toronto')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Canadá'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Emily' AND apellido_paterno='Carter' AND apellido_materno='Thompson'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Doctorado en Negocios Internacionales'
        AND anio=2020
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Doctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Toronto')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Canadá'))
    ),

    -- === ESTADOS UNIDOS ===
    -- 27) Michael Johnson Smith
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='TSU en Administración'
        AND anio=1995
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Técnico Superior Universitario')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Estados Unidos'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Contaduría'
        AND anio=1999
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Estados Unidos'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Ingeniería en Informática'
        AND anio=2004
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Ingeniería')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Estados Unidos'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Michael' AND apellido_paterno='Johnson' AND apellido_materno='Smith'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Negocios Internacionales'
        AND anio=2011
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Estados Unidos'))
    ),

    -- 28) Sarah Williams Brown
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Licenciatura en Administración'
        AND anio=2008
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Licenciatura')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Estados Unidos'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Especialidad en Contaduría'
        AND anio=2013
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Especialidad')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Estados Unidos'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Maestría en Informática'
        AND anio=2016
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Maestría')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Estados Unidos'))
    ),
    (
    (SELECT id_semblanza FROM semblanza WHERE id_ponente = (
        SELECT id_ponente FROM ponente WHERE nombre='Sarah' AND apellido_paterno='Williams' AND apellido_materno='Brown'
    )),
    (SELECT id_grado FROM grado
        WHERE titulo='Posdoctorado en Negocios Internacionales'
        AND anio=2023
        AND id_nivel=(SELECT id_nivel FROM nivel WHERE nombre='Posdoctorado')
        AND id_institucion=(SELECT id_institucion FROM institucion WHERE nombre='Universidad de Harvard')
        AND id_pais=(SELECT id_pais FROM pais WHERE nombre='Estados Unidos'))
    );

---------------------------------------------------------
-- reservacion
---------------------------------------------------------
INSERT INTO public.reservacion (id_evento, id_recinto, fecha_solicitud)
VALUES
    -- Administración
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de liderazgo ágil'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        '2025-09-04 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Gestión del cambio'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        '2025-09-04 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: OKRs en empresas medianas'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        '2025-09-04 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de Planeación Estratégica'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        '2025-08-21 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Cultura organizacional'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        '2025-08-29 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Innovación y productividad'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        '2025-09-18 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Dirección Moderna'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'),
        '2025-10-09 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de negociación'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        '2025-10-16 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Gestión del talento'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        '2025-11-07 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Indicadores clave (KPIs)'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'),
        '2025-11-20 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Congreso estudiantil de innovación'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        '2025-11-14 18:00'),

    -- Contaduría
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de NIIF para PYMES'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'),
        '2025-09-25 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Auditoría continua'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
        '2025-09-25 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Ética profesional'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'),
        '2025-09-25 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de impuestos 2025'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'),
        '2025-08-21 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Contabilidad de costos'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
        '2025-08-29 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Controles internos'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'),
        '2025-09-18 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Casos de auditoría'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'),
        '2025-10-09 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de conciliaciones bancarias'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
        '2025-10-24 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Gobierno corporativo'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'),
        '2025-11-07 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Simposio de auditoría interna'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'),
        '2025-11-20 18:00'),

    -- Informática
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: Microservicios en práctica'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        '2025-10-30 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: IA Responsable'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        '2025-10-30 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Observabilidad moderna'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        '2025-10-30 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Seguridad en la nube'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        '2025-08-21 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Ciencia de datos aplicada'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        '2025-08-29 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Ciberseguridad 2025'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        '2025-09-25 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: DevOps con contenedores'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        '2025-10-16 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Arquitecturas escalables'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        '2025-10-24 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Simposio de Ingeniería de Software'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        '2025-11-07 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Testing con IA'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        '2025-11-20 18:00'),

    -- Negocios internacionales
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: Estrategias de entrada a mercados'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'),
        '2025-08-14 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Nearshoring en LatAm'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        '2025-08-14 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Reglas de origen (T-MEC)'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'),
        '2025-08-14 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Logística internacional'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'),
        '2025-08-29 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Comercio electrónico transfronterizo'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Idiomas (CEDI)'),
        '2025-09-18 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Estrategia Global'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        '2025-10-02 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Tratados comerciales emergentes'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'),
        '2025-10-16 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Gestión de riesgo país'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        '2025-10-31 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Simposio: Negociación intercultural'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Idiomas (CEDI)'),
        '2025-11-14 18:00'),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Inteligencia de mercados'),
        (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        '2025-11-20 18:00'),
    
    -- eventos con traslape
    -- Clínica de liderazgo colaborativo (2025-09-09 10:00-12:00)
    ((SELECT id_evento FROM evento WHERE nombre = 'Clínica de liderazgo colaborativo'),
     (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
     '2025-09-01 18:00'),

    -- Conversatorio: Innovación y cambio cultural (2025-09-10 11:00-13:00)
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Innovación y cambio cultural'),
     (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'),
     '2025-09-04 18:00'),

    -- Charla: KPIs y accountability en equipos ágiles (2025-09-12 09:00-10:30)
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: KPIs y accountability en equipos ágiles'),
     (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'),
     '2025-09-05 18:00'),

    -- Seminario de Diseño de Estrategia Competitiva (2025-08-26 09:00-11:00)
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de Diseño de Estrategia Competitiva'),
     (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'),
     '2025-08-20 18:00'),

    -- Conferencia: Liderazgo y pertenencia organizacional (2025-09-03 12:00-14:00)
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Liderazgo y pertenencia organizacional'),
     (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
     '2025-08-29 18:00');

---------------------------------------------------------
-- eventoxequipamiento
---------------------------------------------------------
INSERT INTO public.eventoxequipamiento (id_evento, id_equipamiento,cantidad)
VALUES
    -- Administración (11)
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de liderazgo ágil'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 2),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de liderazgo ágil'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de liderazgo ágil'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Gestión del cambio'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Gestión del cambio'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Gestión del cambio'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: OKRs en empresas medianas'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: OKRs en empresas medianas'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: OKRs en empresas medianas'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de Planeación Estratégica'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 2),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de Planeación Estratégica'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de Planeación Estratégica'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Zoom'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Cultura organizacional'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Cultura organizacional'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Cultura organizacional'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Innovación y productividad'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Innovación y productividad'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Innovación y productividad'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),

    -- Inactivos #1
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Dirección Moderna'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Atril'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Dirección Moderna'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Dirección Moderna'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Dirección Moderna'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Lámpara de pie'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Dirección Moderna'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cañón de luz'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de negociación'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de negociación'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Mesa adicional'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de negociación'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Personalizadores'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Gestión del talento'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Gestión del talento'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Gestión del talento'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Indicadores clave (KPIs)'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Indicadores clave (KPIs)'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Indicadores clave (KPIs)'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Congreso estudiantil de innovación'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Congreso estudiantil de innovación'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Congreso estudiantil de innovación'),
        (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Vigilancia'), 1),

    -- Contaduría (10)
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de NIIF para PYMES'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de NIIF para PYMES'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de NIIF para PYMES'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Auditoría continua'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Auditoría continua'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Auditoría continua'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Ética profesional'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Ética profesional'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Ética profesional'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de impuestos 2025'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de impuestos 2025'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario de impuestos 2025'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Zoom'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Contabilidad de costos'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Contabilidad de costos'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Contabilidad de costos'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Controles internos'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Controles internos'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Controles internos'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),

    -- Inactivos #2
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Casos de auditoría'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Lámpara de mesa'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Casos de auditoría'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Casos de auditoría'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Casos de auditoría'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cañón de humo'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Casos de auditoría'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cañón de burbujas'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de conciliaciones bancarias'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de conciliaciones bancarias'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller de conciliaciones bancarias'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Gobierno corporativo'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Gobierno corporativo'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Gobierno corporativo'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Simposio de auditoría interna'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Simposio de auditoría interna'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Simposio de auditoría interna'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),

    -- Informática (10)
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: Microservicios en práctica'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: Microservicios en práctica'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: Microservicios en práctica'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: IA Responsable'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: IA Responsable'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: IA Responsable'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Observabilidad moderna'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Observabilidad moderna'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Observabilidad moderna'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),

    -- Online-only: Seguridad en la nube
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Seguridad en la nube'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Zoom'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Seguridad en la nube'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Ciencia de datos aplicada'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Ciencia de datos aplicada'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Ciencia de datos aplicada'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Ciberseguridad 2025'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Ciberseguridad 2025'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Ciberseguridad 2025'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: DevOps con contenedores'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: DevOps con contenedores'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: DevOps con contenedores'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Arquitecturas escalables'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Arquitecturas escalables'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Simposio de Ingeniería de Software'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Simposio de Ingeniería de Software'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Testing con IA'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Testing con IA'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Testing con IA'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),

    -- Negocios internacionales (10)
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: Estrategias de entrada a mercados'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: Estrategias de entrada a mercados'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Taller: Estrategias de entrada a mercados'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Nearshoring en LatAm'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Nearshoring en LatAm'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conversatorio: Nearshoring en LatAm'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Reglas de origen (T-MEC)'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Reglas de origen (T-MEC)'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Reglas de origen (T-MEC)'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Logística internacional'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Logística internacional'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Logística internacional'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Zoom'), 1),

    -- Online-only: Comercio electrónico transfronterizo
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Comercio electrónico transfronterizo'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Zoom'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Foro: Comercio electrónico transfronterizo'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),

    -- Inactivos #3
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Estrategia Global'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Telón rojo'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Estrategia Global'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Estrategia Global'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Estrategia Global'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cañón de confeti'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Presentación de libro: Estrategia Global'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla verde'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Tratados comerciales emergentes'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Tratados comerciales emergentes'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Seminario: Tratados comerciales emergentes'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Gestión de riesgo país'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Gestión de riesgo país'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Conferencia: Gestión de riesgo país'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Simposio: Negociación intercultural'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Simposio: Negociación intercultural'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1),

    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Inteligencia de mercados'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Inteligencia de mercados'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'), 1),
    ((SELECT id_evento FROM evento WHERE nombre = 'Charla: Inteligencia de mercados'),
    (SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'), 1);

---------------------------------------------------------
-- inventario_area
---------------------------------------------------------
INSERT INTO public.inventario_area (id_equipamiento, id_area, cantidad)
VALUES
    -- Actos
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Paño azul'),
    (SELECT id_area FROM area WHERE nombre = 'Actos'), 3),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Mesa adicional'),
    (SELECT id_area FROM area WHERE nombre = 'Actos'), 5),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Personalizadores'),
    (SELECT id_area FROM area WHERE nombre = 'Actos'), 2),

    -- Centro de Informática
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'),
    (SELECT id_area FROM area WHERE nombre = 'Centro de Informática'), 10),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Zoom'),
    (SELECT id_area FROM area WHERE nombre = 'Centro de Informática'), 1),

    -- Medios Audiovisuales
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'),
    (SELECT id_area FROM area WHERE nombre = 'Medios Audiovisuales'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'),
    (SELECT id_area FROM area WHERE nombre = 'Medios Audiovisuales'), 3),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'),
    (SELECT id_area FROM area WHERE nombre = 'Medios Audiovisuales'), 2),

    -- Publicaciones y Fomento Editorial
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Fotógrafo'),
    (SELECT id_area FROM area WHERE nombre = 'Publicaciones y Fomento Editorial'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Boletín algo más (reportero)'),
    (SELECT id_area FROM area WHERE nombre = 'Publicaciones y Fomento Editorial'), 2),

    -- Secretaría Administrativa
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Vigilancia'),
    (SELECT id_area FROM area WHERE nombre = 'Secretaría Administrativa'), 3),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Presidium'),
    (SELECT id_area FROM area WHERE nombre = 'Secretaría Administrativa'), 1),

    -- Limpieza
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Limpieza entrada'),
    (SELECT id_area FROM area WHERE nombre = 'Secretaría Administrativa'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Limpieza de auditorio'),
    (SELECT id_area FROM area WHERE nombre = 'Secretaría Administrativa'), 3),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Limpieza baños'),
    (SELECT id_area FROM area WHERE nombre = 'Secretaría Administrativa'), 3),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Limpieza vestidores'),
    (SELECT id_area FROM area WHERE nombre = 'Secretaría Administrativa'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Abrir auditorio'),
    (SELECT id_area FROM area WHERE nombre = 'Secretaría Administrativa'), 1);

---------------------------------------------------------
-- inventario_recinto
---------------------------------------------------------
INSERT INTO public.inventario_recinto (id_equipamiento, id_recinto, cantidad)
VALUES
    -- Auditorio Mtro. Carlos Pérez del Toro
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Micrófono inalámbrico'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 4),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Micrófono de solapa'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cámara PTZ'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Sistema de videoconferencia'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Atril'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Mesa plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 4),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Silla plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 200),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cortina blackout'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'), 1),

    -- Aula Magna de Profesores Eméritos (aula magna)
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Micrófono inalámbrico'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Atril'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Silla plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'), 100),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Mesa plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pizarrón acrílico'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Marcadores para pizarrón'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'), 8),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cámara PTZ'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'), 1),

    -- Auditorio C.P. Tomás López Sánchez (auditorio mediano)
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Micrófono inalámbrico'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'), 3),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Atril'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Silla plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'), 150),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Mesa plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'), 3),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cortina blackout'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'), 1),

    -- Centro de Informática (CIFCA)
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'), 20),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Switch de red'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Punto de acceso WiFi'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'), 4),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pizarrón acrílico'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Marcadores para pizarrón'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Informática (CIFCA)'), 12),

    -- Auditorio C.P. Alfonso Ochoa Ravizé (auditorio mediano)
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Micrófono inalámbrico'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'), 3),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Atril'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Silla plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'), 120),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Mesa plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'), 3),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cámara PTZ'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'), 1),

    -- Centro de Idiomas (CEDI)
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Auriculares de estudio'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Idiomas (CEDI)'), 40),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Grabadora de audio digital'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Idiomas (CEDI)'), 4),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Micrófono de solapa'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Idiomas (CEDI)'), 4),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Laptop'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Idiomas (CEDI)'), 10),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Idiomas (CEDI)'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Idiomas (CEDI)'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Punto de acceso WiFi'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Centro de Idiomas (CEDI)'), 2),

    -- Aula Magna de Investigación
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Micrófono inalámbrico'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Atril'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pizarrón acrílico'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Marcadores para pizarrón'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'), 10),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cámara PTZ'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Mesa plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Silla plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Aula Magna de Investigación'), 80),

    -- Auditorio C.P. Arturo Elizundia Charles (auditorio grande)
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Videoproyector'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Pantalla'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Equipo de sonido'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Micrófono inalámbrico'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'), 4),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Micrófono de solapa'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'), 2),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Atril'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Silla plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'), 180),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Mesa plegable'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'), 3),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Cámara PTZ'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'), 1),
    ((SELECT id_equipamiento FROM equipamiento WHERE nombre = 'Sistema de videoconferencia'),
    (SELECT id_recinto FROM recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'), 1);

---------------------------------------------------------
-- fotografia
---------------------------------------------------------
INSERT INTO public.fotografia (fotografia, id_recinto)
VALUES
    -- Auditorio Mtro. Carlos Pérez del Toro
    ('/recinto/fotografias/auditorio_mtro_carlos_perez_del_toro/auditorio_mtro_carlos_perez_del_toro-01.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro')),
    ('/recinto/fotografias/auditorio_mtro_carlos_perez_del_toro/auditorio_mtro_carlos_perez_del_toro-02.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro')),
    ('/recinto/fotografias/auditorio_mtro_carlos_perez_del_toro/auditorio_mtro_carlos_perez_del_toro-03.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro')),
    ('/recinto/fotografias/auditorio_mtro_carlos_perez_del_toro/auditorio_mtro_carlos_perez_del_toro-04.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro')),

    -- Aula Magna de Profesores Eméritos
    ('/recinto/fotografias/aula_magna_de_profesores_emeritos/aula_magna_de_profesores_emeritos-01.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Aula Magna de Profesores Eméritos')),
    ('/recinto/fotografias/aula_magna_de_profesores_emeritos/aula_magna_de_profesores_emeritos-02.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Aula Magna de Profesores Eméritos')),
    ('/recinto/fotografias/aula_magna_de_profesores_emeritos/aula_magna_de_profesores_emeritos-03.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Aula Magna de Profesores Eméritos')),
    ('/recinto/fotografias/aula_magna_de_profesores_emeritos/aula_magna_de_profesores_emeritos-04.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Aula Magna de Profesores Eméritos')),

    -- Auditorio C.P. Tomás López Sánchez
    ('/recinto/fotografias/auditorio_cp_tomas_lopez_sanchez/auditorio_cp_tomas_lopez_sanchez-01.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Tomás López Sánchez')),
    ('/recinto/fotografias/auditorio_cp_tomas_lopez_sanchez/auditorio_cp_tomas_lopez_sanchez-02.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Tomás López Sánchez')),
    ('/recinto/fotografias/auditorio_cp_tomas_lopez_sanchez/auditorio_cp_tomas_lopez_sanchez-03.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Tomás López Sánchez')),
    ('/recinto/fotografias/auditorio_cp_tomas_lopez_sanchez/auditorio_cp_tomas_lopez_sanchez-04.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Tomás López Sánchez')),

    -- Centro de Informática (CIFCA)
    ('/recinto/fotografias/centro_de_informatica_cifca/centro_de_informatica_cifca-01.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Centro de Informática (CIFCA)')),
    ('/recinto/fotografias/centro_de_informatica_cifca/centro_de_informatica_cifca-02.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Centro de Informática (CIFCA)')),
    ('/recinto/fotografias/centro_de_informatica_cifca/centro_de_informatica_cifca-03.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Centro de Informática (CIFCA)')),
    ('/recinto/fotografias/centro_de_informatica_cifca/centro_de_informatica_cifca-04.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Centro de Informática (CIFCA)')),

    -- Auditorio C.P. Alfonso Ochoa Ravizé
    ('/recinto/fotografias/auditorio_cp_alfonso_ochoa_ravize/auditorio_cp_alfonso_ochoa_ravize-01.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé')),
    ('/recinto/fotografias/auditorio_cp_alfonso_ochoa_ravize/auditorio_cp_alfonso_ochoa_ravize-02.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé')),
    ('/recinto/fotografias/auditorio_cp_alfonso_ochoa_ravize/auditorio_cp_alfonso_ochoa_ravize-03.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé')),
    ('/recinto/fotografias/auditorio_cp_alfonso_ochoa_ravize/auditorio_cp_alfonso_ochoa_ravize-04.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé')),

    -- Centro de Idiomas (CEDI)
    ('/recinto/fotografias/centro_de_idiomas_cedi/centro_de_idiomas_cedi-01.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Centro de Idiomas (CEDI)')),
    ('/recinto/fotografias/centro_de_idiomas_cedi/centro_de_idiomas_cedi-02.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Centro de Idiomas (CEDI)')),
    ('/recinto/fotografias/centro_de_idiomas_cedi/centro_de_idiomas_cedi-03.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Centro de Idiomas (CEDI)')),
    ('/recinto/fotografias/centro_de_idiomas_cedi/centro_de_idiomas_cedi-04.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Centro de Idiomas (CEDI)')),

    -- Aula Magna de Investigación
    ('/recinto/fotografias/aula_magna_de_investigacion/aula_magna_de_investigacion-01.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Aula Magna de Investigación')),
    ('/recinto/fotografias/aula_magna_de_investigacion/aula_magna_de_investigacion-02.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Aula Magna de Investigación')),
    ('/recinto/fotografias/aula_magna_de_investigacion/aula_magna_de_investigacion-03.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Aula Magna de Investigación')),
    ('/recinto/fotografias/aula_magna_de_investigacion/aula_magna_de_investigacion-04.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Aula Magna de Investigación')),

    -- Auditorio C.P. Arturo Elizundia Charles
    ('/recinto/fotografias/auditorio_cp_arturo_elizundia_charles/auditorio_cp_arturo_elizundia_charles-01.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Arturo Elizundia Charles')),
    ('/recinto/fotografias/auditorio_cp_arturo_elizundia_charles/auditorio_cp_arturo_elizundia_charles-02.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Arturo Elizundia Charles')),
    ('/recinto/fotografias/auditorio_cp_arturo_elizundia_charles/auditorio_cp_arturo_elizundia_charles-03.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Arturo Elizundia Charles')),
    ('/recinto/fotografias/auditorio_cp_arturo_elizundia_charles/auditorio_cp_arturo_elizundia_charles-04.png',
        (SELECT id_recinto 
            FROM recinto 
            WHERE nombre='Auditorio C.P. Arturo Elizundia Charles'));

---------------------------------------------------------
-- auditoria
---------------------------------------------------------
-- TODO : agregar datos muestra (revisar si es necesario)

COMMIT;