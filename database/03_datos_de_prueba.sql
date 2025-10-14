SET client_encoding to 'UTF8';
BEGIN;

-- TABLAS PADRE
-- permiso
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    --      usuarios
    ('usuario','crear','global','Crear usuario'),
    ('usuario','leer','global','Listar usuarios'),
    ('usuario','editar','global','Editar usuarios'),
    ('usuario','eliminar','global','Eliminar usuarios'),

    ('usuario','leer','propietario','Leer datos de usuario propio'),
    ('usuario','editar','propietario','Editar datos de usuario propio'),

    --      recintos
    ('recinto','crear','global','Crear recinto'),
    ('recinto','leer','global','Listar recintos'),
    ('recinto','editar','global','Editar recintos'),
    ('recinto','eliminar','global','Eliminar recintos'),

    --      reservaciones
    ('reservacion','crear','global','Crear reservacion'),
    ('reservacion','leer','global','Listar reservaciones'),
    ('reservacion','editar','global','Editar reservaciones'),

    ('reservacion','leer','propietario','Listar reservaciones propias'),
    ('reservacion','editar','propietario','Editar reservaciones propias'),

    --      eventos
    ('evento','crear','global','Crear eventos'),
    ('evento','leer','global','Listar eventos'),
    ('evento','editar','global','Editar eventos'),

    ('evento','leer','propietario','Listar eventos propios'),
    ('evento','editar','propietario','Editar eventos propios'),

    --      integrantes
    ('integrante','crear','global','Registra integrantes que participarian en algun evento'),
    ('integrante','leer','global','Listar integrantes que participaron en algun evento'),
    ('integrante','editar','global','Editar datos de los integrantes que participaron en algun evento'),

    --      inventarios
    ('area_inventario','crear','global','Registrar el inventario del area'),
    ('area_inventario','leer','global','Listar el inventario del area'),
    ('area_inventario','editar','global','Editar el inventario del area'),
    ('area_inventario','eliminar','global','Eliminar el inventario del area'),
    ('recinto_inventario','crear','global','Registrar el inventario del recinto'),
    ('recinto_inventario','leer','global','Listar el inventario del recinto'),
    ('recinto_inventario','editar','global','Editar el inventario del recinto'),
    ('recinto_inventario','eliminar','global','Eliminar el inventario del recinto'),

    --      catalogos
    ('catalogo','crear','global','Agrega un nuevo item a algun catalogo (ej. puesto, area, equipamiento... )'),
    ('catalogo','leer','global','Lista los items de algun catalogo (ej. puesto, area, equipamiento... )'),
    ('catalogo','eliminar','global','Elimina un item de algun catalogo (ej. puesto, area, equipamiento... )');

-- rol_usuario
INSERT INTO public.rol_usuario (nombre)
VALUES 
    ('Superadministrador'),
    ('Administrador'),
    ('Funcionario');

-- area
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('APAFCA', 'Laura Hernández', 'laura.hernandez@fca.unam.mx'),
    ('Actos', 'José Martínez', 'jose.martinez@fca.unam.mx'),
    ('Administración Escolar', 'Patricia Gómez', 'patricia.gomez@fca.unam.mx'),
    ('Biblioteca', 'Rosa Díaz', 'rosa.diaz@fca.unam.mx'),
    ('Cenapyme', 'Carlos López', 'carlos.lopez@fca.unam.mx'),
    ('Centro de Educación a Distancia', 'Verónica Sánchez', 'veronica.sanchez@fca.unam.mx'),
    ('Centro de Educación a Distancia y Gestión del Conocimiento', 'Fernando Ortega', 'fernando.ortega@fca.unam.mx'),
    ('Centro de Educación a Distancia y Gestión del Conocimiento (CEDIGEC)', 'María Pérez', 'maria.perez@fca.unam.mx'),
    ('Centro de Informática', 'Miguel Torres', 'miguel.torres@fca.unam.mx'),
    ('Centro de Idiomas (CEDI)', 'Leticia Rivera', 'leticia.rivera@fca.unam.mx'),
    ('Control Interno', 'Andrés Castillo', 'andres.castillo@fca.unam.mx'),
    ('Coordinación de Administración Avanzada', 'Héctor Navarro', 'hector.navarro@fca.unam.mx'),
    ('Coordinación de Administración Básica', 'Daniela Ruiz', 'daniela.ruiz@fca.unam.mx'),
    ('Coordinación de Asuntos Internacionales', 'Sofía Rojas', 'sofia.rojas@fca.unam.mx'),
    ('Coordinación de Auditoria', 'Ricardo Mendoza', 'ricardo.mendoza@fca.unam.mx'),
    ('Coordinación de Contabilidad', 'Gabriela Domínguez', 'gabriela.dominguez@fca.unam.mx'),
    ('Coordinación de Contabilidad Básica', 'Hugo Hernández', 'hugo.hernandez@fca.unam.mx'),
    ('Coordinación de Costos y Presupuestos', 'Carmen Jiménez', 'carmen.jimenez@fca.unam.mx'),
    ('Coordinación de Derecho', 'Luis Morales', 'luis.morales@fca.unam.mx'),
    ('Coordinación de Economía', 'Isabel Castro', 'isabel.castro@fca.unam.mx'),
    ('Coordinación de Finanzas', 'Pablo Vega', 'pablo.vega@fca.unam.mx'),
    ('Coordinación de Fiscal', 'Teresa Salazar', 'teresa.salazar@fca.unam.mx'),
    ('Coordinación de Informática', 'Sergio Álvarez', 'sergio.alvarez@fca.unam.mx'),
    ('Coordinación de Matemáticas', 'Carla Romero', 'carla.romero@fca.unam.mx'),
    ('Coordinación de Mercadotecnia', 'Javier Pineda', 'javier.pineda@fca.unam.mx'),
    ('Coordinación de Metodología de la Investigación y Ética', 'Ana Beltrán', 'ana.beltran@fca.unam.mx'),
    ('Coordinación de Operaciones', 'Julio Flores', 'julio.flores@fca.unam.mx'),
    ('Coordinación de Recursos Humanos', 'Mónica Aguilar', 'monica.aguilar@fca.unam.mx'),
    ('Coordinación del Programa de Posgrado en Ciencias de la Administración', 'Rodrigo Luna', 'rodrigo.luna@fca.unam.mx'),
    ('Departamento de Servicios Generales y Mantenimiento', 'Oscar Pérez', 'oscar.perez@fca.unam.mx'),
    ('Departamento del SUAyED (Modalidad a Distancia)', 'Claudia Campos', 'claudia.campos@fca.unam.mx'),
    ('Dirección', 'Marcos Gutiérrez', 'marcos.gutierrez@fca.unam.mx'),
    ('División de Educación Continua', 'Paola Estrada', 'paola.estrada@fca.unam.mx'),
    ('División de Estudios de Posgrado', 'Ricardo Torres', 'ricardo.torres@fca.unam.mx'),
    ('División de Investigación', 'Adriana Morales', 'adriana.morales@fca.unam.mx'),
    ('Emprendedores', 'Felipe Ramírez', 'felipe.ramirez@fca.unam.mx'),
    ('Exámenes Profesionales', 'Nadia Cruz', 'nadia.cruz@fca.unam.mx'),
    ('Jefatura de la Licenciatura en Administración', 'Daniel Castro', 'daniel.castro@fca.unam.mx'),
    ('Jefatura de la Licenciatura en Contaduría', 'María López', 'maria.lopez@fca.unam.mx'),
    ('Jefatura de la Licenciatura en Informática', 'Héctor Vega', 'hector.vega@fca.unam.mx'),
    ('Jefatura de la Licenciatura en Negocios Internacionales', 'Patricia Ramos', 'patricia.ramos@fca.unam.mx'),
    ('Licenciatura en Informática', 'Iván Rojas', 'ivan.rojas@fca.unam.mx'),
    ('Mediateca', 'Elena Navarro', 'elena.navarro@fca.unam.mx'),
    ('Medios Audiovisuales', 'Santiago Hernández', 'santiago.hernandez@fca.unam.mx'),
    ('Ninguna', 'Sin Responsable', 'ninguna@fca.unam.mx'),
    ('Oficina Jurídica', 'Carolina Pérez', 'carolina.perez@fca.unam.mx'),
    ('Oficina de Servicios Escolares', 'Roberto Díaz', 'roberto.diaz@fca.unam.mx'),
    ('Programa de Posgrado en Ciencias de la Administración', 'Liliana Campos', 'liliana.campos@fca.unam.mx'),
    ('Publicaciones y Fomento Editorial', 'Teresa González', 'teresa.gonzalez@fca.unam.mx'),
    ('SUAyED', 'Esteban Ortiz', 'esteban.ortiz@fca.unam.mx'),
    ('Secretaría Académica', 'Alejandra Flores', 'alejandra.flores@fca.unam.mx'),
    ('Secretaría Administrativa', 'Eduardo Salinas', 'eduardo.salinas@fca.unam.mx'),
    ('Secretaría Divulgación y Fomento Editorial', 'Rebeca García', 'rebeca.garcia@fca.unam.mx'),
    ('Secretaría General', 'Manuel Torres', 'manuel.torres@fca.unam.mx'),
    ('Secretaría de Cooperación Internacional', 'Valeria Soto', 'valeria.soto@fca.unam.mx'),
    ('Secretaría de Cooperación Internacional / Asociación Latinoamericana de Facultades y Escuelas de Contaduría y Administración', 'César Cabrera', 'cesar.cabrera@fca.unam.mx'),
    ('Secretaría de Cooperación Internacional. Alafec', 'Andrea Molina', 'andrea.molina@fca.unam.mx'),
    ('Secretaría de Difusión Cultural', 'Raúl Jiménez', 'raul.jimenez@fca.unam.mx'),
    ('Secretaría de Intercambio Académico y ANFECA', 'Lucía Navarro', 'lucia.navarro@fca.unam.mx'),
    ('Secretaría de Personal Docente', 'Fernando Rivera', 'fernando.rivera@fca.unam.mx'),
    ('Secretaría de Planeación Académica', 'Beatriz Morales', 'beatriz.morales@fca.unam.mx'),
    ('Secretaría de Planeación y Evaluación Académica', 'Jorge López', 'jorge.lopez@fca.unam.mx'),
    ('Secretaría de Relaciones y Extensión Universitaria', 'Cinthia Vega', 'cinthia.vega@fca.unam.mx'),
    ('Secretaría de Vinculación', 'Rafael Castro', 'rafael.castro@fca.unam.mx'),
    ('Sindicato', 'Mario Delgado', 'mario.delgado@fca.unam.mx'),
    ('Sistema de Universidad Abierta', 'Elisa Romero', 'elisa.romero@fca.unam.mx'),
    ('Sistema de Universidad Abierta y Educación a Distancia', 'José Ramírez', 'jose.ramirez@fca.unam.mx'),
    ('Subjefatura de la División de Estudios de Posgrado', 'Mariana Torres', 'mariana.torres@fca.unam.mx'),
    ('Unidad Integral de Género', 'Claudia Fernández', 'claudia.fernandez@fca.unam.mx');

-- rol_participacion
INSERT INTO public.rol_participacion (nombre)
VALUES 
    ('Ponente'),
    ('Moderador'),
    ('Presidium');

-- nivel
INSERT INTO public.nivel (nombre, siglas)
VALUES
    ('Técnico Superior Universitario', 'TSU'),
    ('Licenciatura', 'Lic'),
    ('Ingeniería', 'Ing'),
    ('Especialidad', 'Esp'),
    ('Maestría', 'Mtr'),
    ('Doctorado', 'Dr'),
    ('Posdoctorado', 'PDr');

-- institucion
INSERT INTO public.institucion (nombre, siglas)
VALUES
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
    ('Universidad Tecnológica de Xicotepec de Juárez', 'UTXJ');

-- categoria
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

-- integrante
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    -- Integrantes con semblanza (50)
    ('Juan', 'Pérez', 'Gómez', '/semblanzas/juan_perez_gomez.pdf'),
    ('Ana', 'López', 'Martínez', '/semblanzas/ana_lopez_martinez.pdf'),
    ('Carlos', 'Ramírez', 'Sánchez', '/semblanzas/carlos_ramirez_sanchez.pdf'),
    ('María', 'Fernández', 'Ruiz', '/semblanzas/maria_fernandez_ruiz.pdf'),
    ('Luis', 'García', 'Torres', '/semblanzas/luis_garcia_torres.pdf'),
    ('Sofía', 'Martínez', 'Vega', '/semblanzas/sofia_martinez_vega.pdf'),
    ('Miguel', 'Hernández', 'Castro', '/semblanzas/miguel_hernandez_castro.pdf'),
    ('Laura', 'Gómez', 'Morales', '/semblanzas/laura_gomez_morales.pdf'),
    ('Jorge', 'Díaz', 'Jiménez', '/semblanzas/jorge_diaz_jimenez.pdf'),
    ('Patricia', 'Ruiz', 'Navarro', '/semblanzas/patricia_ruiz_navarro.pdf'),
    ('Fernando', 'Torres', 'Luna', '/semblanzas/fernando_torres_luna.pdf'),
    ('Gabriela', 'Sánchez', 'Ortega', '/semblanzas/gabriela_sanchez_ortega.pdf'),
    ('Ricardo', 'Morales', 'Vargas', '/semblanzas/ricardo_morales_vargas.pdf'),
    ('Verónica', 'Castro', 'Mendoza', '/semblanzas/veronica_castro_mendoza.pdf'),
    ('Alejandro', 'Navarro', 'Salinas', '/semblanzas/alejandro_navarro_salinas.pdf'),
    ('Claudia', 'Jiménez', 'Ramos', '/semblanzas/claudia_jimenez_ramos.pdf'),
    ('Roberto', 'Luna', 'García', '/semblanzas/roberto_luna_garcia.pdf'),
    ('Isabel', 'Ortega', 'Fernández', '/semblanzas/isabel_ortega_fernandez.pdf'),
    ('Héctor', 'Vargas', 'Santos', '/semblanzas/hector_vargas_santos.pdf'),
    ('Carmen', 'Mendoza', 'Pérez', '/semblanzas/carmen_mendoza_perez.pdf'),
    ('Javier', 'Salinas', 'López', '/semblanzas/javier_salinas_lopez.pdf'),
    ('Mónica', 'Ramos', 'Martínez', '/semblanzas/monica_ramos_martinez.pdf'),
    ('Pablo', 'García', 'Ramírez', '/semblanzas/pablo_garcia_ramirez.pdf'),
    ('Teresa', 'Fernández', 'Sánchez', '/semblanzas/teresa_fernandez_sanchez.pdf'),
    ('Sergio', 'Santos', 'Torres', '/semblanzas/sergio_santos_torres.pdf'),
    ('Carla', 'Pérez', 'Morales', '/semblanzas/carla_perez_morales.pdf'),
    ('Julio', 'López', 'Navarro', '/semblanzas/julio_lopez_navarro.pdf'),
    ('Beatriz', 'Martínez', 'Jiménez', '/semblanzas/beatriz_martinez_jimenez.pdf'),
    ('Rafael', 'Ramírez', 'Ruiz', '/semblanzas/rafael_ramirez_ruiz.pdf'),
    ('Lucía', 'Sánchez', 'Castro', '/semblanzas/lucia_sanchez_castro.pdf'),
    ('Esteban', 'Torres', 'Gómez', '/semblanzas/esteban_torres_gomez.pdf'),
    ('Andrea', 'Morales', 'Díaz', '/semblanzas/andrea_morales_diaz.pdf'),
    ('Manuel', 'Navarro', 'Salazar', '/semblanzas/manuel_navarro_salazar.pdf'),
    ('Rebeca', 'Jiménez', 'Luna', '/semblanzas/rebeca_jimenez_luna.pdf'),
    ('Oscar', 'García', 'Ortega', '/semblanzas/oscar_garcia_ortega.pdf'),
    ('Nadia', 'Fernández', 'Vargas', '/semblanzas/nadia_fernandez_vargas.pdf'),
    ('Iván', 'Mendoza', 'Santos', '/semblanzas/ivan_mendoza_santos.pdf'),
    ('Elena', 'Salinas', 'Pérez', '/semblanzas/elena_salinas_perez.pdf'),
    ('Raúl', 'Ramos', 'López', '/semblanzas/raul_ramos_lopez.pdf'),
    ('Felipe', 'Martínez', 'Gómez', '/semblanzas/felipe_martinez_gomez.pdf'),
    ('Adriana', 'Ruiz', 'Morales', '/semblanzas/adriana_ruiz_morales.pdf'),
    ('Cristian', 'Hernández', 'Pérez', '/semblanzas/cristian_hernandez_perez.pdf'),

    -- Integrantes sin semblanza (10)
    ('Pedro', 'Gómez', 'López', NULL),
    ('Susana', 'Torres', 'Ramírez', NULL),
    ('Tomás', 'Sánchez', 'Fernández', NULL),
    ('Paola', 'Castro', 'Jiménez', NULL),
    ('Guillermo', 'Navarro', 'Vargas', NULL),
    ('Marina', 'Ortega', 'Salinas', NULL),
    ('Alberto', 'Luna', 'Ramos', NULL),
    ('Silvia', 'Morales', 'García', NULL),
    ('Diego', 'Pérez', 'Santos', NULL),
    ('Lorena', 'Mendoza', 'Ruiz', NULL);

-- pais
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

-- tipo
INSERT INTO public.tipo (nombre)
VALUES
    ('Aula'),
    ('Auditorio'),
    ('Salas de conferencia'),
    ('Espacios tecnológicos');

-- TABLAS PADRE-HIJA
-- puesto
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinadora de Fiscal', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Fiscal')),
    ('Coordinador de Finanzas', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Finanzas')),
    ('Coordinador de Derecho', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Derecho')),
    ('Coordinador de Administración Escolar del Centro de Idiomas', (SELECT id_area FROM public.area WHERE nombre = 'Centro de Idiomas (CEDI)')),
    ('Jefa del Centro de Informática', (SELECT id_area FROM public.area WHERE nombre = 'Centro de Informática')),
    ('Coordinador de Administración Avanzada', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Administración Avanzada')),
    ('Coordinadora de Administración Básica', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Administración Básica')),
    ('Coordinador de Auditoría', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Auditoria')),
    ('Coordinadora de Contabilidad Avanzada', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Contabilidad')),
    ('Coordinador de Contabilidad Básica', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Contabilidad Básica')),
    ('Coordinador de Costos y Presupuestos', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Costos y Presupuestos')),
    ('Coordinadora de Derecho', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Derecho')),
    ('Coordinadora de Economía', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Economía')),
    ('Coordinadora de Finanzas', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Finanzas')),
    ('Coordinador de Fiscal', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Fiscal')),
    ('Coordinador de Informática', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Informática')),       
    ('Coordinador de Matemáticas', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Matemáticas')),       
    ('Coordinador de Mercadotecnia', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Mercadotecnia')),   
    ('Coordinador de Metodología de la Investigación y Ética', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Metodología de la Investigación y Ética')),
    ('Coordinador Académico', (SELECT id_area FROM public.area WHERE nombre = 'División de Educación Continua')),
    ('Coordinador Administrativo', (SELECT id_area FROM public.area WHERE nombre = 'División de Educación Continua')),    
    ('Difusión y Promoción', (SELECT id_area FROM public.area WHERE nombre = 'División de Educación Continua')),
    ('Jefa de la División de Educación Continua', (SELECT id_area FROM public.area WHERE nombre = 'División de Educación Continua')),
    ('Coordinación de la Especialización en Fiscal', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado')),
    ('Coordinación de la Maestría en Alta Dirección', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado')),
    ('Coordinación de la Maestría en Auditoría', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado')),
    ('Coordinación de la Maestría en Finanzas', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado')),
    ('Coordinación de la Maestría en Negocios Internacionales y Maestría en Turismo', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado')),
    ('Coordinación de las Especializaciones en Alta Dirección, Recursos Humanos y Mercadotecnia', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado')),
    ('Coordinador de la Maestría en Informática Administrativa', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado')),
    ('Coordinador de las Especialidades en Alta Dirección, Recursos Humanos y Mercadotecnía', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado')),
    ('Jefa de la División de Estudios de Posgrado', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado')),
    ('Coordinadora Administrativa', (SELECT id_area FROM public.area WHERE nombre = 'División de Investigación')),        
    ('Investigador', (SELECT id_area FROM public.area WHERE nombre = 'División de Investigación')),
    ('Investigadora', (SELECT id_area FROM public.area WHERE nombre = 'División de Investigación')),
    ('Jefe de la Divisón de Investigación', (SELECT id_area FROM public.area WHERE nombre = 'División de Investigación')),
    ('Jefe de la Licenciatura en Administración', (SELECT id_area FROM public.area WHERE nombre = 'Jefatura de la Licenciatura en Administración')),
    ('Jefa de la Licenciatura en Contaduría', (SELECT id_area FROM public.area WHERE nombre = 'Jefatura de la Licenciatura en Contaduría')),
    ('Jefe de la Licenciatura en Informática', (SELECT id_area FROM public.area WHERE nombre = 'Jefatura de la Licenciatura en Informática')),
    ('Jefe de la Licenciatura en Negocios Internacionales', (SELECT id_area FROM public.area WHERE nombre = 'Jefatura de la Licenciatura en Negocios Internacionales')),
    ('Secretario de Difusión Cultural', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría de Difusión Cultural')),
    ('Coordinación de Desarrollo de Habilidades Profesionales y Personales', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría de Relaciones y Extensión Universitaria')),
    ('Coordinador deportivo', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría de Relaciones y Extensión Universitaria')),
    ('iOS Development Lab', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría de Vinculación')),
    ('Responsable del Centro Nacional de Apoyo a la Pequeña y Mediana Empresa', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría de Vinculación')),
    ('Coordinación Administrativa y Eventos', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial')),
    ('Coordinador de Préstamo Audiovisual y Servicios', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial')),
    ('Coordinador Editorial', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial')),
    ('Coordinadora de Difusión', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial')),
    ('Departamento de Audiovisuales', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial')),
    ('Fotógrafo', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial')),
    ('Operación de Aparatos Audiovisuales', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial')),
    ('Productora de video', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial')),
    ('Jefa del Sistema Universidad Abierta y Educación a Distancia', (SELECT id_area FROM public.area WHERE nombre = 'Sistema de Universidad Abierta y Educación a Distancia'));

-- usuario (contrasenia: contrasenia123)
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    -- Superadministradores
    ('coordinadora.administrativa','COAG800101ABC','Andrea','García','Acosta','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5551234567','5512345678','coordinadora.administrativa@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora Administrativa')),
    ('coordinacion.eventos','CAVE810202XYZ','Carlos','Vega','Cano','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5559876543','5598765432','coordinacion.eventos@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación Administrativa y Eventos')),

    -- Administradores
    ('jefa.educacioncontinua','EDCP800101ABC','Paola','Estrada','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5551112222','5511122233','jefa.educacioncontinua@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefa de la División de Educación Continua')),
    ('jefa.estudiosposgrado','ESPG800102DEF','Mariana','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5552223333','5522233344','jefa.estudiosposgrado@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefa de la División de Estudios de Posgrado')),
    ('jefe.investigacion','DIVI800103GHI','Oscar','Pérez','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5553334444','5533344455','jefe.investigacion@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefe de la Divisón de Investigación')),
    ('jefe.licadministracion','ADMN800104JKL','Daniel','Castro','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5554445555','5544455566','jefe.licadministracion@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefe de la Licenciatura en Administración')),
    ('jefa.liccontaduria','CONT800105MNO','María','López','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5555556666','5555566677','jefa.liccontaduria@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefa de la Licenciatura en Contaduría')),
    ('jefe.licinformatica','INFO800106PQR','Héctor','Vega','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5556667777','5566677788','jefe.licinformatica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefe de la Licenciatura en Informática')),
    ('jefe.licnegocios','NEGI800107STU','Patricia','Ramos','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5557778888','5577788899','jefe.licnegocios@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefe de la Licenciatura en Negocios Internacionales')),
    ('secretario.difusioncultural','SDCU800108VWX','Raúl','Jiménez','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5558889999','5588899900','secretario.difusioncultural@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Secretario de Difusión Cultural')),
    ('jefa.centroinformatica','CINF800109YZA','Leticia','Rivera','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5559990000','5599900011','jefa.centroinformatica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefa del Centro de Informática')),
    ('jefa.sistemaabierta','SUAE800110BCD','Elisa','Romero','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5550001111','5500011122','jefa.sistemaabierta@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefa del Sistema Universidad Abierta y Educación a Distancia')),

    -- Funcionarios
    ('coordinador.administracion.avanzada','NAVA800201ABC','Héctor','Navarro','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5551010101','5510101010','coordinador.administracion.avanzada@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Administración Avanzada')),
    ('coordinadora.administracion.basica','RUID800202DEF','Daniela','Ruiz','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5552020202','5520202020','coordinadora.administracion.basica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora de Administración Básica')),
    ('coordinador.auditoria','MEVR800203GHI','Ricardo','Mendoza','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5553030303','5530303030','coordinador.auditoria@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Auditoría')),
    ('coordinador.contabilidad.avanzada','DOGA800204JKL','Gabriela','Domínguez','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5554040404','5540404040','coordinador.contabilidad.avanzada@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora de Contabilidad Avanzada')),
    ('coordinadora.contabilidad.basica','HEHU800205MNO','Hugo','Hernández','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5555050505','5550505050','coordinadora.contabilidad.basica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Contabilidad Básica')),
    ('coordinador.costos.presupuestos','JICA800206PQR','Carmen','Jiménez','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5556060606','5560606060','coordinador.costos.presupuestos@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Costos y Presupuestos')),
    ('coordinador.derecho','MOLU800207STU','Luis','Morales','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5557070707','5570707070','coordinador.derecho@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Derecho')),
    ('coordinadora.economia','CAIS800208VWX','Isabel','Castro','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5558080808','5580808080','coordinadora.economia@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora de Economía')),
    ('coordinador.finanzas','VEPA800209YZA','Pablo','Vega','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5559090909','5590909090','coordinador.finanzas@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Finanzas')),
    ('coordinadora.fiscal','SATE800210BCD','Teresa','Salazar','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5551111111','5511111111','coordinadora.fiscal@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora de Fiscal')),
    ('coordinador.informatica','ALSE800211EFG','Sergio','Álvarez','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5552222222','5522222222','coordinador.informatica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Informática')),
    ('coordinadora.matematicas','ROCA800212HIJ','Carla','Romero','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5553333333','5533333333','coordinadora.matematicas@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Matemáticas')),
    ('coordinador.mercadotecnia','PIJA800213KLM','Javier','Pineda','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5554444444','5544444444','coordinador.mercadotecnia@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Mercadotecnia')),
    ('coordinadora.metodologia.investigacion.etica','BEAN800214NOP','Ana','Beltrán','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5555555555','5555555555','coordinadora.metodologia.investigacion.etica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Metodología de la Investigación y Ética')),
    ('coordinador.academico','ESPA800215QRS','Paola','Estrada','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5556666666','5566666666','coordinador.academico@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador Académico')),
    ('coordinador.administrativo','ESPA800216TUV','Paola','Estrada','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5557777777','5577777777','coordinador.administrativo@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador Administrativo')),
    ('difusion.promocion','ESPA800217WXY','Paola','Estrada','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5558888888','5588888888','difusion.promocion@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Difusión y Promoción')),
    ('coordinacion.especializacion.fiscal','TORR800218ZAB','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5559999999','5599999999','coordinacion.especializacion.fiscal@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de la Especialización en Fiscal')),
    ('coordinacion.maestria.alta.direccion','TORR800219BCD','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5551212121','5512121212','coordinacion.maestria.alta.direccion@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de la Maestría en Alta Dirección')),
    ('coordinacion.maestria.auditoria','TORR800220CDE','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5552323232','5523232323','coordinacion.maestria.auditoria@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de la Maestría en Auditoría')),
    ('coordinacion.maestria.finanzas','TORR800221DEF','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5553434343','5534343434','coordinacion.maestria.finanzas@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de la Maestría en Finanzas')),
    ('coordinacion.maestria.negocios.turismo','TORR800222EFG','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5554545454','5545454545','coordinacion.maestria.negocios.turismo@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de la Maestría en Negocios Internacionales y Maestría en Turismo')),
    ('coordinacion.especializaciones.alta.direccion.rh.mercadotecnia','TORR800223FGH','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5555656565','5556565656','coordinacion.especializaciones.alta.direccion.rh.mercadotecnia@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de las Especializaciones en Alta Dirección, Recursos Humanos y Mercadotecnia')),
    ('coordinador.maestria.informatica.administrativa','TORR800224GHI','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5556767676','5567676767','coordinador.maestria.informatica.administrativa@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de la Maestría en Informática Administrativa')),
    ('coordinador.deportivo','VEGA800225HIJ','Cinthia','Vega','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5557878787','5578787878','coordinador.deportivo@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador deportivo')),
    ('coordinadora.difusion','GARE800226IJK','Rebeca','García','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5558989898','5589898989','coordinadora.difusion@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora de Difusión'));

-- evento
-- Megaeventos (3)
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_categoria, id_mega_evento)
VALUES
    ('Simposio de Administración 2025','Simposio anual sobre tendencias en administración',
    '2025-12-01','2025-12-05','09:00','18:00',true,false,NULL,true,
    (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL),
    ('Congreso Internacional de Contaduría 2025','Congreso internacional con expertos en contaduría',
    '2025-12-02','2025-12-06','09:00','18:00',true,false,NULL,true,
    (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL),
    ('Semana Académica de Informática 2025','Semana académica dedicada a la informática y tecnología',
    '2025-12-03','2025-12-07','09:00','18:00',true,false,NULL,true,
    (SELECT id_categoria FROM public.categoria WHERE nombre='Semana académica'),NULL);

INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_categoria, id_mega_evento)
VALUES
-- Administración (10)
('Taller de Liderazgo Empresarial','Taller práctico sobre liderazgo en administración',
 '2025-12-04','2025-12-04','10:00','14:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Taller'),
 (SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025')),
('Conferencia de Innovación Administrativa','Conferencia sobre innovación en procesos administrativos',
 '2025-12-05','2025-12-05','11:00','13:00',false,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conferencia'),
 (SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025')),
('Conversatorio: Retos de la Administración','Conversatorio con expertos sobre retos actuales',
 '2025-11-20','2025-11-20','12:00','14:00',true,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conversatorio'),NULL),
('Charla sobre Gestión de Proyectos','Charla sobre herramientas de gestión de proyectos',
 '2025-04-05','2025-04-05','09:00','11:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Charla'),NULL),
('Seminario de Administración Pública','Seminario sobre administración pública moderna',
 '2025-09-07','2025-09-09','10:00','13:00',true,true, NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Seminario'),NULL),
('Simposio de Recursos Humanos','Simposio sobre gestión de recursos humanos',
 '2025-12-08','2025-12-10','09:00','17:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL),
('Congreso de Administración Estratégica','Congreso sobre estrategias administrativas',
 '2025-10-09','2025-10-11','09:00','18:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL),
('Foro de Emprendimiento','Foro para emprendedores en administración',
 '2025-12-10','2025-12-10','10:00','13:00',false,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Foro'),NULL),
('Presentación de libro: Administración Moderna','Presentación de libro sobre administración moderna',
 '2025-09-12','2025-09-12','12:00','14:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Presentación de libro'),NULL),
('Taller de Planeación','Taller sobre planeación estratégica',
 '2025-09-15','2025-09-15','09:00','13:00',false,true,'Cancelado por falta de inscripciones',false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Taller'),NULL),

-- Contaduría (10)
('Taller de Auditoría Financiera','Taller sobre auditoría financiera en contaduría',
 '2025-12-04','2025-12-04','10:00','14:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Taller'),
 (SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025')),
('Conferencia de Normas Contables','Conferencia sobre nuevas normas contables',
 '2025-12-05','2025-12-05','11:00','13:00',false,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conferencia'),
 (SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025')),
('Conversatorio: Ética en la Contaduría','Conversatorio sobre ética profesional',
 '2025-12-06','2025-12-06','12:00','14:00',true,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conversatorio'),
 (SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025')),
('Charla sobre Impuestos','Charla sobre actualización fiscal',
 '2025-04-10','2025-04-10','09:00','11:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Charla'),NULL),
('Seminario de Contabilidad Internacional','Seminario sobre contabilidad internacional',
 '2025-09-07','2025-09-09','10:00','13:00',true,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Seminario'),NULL),
('Simposio de Auditoría','Simposio sobre auditoría avanzada',
 '2025-12-08','2025-12-10','09:00','17:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL),
('Congreso de Contabilidad Gubernamental','Congreso sobre contabilidad en el sector público',
 '2025-10-09','2025-10-11','09:00','18:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL),
('Foro de Fiscalización','Foro sobre fiscalización y auditoría',
 '2025-12-10','2025-12-10','10:00','13:00',false,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Foro'),NULL),
('Presentación de libro: Contaduría Actual','Presentación de libro sobre contaduría actual',
 '2025-09-25','2025-09-25','12:00','14:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Presentación de libro'),NULL),
('Seminario de Costos','Seminario sobre costos en contaduría',
 '2025-09-28','2025-09-28','09:00','13:00',false,true,'Cancelado por falta de ponentes',false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Seminario'),NULL),

-- Negocios Internacionales (10)
('Taller de Comercio Exterior','Taller sobre comercio exterior y tratados internacionales',
 '2025-12-04','2025-12-04','10:00','14:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Taller'),NULL),
('Conferencia de Negocios Globales','Conferencia sobre negocios globales',
 '2025-12-05','2025-12-05','11:00','13:00',false,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conferencia'),NULL),
('Conversatorio: Oportunidades Internacionales','Conversatorio sobre oportunidades de negocios internacionales',
 '2025-11-06','2025-11-06','12:00','14:00',true,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conversatorio'),NULL),
('Charla sobre Exportaciones','Charla sobre procesos de exportación',
 '2025-04-15','2025-04-15','09:00','11:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Charla'),NULL),
('Semana Académica de Negocios Internacionales','Semana académica sobre negocios internacionales',
 '2025-12-03','2025-12-05','09:00','18:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Semana académica'),
 (SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025')),
('Simposio de Negocios Digitales','Simposio sobre negocios digitales y tecnología',
 '2025-12-08','2025-12-10','09:00','17:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL),
('Congreso de Negocios Internacionales','Congreso sobre tendencias en negocios internacionales',
 '2025-10-09','2025-10-11','09:00','18:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL),
('Foro de Inversión Extranjera','Foro sobre inversión extranjera en México',
 '2025-12-10','2025-12-10','10:00','13:00',false,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Foro'),NULL),
('Presentación de libro: Negocios Internacionales','Presentación de libro sobre negocios internacionales',
 '2025-10-05','2025-10-05','12:00','14:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Presentación de libro'),NULL),
('Congreso de Comercio','Congreso sobre comercio internacional',
 '2025-10-04','2025-10-04','09:00','13:00',false,true,'Cancelado por motivos logísticos',false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL),

-- Informática (10)
('Taller de Ciberseguridad','Taller sobre ciberseguridad y protección de datos',
 '2025-12-04','2025-12-04','10:00','14:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Taller'),
 (SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025')),
('Conferencia de Inteligencia Artificial','Conferencia sobre inteligencia artificial aplicada',
 '2025-12-05','2025-12-05','11:00','13:00',false,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conferencia'),
 (SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025')),
('Conversatorio: Tecnología y Sociedad','Conversatorio sobre el impacto de la tecnología',
 '2025-12-06','2025-12-06','12:00','14:00',true,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conversatorio'),
 (SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025')),
('Charla sobre Programación','Charla introductoria a la programación',
 '2025-04-20','2025-04-20','09:00','11:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Charla'),NULL),
('Seminario de Big Data','Seminario sobre análisis de grandes volúmenes de datos',
 '2025-09-07','2025-09-09','10:00','13:00',true,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Seminario'),NULL),
('Simposio de Innovación Tecnológica','Simposio sobre innovación en tecnología',
 '2025-12-08','2025-12-10','09:00','17:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL),
('Congreso de Informática Educativa','Congreso sobre informática aplicada a la educación',
 '2025-10-09','2025-10-11','09:00','18:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL),
('Foro de Tecnología','Foro sobre avances tecnológicos',
 '2025-12-10','2025-12-10','10:00','13:00',false,true,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Foro'),NULL),
('Presentación de libro: Informática Moderna','Presentación de libro sobre informática moderna',
 '2025-09-18','2025-09-18','12:00','14:00',true,false,NULL,false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Presentación de libro'),NULL),
('Simposio de Software Libre','Simposio sobre software libre y código abierto',
 '2025-09-20','2025-09-20','09:00','13:00',false,true,'Cancelado por falta de patrocinadores',false,
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL);

-- grado
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Técnico en Administración', (SELECT id_nivel FROM public.nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Licenciado en Administración', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Ingeniero en Administración de Empresas', (SELECT id_nivel FROM public.nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Especialista en Gestión Administrativa', (SELECT id_nivel FROM public.nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Maestro en Administración Pública', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Doctor en Administración', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Posdoctorado en Administración Estratégica', (SELECT id_nivel FROM public.nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),

('Técnico en Contaduría', (SELECT id_nivel FROM public.nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Licenciado en Contaduría', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Ingeniero en Contabilidad', (SELECT id_nivel FROM public.nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Especialista en Auditoría', (SELECT id_nivel FROM public.nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Maestro en Contabilidad Internacional', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Doctor en Contaduría', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Posdoctorado en Fiscalización', (SELECT id_nivel FROM public.nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),

('Técnico en Informática', (SELECT id_nivel FROM public.nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Licenciado en Informática', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Ingeniero en Sistemas Computacionales', (SELECT id_nivel FROM public.nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Especialista en Seguridad Informática', (SELECT id_nivel FROM public.nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Maestro en Inteligencia Artificial', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Doctor en Informática', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Posdoctorado en Big Data', (SELECT id_nivel FROM public.nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),

('Técnico en Negocios Internacionales', (SELECT id_nivel FROM public.nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Licenciado en Negocios Internacionales', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Ingeniero en Comercio Exterior', (SELECT id_nivel FROM public.nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Especialista en Negocios Digitales', (SELECT id_nivel FROM public.nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Maestro en Economía Internacional', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Doctor en Negocios Internacionales', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Posdoctorado en Comercio Internacional', (SELECT id_nivel FROM public.nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),

('Licenciado en Derecho', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Maestro en Psicología', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Doctor en Sociología', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México')),
('Licenciado en Historia', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='España')),
('Maestro en Filosofía', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Francia')),
('Doctor en Ciencias Políticas', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Estados Unidos')),
('Licenciado en Biología', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Canadá')),
('Maestro en Matemáticas', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Alemania')),
('Doctor en Física', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='China')),
('Licenciado en Ciencias Ambientales', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Guatemala')),
('Maestro en Educación', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Costa Rica'));

-- equipamiento
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    -- activos
    ('Paño azul',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Actos')),
    ('Mesa adicional',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Actos')),
    ('Personalizadores',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Actos')),
    ('Laptop',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Centro de Informática')),
    ('Zoom',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Centro de Informática')),
    ('Equipo de sonido',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales')),
    ('Pantalla',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales')),
    ('Videoproyector',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales')),
    ('Fotógrafo',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Publicaciones y Fomento Editorial')),
    ('Boletín algo más (reportero)',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Publicaciones y Fomento Editorial')),
    ('Vigilancia',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa')),
    ('Presidium',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa')),
    ('Otros',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa')),
    ('Limpieza entrada',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa')),
    ('Limpieza de auditorio',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa')),
    ('Limpieza baños',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa')),
    ('Limpieza vestidores',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa')),
    ('Abrir auditorio',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa')),

    -- inactivos
    ('Atril',False,NULL),
    ('Lámpara de pie',False,NULL),
    ('Lámpara de mesa',False,NULL),
    ('Cañón de luz',False,NULL),
    ('Cañón de humo',False,NULL),
    ('Cañón de burbujas',False,NULL),
    ('Cañón de confeti',False,NULL),
    ('Pantalla verde',False,NULL),
    ('Telón rojo',False,NULL);

-- recinto
INSERT INTO public.recinto (nombre,latitud,longitud,aforo,croquis,id_tipo)
VALUES
    ('Auditorio Mtro. Carlos Pérez del Toro',19.324278712159654,-99.18503538465767,480,'/croquis/croquis_auditorio_mtro_carlos_perez_del_toro.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Auditorio')),
    ('Aula Magna de Profesores Eméritos',19.3245169609446,-99.18476376157348,50,'/croquis/croquis_aula_magna_de_profesores_emeritos.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Aula')),
    ('Auditorio C.P. Tomás López Sánchez',19.32569018583663,-99.18458590493218,50,'/croquis/croquis_auditorio_cp_tomas_lopez_sanchez.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Auditorio')),
    ('Centro de Informática (CIFCA)',19.326002426331637,-99.18422689328244,80,'/croquis/croquis_centro_de_informatica_cifca.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Aula')),
    ('Auditorio C.P. Alfonso Ochoa Ravizé',19.324491252154367,-99.1854765779373,100,'/croquis/croquis_auditorio_cp_alfonso_ochoa_ravize.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Auditorio')),
    ('Centro de Idiomas (CEDI)',19.32423975000072,-99.18554360862876,40,'/croquis/croquis_centro_de_idiomas_cedi.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Aula')),
    ('Aula Magna de Investigación',19.32309769543537,-99.18318304205229,50,'/croquis/croquis_aula_magna_de_investigacion.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Aula')),
    ('Auditorio C.P. Arturo Elizundia Charles',19.32308553191999,-99.18310449475594,50,'/croquis/croquis_auditorio_cp_arturo_elizundia_charles.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Auditorio'));

 -- TABLAS HIJA
-- rolxpermiso
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    -- Superadministrador
    --      usuarios
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='crear' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='leer' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='editar' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='eliminar' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='leer' AND alcance='propietario')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='editar' AND alcance='propietario')),
    
    -- Administrador
    --      usuarios
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='crear' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='leer' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='editar' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='eliminar' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='leer' AND alcance='propietario')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='editar' AND alcance='propietario')),
    
    --      recintos
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto' AND accion='crear' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto' AND accion='leer' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto' AND accion='editar' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto' AND accion='eliminar' AND alcance='global')),
    
    --      reservaciones
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='reservacion' AND accion='leer' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='reservacion' AND accion='editar' AND alcance='global')),

    --      eventos
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='evento' AND accion='leer' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='evento' AND accion='editar' AND alcance='global')),

    --      inventarios
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='area_inventario' AND accion='crear' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='area_inventario' AND accion='leer' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='area_inventario' AND accion='editar' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='area_inventario' AND accion='eliminar' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto_inventario' AND accion='crear' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto_inventario' AND accion='leer' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto_inventario' AND accion='editar' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto_inventario' AND accion='eliminar' AND alcance='global')),

    --      catalogos
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='catalogo' AND accion='crear' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='catalogo' AND accion='leer' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='catalogo' AND accion='eliminar' AND alcance='global')),
    
    -- Funcionario
    --      usuarios
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='leer' AND alcance='propietario')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='editar' AND alcance='propietario')),

    --      reservaciones
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='reservacion' AND accion='crear' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='reservacion' AND accion='leer' AND alcance='propietario')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='reservacion' AND accion='editar' AND alcance='propietario')),
    
    --      eventos
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='evento' AND accion='crear' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='evento' AND accion='leer' AND alcance='propietario')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='evento' AND accion='editar' AND alcance='propietario')),
    
    --      integrantes
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='integrante' AND accion='crear' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='integrante' AND accion='leer' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='integrante' AND accion='editar' AND alcance='global')),

    --     catalogos
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='catalogo' AND accion='crear' AND alcance='global')),
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='catalogo' AND accion='leer' AND alcance='global'));
    

-- evento_organizador
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    -- Simposio de Administración 2025
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administracion.avanzada')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.administracion.basica')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.auditoria')),

    -- Congreso Internacional de Contaduría 2025
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.contabilidad.avanzada')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.contabilidad.basica')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.costos.presupuestos')),

    -- Semana Académica de Informática 2025
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.matematicas')),

    -- Taller de Liderazgo Empresarial
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administracion.avanzada')),

    -- Conferencia de Innovación Administrativa
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administrativo')),

    -- Conversatorio: Retos de la Administración
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.academico')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administrativo')),

    -- Charla sobre Gestión de Proyectos
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administracion.avanzada')),

    -- Seminario de Administración Pública
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administracion.avanzada')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.economia')),

    -- Simposio de Recursos Humanos
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.mercadotecnia')),

    -- Congreso de Administración Estratégica
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administracion.avanzada')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.costos.presupuestos')),

    -- Foro de Emprendimiento
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='difusion.promocion')),

    -- Presentación de libro: Administración Moderna
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.difusion')),

    -- Taller de Planeación
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administrativo')),

    -- Taller de Auditoría Financiera
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.auditoria')),

    -- Conferencia de Normas Contables
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.contabilidad.avanzada')),

    -- Conversatorio: Ética en la Contaduría
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.contabilidad.basica')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.auditoria')),

    -- Charla sobre Impuestos
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.fiscal')),

    -- Seminario de Contabilidad Internacional
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.contabilidad.avanzada')),

    -- Simposio de Auditoría
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.auditoria')),

    -- Congreso de Contabilidad Gubernamental
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.contabilidad.avanzada')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.contabilidad.basica')),

    -- Foro de Fiscalización
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.fiscal')),

    -- Presentación de libro: Contaduría Actual
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.difusion')),

    -- Seminario de Costos
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.costos.presupuestos')),

    -- Taller de Comercio Exterior
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo')),

    -- Conferencia de Negocios Globales
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo')),

    -- Conversatorio: Oportunidades Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.mercadotecnia')),

    -- Charla sobre Exportaciones
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo')),

    -- Semana Académica de Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo')),

    -- Simposio de Negocios Digitales
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica')),

    -- Congreso de Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo')),

    -- Foro de Inversión Extranjera
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.finanzas')),

    -- Presentación de libro: Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.difusion')),

    -- Congreso de Comercio
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo')),

    -- Taller de Ciberseguridad
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica')),

    -- Conferencia de Inteligencia Artificial
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica')),

    -- Conversatorio: Tecnología y Sociedad
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.matematicas')),

    -- Charla sobre Programación
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica')),

    -- Seminario de Big Data
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica')),

    -- Simposio de Innovación Tecnológica
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica')),

    -- Congreso de Informática Educativa
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica')),

    -- Foro de Tecnología
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica')),

    -- Presentación de libro: Informática Moderna
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.difusion')),

    -- Simposio de Software Libre
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));

-- participacion
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    -- Taller de Liderazgo Empresarial
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Juan' AND apellido_paterno='Pérez' AND apellido_materno='Gómez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Ana' AND apellido_paterno='López' AND apellido_materno='Martínez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Conferencia de Innovación Administrativa
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Carlos' AND apellido_paterno='Ramírez' AND apellido_materno='Sánchez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='María' AND apellido_paterno='Fernández' AND apellido_materno='Ruiz'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Conversatorio: Retos de la Administración
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Luis' AND apellido_paterno='García' AND apellido_materno='Torres'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Sofía' AND apellido_paterno='Martínez' AND apellido_materno='Vega'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Pedro' AND apellido_paterno='Gómez' AND apellido_materno='López'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador')),

    -- Charla sobre Gestión de Proyectos
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Miguel' AND apellido_paterno='Hernández' AND apellido_materno='Castro'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Seminario de Administración Pública
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Laura' AND apellido_paterno='Gómez' AND apellido_materno='Morales'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Jorge' AND apellido_paterno='Díaz' AND apellido_materno='Jiménez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Susana' AND apellido_paterno='Torres' AND apellido_materno='Ramírez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador')),

    -- Simposio de Recursos Humanos
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Patricia' AND apellido_paterno='Ruiz' AND apellido_materno='Navarro'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Congreso de Administración Estratégica
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Fernando' AND apellido_paterno='Torres' AND apellido_materno='Luna'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Gabriela' AND apellido_paterno='Sánchez' AND apellido_materno='Ortega'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Ricardo' AND apellido_paterno='Morales' AND apellido_materno='Vargas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Tomás' AND apellido_paterno='Sánchez' AND apellido_materno='Fernández'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador')),

    -- Foro de Emprendimiento
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Verónica' AND apellido_paterno='Castro' AND apellido_materno='Mendoza'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Presentación de libro: Administración Moderna
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Alejandro' AND apellido_paterno='Navarro' AND apellido_materno='Salinas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Taller de Planeación
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Claudia' AND apellido_paterno='Jiménez' AND apellido_materno='Ramos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Taller de Auditoría Financiera
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Roberto' AND apellido_paterno='Luna' AND apellido_materno='García'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Conferencia de Normas Contables
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Isabel' AND apellido_paterno='Ortega' AND apellido_materno='Fernández'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Conversatorio: Ética en la Contaduría
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Héctor' AND apellido_paterno='Vargas' AND apellido_materno='Santos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Carmen' AND apellido_paterno='Mendoza' AND apellido_materno='Pérez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Guillermo' AND apellido_paterno='Navarro' AND apellido_materno='Vargas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador')),

    -- Charla sobre Impuestos
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Javier' AND apellido_paterno='Salinas' AND apellido_materno='López'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Seminario de Contabilidad Internacional
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Mónica' AND apellido_paterno='Ramos' AND apellido_materno='Martínez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Pablo' AND apellido_paterno='García' AND apellido_materno='Ramírez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Marina' AND apellido_paterno='Ortega' AND apellido_materno='Salinas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador')),

    -- Simposio de Auditoría
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Teresa' AND apellido_paterno='Fernández' AND apellido_materno='Sánchez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Congreso de Contabilidad Gubernamental
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Sergio' AND apellido_paterno='Santos' AND apellido_materno='Torres'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Carla' AND apellido_paterno='Pérez' AND apellido_materno='Morales'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Foro de Fiscalización
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Julio' AND apellido_paterno='López' AND apellido_materno='Navarro'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Presentación de libro: Contaduría Actual
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Beatriz' AND apellido_paterno='Martínez' AND apellido_materno='Jiménez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Seminario de Costos
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Rafael' AND apellido_paterno='Ramírez' AND apellido_materno='Ruiz'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Taller de Comercio Exterior
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Lucía' AND apellido_paterno='Sánchez' AND apellido_materno='Castro'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Conferencia de Negocios Globales
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Esteban' AND apellido_paterno='Torres' AND apellido_materno='Gómez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Conversatorio: Oportunidades Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Andrea' AND apellido_paterno='Morales' AND apellido_materno='Díaz'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Manuel' AND apellido_paterno='Navarro' AND apellido_materno='Salazar'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Alberto' AND apellido_paterno='Luna' AND apellido_materno='Ramos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador')),

    -- Charla sobre Exportaciones
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Rebeca' AND apellido_paterno='Jiménez' AND apellido_materno='Luna'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Semana Académica de Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Oscar' AND apellido_paterno='García' AND apellido_materno='Ortega'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Nadia' AND apellido_paterno='Fernández' AND apellido_materno='Vargas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Simposio de Negocios Digitales
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Iván' AND apellido_paterno='Mendoza' AND apellido_materno='Santos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Congreso de Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Elena' AND apellido_paterno='Salinas' AND apellido_materno='Pérez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Raúl' AND apellido_paterno='Ramos' AND apellido_materno='López'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Foro de Inversión Extranjera
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Felipe' AND apellido_paterno='Martínez' AND apellido_materno='Gómez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Presentación de libro: Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Adriana' AND apellido_paterno='Ruiz' AND apellido_materno='Morales'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Congreso de Comercio
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Cristian' AND apellido_paterno='Hernández' AND apellido_materno='Pérez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Taller de Ciberseguridad
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Fernando' AND apellido_paterno='Torres' AND apellido_materno='Luna'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Conferencia de Inteligencia Artificial
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Gabriela' AND apellido_paterno='Sánchez' AND apellido_materno='Ortega'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Conversatorio: Tecnología y Sociedad
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Ricardo' AND apellido_paterno='Morales' AND apellido_materno='Vargas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Verónica' AND apellido_paterno='Castro' AND apellido_materno='Mendoza'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Silvia' AND apellido_paterno='Morales' AND apellido_materno='García'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador')),

    -- Charla sobre Programación
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Alejandro' AND apellido_paterno='Navarro' AND apellido_materno='Salinas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Seminario de Big Data
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Claudia' AND apellido_paterno='Jiménez' AND apellido_materno='Ramos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Roberto' AND apellido_paterno='Luna' AND apellido_materno='García'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Diego' AND apellido_paterno='Pérez' AND apellido_materno='Santos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador')),

    -- Simposio de Innovación Tecnológica
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Isabel' AND apellido_paterno='Ortega' AND apellido_materno='Fernández'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Congreso de Informática Educativa
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Héctor' AND apellido_paterno='Vargas' AND apellido_materno='Santos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Carmen' AND apellido_paterno='Mendoza' AND apellido_materno='Pérez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Foro de Tecnología
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Javier' AND apellido_paterno='Salinas' AND apellido_materno='López'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Presentación de libro: Informática Moderna
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Beatriz' AND apellido_paterno='Martínez' AND apellido_materno='Jiménez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente')),

    -- Simposio de Software Libre
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Rafael' AND apellido_paterno='Ramírez' AND apellido_materno='Ruiz'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));

-- integrantexgrado
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Juan Pérez Gómez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Juan' AND apellido_paterno='Pérez' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Juan' AND apellido_paterno='Pérez' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública')),
    -- Ana López Martínez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Ana' AND apellido_paterno='López' AND apellido_materno='Martínez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Ana' AND apellido_paterno='López' AND apellido_materno='Martínez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Informática')),
    -- Carlos Ramírez Sánchez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carlos' AND apellido_paterno='Ramírez' AND apellido_materno='Sánchez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carlos' AND apellido_paterno='Ramírez' AND apellido_materno='Sánchez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Especialista en Auditoría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carlos' AND apellido_paterno='Ramírez' AND apellido_materno='Sánchez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría')),
    -- María Fernández Ruiz
    ((SELECT id_integrante FROM public.integrante WHERE nombre='María' AND apellido_paterno='Fernández' AND apellido_materno='Ruiz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Historia')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='María' AND apellido_paterno='Fernández' AND apellido_materno='Ruiz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Filosofía')),
    -- Luis García Torres
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Luis' AND apellido_paterno='García' AND apellido_materno='Torres'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Derecho')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Luis' AND apellido_paterno='García' AND apellido_materno='Torres'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Ciencias Políticas')),
    -- Sofía Martínez Vega
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Sofía' AND apellido_paterno='Martínez' AND apellido_materno='Vega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Sofía' AND apellido_paterno='Martínez' AND apellido_materno='Vega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Economía Internacional')),
    -- Miguel Hernández Castro
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Miguel' AND apellido_paterno='Hernández' AND apellido_materno='Castro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Miguel' AND apellido_paterno='Hernández' AND apellido_materno='Castro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Ingeniero en Sistemas Computacionales')),
    -- Laura Gómez Morales
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Laura' AND apellido_paterno='Gómez' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Laura' AND apellido_paterno='Gómez' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Especialista en Gestión Administrativa')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Laura' AND apellido_paterno='Gómez' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública')),
    -- Jorge Díaz Jiménez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Jorge' AND apellido_paterno='Díaz' AND apellido_materno='Jiménez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Jorge' AND apellido_paterno='Díaz' AND apellido_materno='Jiménez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Contabilidad Internacional')),
    -- Patricia Ruiz Navarro
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Patricia' AND apellido_paterno='Ruiz' AND apellido_materno='Navarro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Patricia' AND apellido_paterno='Ruiz' AND apellido_materno='Navarro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Administración')),
    -- Fernando Torres Luna
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Fernando' AND apellido_paterno='Torres' AND apellido_materno='Luna'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Fernando' AND apellido_paterno='Torres' AND apellido_materno='Luna'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial')),
    -- Gabriela Sánchez Ortega
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Gabriela' AND apellido_paterno='Sánchez' AND apellido_materno='Ortega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Gabriela' AND apellido_paterno='Sánchez' AND apellido_materno='Ortega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Especialista en Auditoría')),
    -- Ricardo Morales Vargas
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Ricardo' AND apellido_paterno='Morales' AND apellido_materno='Vargas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Ricardo' AND apellido_paterno='Morales' AND apellido_materno='Vargas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Administración')),
    -- Verónica Castro Mendoza
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Verónica' AND apellido_paterno='Castro' AND apellido_materno='Mendoza'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Verónica' AND apellido_paterno='Castro' AND apellido_materno='Mendoza'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Negocios Internacionales')),
    -- Alejandro Navarro Salinas
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Alejandro' AND apellido_paterno='Navarro' AND apellido_materno='Salinas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Alejandro' AND apellido_paterno='Navarro' AND apellido_materno='Salinas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Ingeniero en Sistemas Computacionales')),
    -- Claudia Jiménez Ramos
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Claudia' AND apellido_paterno='Jiménez' AND apellido_materno='Ramos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Claudia' AND apellido_paterno='Jiménez' AND apellido_materno='Ramos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública')),
    -- Roberto Luna García
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Roberto' AND apellido_paterno='Luna' AND apellido_materno='García'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Roberto' AND apellido_paterno='Luna' AND apellido_materno='García'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría')),
    -- Isabel Ortega Fernández
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Isabel' AND apellido_paterno='Ortega' AND apellido_materno='Fernández'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Isabel' AND apellido_paterno='Ortega' AND apellido_materno='Fernández'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial')),
    -- Héctor Vargas Santos
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Héctor' AND apellido_paterno='Vargas' AND apellido_materno='Santos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Héctor' AND apellido_paterno='Vargas' AND apellido_materno='Santos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Administración')),
    -- Carmen Mendoza Pérez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carmen' AND apellido_paterno='Mendoza' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carmen' AND apellido_paterno='Mendoza' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Contabilidad Internacional')),
    -- Javier Salinas López
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Javier' AND apellido_paterno='Salinas' AND apellido_materno='López'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Javier' AND apellido_paterno='Salinas' AND apellido_materno='López'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Economía Internacional')),
    -- Mónica Ramos Martínez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Mónica' AND apellido_paterno='Ramos' AND apellido_materno='Martínez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Mónica' AND apellido_paterno='Ramos' AND apellido_materno='Martínez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública')),
    -- Pablo García Ramírez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Pablo' AND apellido_paterno='García' AND apellido_materno='Ramírez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Pablo' AND apellido_paterno='García' AND apellido_materno='Ramírez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría')),
    -- Teresa Fernández Sánchez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Teresa' AND apellido_paterno='Fernández' AND apellido_materno='Sánchez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Teresa' AND apellido_paterno='Fernández' AND apellido_materno='Sánchez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública')),
    -- Sergio Santos Torres
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Sergio' AND apellido_paterno='Santos' AND apellido_materno='Torres'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Sergio' AND apellido_paterno='Santos' AND apellido_materno='Torres'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Informática')),
    -- Carla Pérez Morales
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carla' AND apellido_paterno='Pérez' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carla' AND apellido_paterno='Pérez' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública')),
    -- Julio López Navarro
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Julio' AND apellido_paterno='López' AND apellido_materno='Navarro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Julio' AND apellido_paterno='López' AND apellido_materno='Navarro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría')),
    -- Beatriz Martínez Jiménez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Beatriz' AND apellido_paterno='Martínez' AND apellido_materno='Jiménez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Beatriz' AND apellido_paterno='Martínez' AND apellido_materno='Jiménez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial')),
    -- Rafael Ramírez Ruiz
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Rafael' AND apellido_paterno='Ramírez' AND apellido_materno='Ruiz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Rafael' AND apellido_paterno='Ramírez' AND apellido_materno='Ruiz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Economía Internacional')),
    -- Lucía Sánchez Castro
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Lucía' AND apellido_paterno='Sánchez' AND apellido_materno='Castro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Lucía' AND apellido_paterno='Sánchez' AND apellido_materno='Castro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública')),
    -- Esteban Torres Gómez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Esteban' AND apellido_paterno='Torres' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Esteban' AND apellido_paterno='Torres' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría')),
    -- Andrea Morales Díaz
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Andrea' AND apellido_paterno='Morales' AND apellido_materno='Díaz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Andrea' AND apellido_paterno='Morales' AND apellido_materno='Díaz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial')),
    -- Manuel Navarro Salazar
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Manuel' AND apellido_paterno='Navarro' AND apellido_materno='Salazar'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Manuel' AND apellido_paterno='Navarro' AND apellido_materno='Salazar'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Administración')),
    -- Rebeca Jiménez Luna
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Rebeca' AND apellido_paterno='Jiménez' AND apellido_materno='Luna'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Rebeca' AND apellido_paterno='Jiménez' AND apellido_materno='Luna'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Contabilidad Internacional')),
    -- Oscar García Ortega
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Oscar' AND apellido_paterno='García' AND apellido_materno='Ortega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Oscar' AND apellido_paterno='García' AND apellido_materno='Ortega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial')),
    -- Nadia Fernández Vargas
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Nadia' AND apellido_paterno='Fernández' AND apellido_materno='Vargas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Nadia' AND apellido_paterno='Fernández' AND apellido_materno='Vargas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Economía Internacional')),
    -- Iván Mendoza Santos
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Iván' AND apellido_paterno='Mendoza' AND apellido_materno='Santos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Iván' AND apellido_paterno='Mendoza' AND apellido_materno='Santos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Administración')),
    -- Elena Salinas Pérez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Elena' AND apellido_paterno='Salinas' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Elena' AND apellido_paterno='Salinas' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Contabilidad Internacional')),
    -- Raúl Ramos López
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Raúl' AND apellido_paterno='Ramos' AND apellido_materno='López'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Raúl' AND apellido_paterno='Ramos' AND apellido_materno='López'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial')),
    -- Felipe Martínez Gómez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Felipe' AND apellido_paterno='Martínez' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Felipe' AND apellido_paterno='Martínez' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Economía Internacional')),
    -- Adriana Ruiz Morales
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Adriana' AND apellido_paterno='Ruiz' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Adriana' AND apellido_paterno='Ruiz' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública')),
    -- Cristian Hernández Pérez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Cristian' AND apellido_paterno='Hernández' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Cristian' AND apellido_paterno='Hernández' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría')),
    -- Pedro Gómez López
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Pedro' AND apellido_paterno='Gómez' AND apellido_materno='López'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    -- Susana Torres Ramírez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Susana' AND apellido_paterno='Torres' AND apellido_materno='Ramírez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    -- Tomás Sánchez Fernández
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Tomás' AND apellido_paterno='Sánchez' AND apellido_materno='Fernández'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    -- Paola Castro Jiménez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Paola' AND apellido_paterno='Castro' AND apellido_materno='Jiménez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales')),
    -- Guillermo Navarro Vargas
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Guillermo' AND apellido_paterno='Navarro' AND apellido_materno='Vargas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    -- Marina Ortega Salinas
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Marina' AND apellido_paterno='Ortega' AND apellido_materno='Salinas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría')),
    -- Alberto Luna Ramos
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Alberto' AND apellido_paterno='Luna' AND apellido_materno='Ramos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática')),
    -- Silvia Morales García
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Silvia' AND apellido_paterno='Morales' AND apellido_materno='García'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales')),
    -- Diego Pérez Santos
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Diego' AND apellido_paterno='Pérez' AND apellido_materno='Santos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración')),
    -- Lorena Mendoza Ruiz
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Lorena' AND apellido_paterno='Mendoza' AND apellido_materno='Ruiz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));

-- reservacion
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,estatus)
VALUES
    -- Megaeventos
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-09-10 10:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-09-11 11:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-09-12 12:00:00','Pendiente'),

    -- Administración
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-01 09:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-10-02 09:30:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-20 10:00:00','Autorizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-02-20 10:00:00','Realizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-08-01 11:00:00','Autorizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-05 09:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-09-20 12:00:00','Autorizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-06 09:30:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-08-20 10:30:00','Realizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-08-15 09:00:00','Cancelada'),

    -- Contaduría
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-01 14:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-10-02 15:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-03 10:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-03-01 09:00:00','Realizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-08-01 11:30:00','Autorizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-05 13:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-09-20 12:30:00','Autorizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-06 10:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-09-01 10:15:00','Realizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-09-05 09:45:00','Cancelada'),

    -- Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-01 16:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-10-02 16:30:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-10 11:00:00','Autorizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-03-05 10:00:00','Realizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-09-30 09:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-05 11:15:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-09-20 13:00:00','Autorizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-06 11:30:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-09-10 09:30:00','Realizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-09-05 12:00:00','Cancelada'),

    -- Informática
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-01 12:30:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-10-02 12:45:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-03 13:15:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-03-10 09:15:00','Realizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-08-01 10:45:00','Autorizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-05 14:30:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-09-20 14:45:00','Autorizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-06 15:00:00','Pendiente'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-08-25 11:00:00','Realizada'),

    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-08-28 12:30:00','Cancelada');

-- reservacionxequipamiento
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    -- Megaeventos
    -- Simposio de Administración 2025 (Activos + Inactivo: Atril)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 3),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Atril'), 1),

    -- Congreso Internacional de Contaduría 2025 (Activos + Inactivo: Lámpara de pie)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Lámpara de pie'), 1),

    -- Semana Académica de Informática 2025 (Activos + Inactivo: Lámpara de mesa)
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza de auditorio'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Lámpara de mesa'), 1),

    -- Administración
    -- Taller de Liderazgo Empresarial (Activos + Inactivo: Cañón de luz)
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Paño azul'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Mesa adicional'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Personalizadores'), 3),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Cañón de luz'), 1),

    -- Conferencia de Innovación Administrativa (Activos + Inactivo: Cañón de humo)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Cañón de humo'), 1),

    -- Conversatorio: Retos de la Administración (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1),

    -- Charla sobre Gestión de Proyectos (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),

    -- Seminario de Administración Pública (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 2),

    -- Simposio de Recursos Humanos (Activos + Inactivo: Cañón de burbujas)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza entrada'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza de auditorio'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza baños'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Cañón de burbujas'), 1),

    -- Congreso de Administración Estratégica (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2),

    -- Foro de Emprendimiento (Activos + Inactivo: Cañón de confeti)
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Boletín algo más (reportero)'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Cañón de confeti'), 1),

    -- Presentación de libro: Administración Moderna (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Otros'), 1),

    -- Taller de Planeación (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1),

    -- Contaduría
    -- Taller de Auditoría Financiera (Activos + Inactivo: Pantalla verde)
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla verde'), 1),

    -- Conferencia de Normas Contables (Activos + Inactivo: Telón rojo)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Telón rojo'), 1),

    -- Conversatorio: Ética en la Contaduría (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),

    -- Charla sobre Impuestos (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),

    -- Seminario de Contabilidad Internacional (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1),

    -- Simposio de Auditoría (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza entrada'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza baños'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza vestidores'), 1),

    -- Congreso de Contabilidad Gubernamental (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Boletín algo más (reportero)'), 1),

    -- Foro de Fiscalización (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),

    -- Presentación de libro: Contaduría Actual (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Otros'), 1),

    -- Seminario de Costos (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1),

    -- Negocios Internacionales
    -- Taller de Comercio Exterior (Activos + Inactivo: Cañón de burbujas ya usado; usar Cañón de humo ya usado; ahora usar Lámpara de mesa ya usada; usar Pantalla verde ya usada; aquí usar Cañón de luz? ya usado. Usar ninguno inactivo en este)
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Paño azul'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Mesa adicional'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Personalizadores'), 1),

    -- Conferencia de Negocios Globales (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1),

    -- Conversatorio: Oportunidades Internacionales (Activos + Inactivo: Pantalla verde ya usado; usar Telón rojo ya usado; aquí usar Lámpara de pie ya usada; usar Atril ya usado; usar Cañón de confeti? ya usado. Usamos ninguno inactivo.)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1),

    -- Charla sobre Exportaciones (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),

    -- Semana Académica de NI (Activos + Inactivo: Cañón de humo ya usado; aquí usar Cañón de luz? ya usado; usemos Lámpara de mesa? ya; usemos Atril? ya; aquí Pantalla verde? ya. Tomamos 'Telón rojo' extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Telón rojo'), 1),

    -- Simposio de Negocios Digitales (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza entrada'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza de auditorio'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza vestidores'), 1),

    -- Congreso de Negocios Internacionales (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),

    -- Foro de Inversión Extranjera (Activos + Inactivo: Cañón de confeti ya usado; aquí 'Atril' extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Boletín algo más (reportero)'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Atril'), 1),

    -- Presentación de libro: Negocios Internacionales (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Otros'), 1),

    -- Congreso de Comercio (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1),

    -- Informática
    -- Taller de Ciberseguridad (Activos + Inactivo: Cañón de humo ya usado; aquí usar Cañón de luz ya usado; usemos Lámpara de mesa ya usada; usemos Pantalla verde ya usada; aquí ninguno)
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Paño azul'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Mesa adicional'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Personalizadores'), 1),

    -- Conferencia de Inteligencia Artificial (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1),

    -- Conversatorio: Tecnología y Sociedad (Activos + Inactivo: Cañón de confeti ya; aquí usar Cañón de humo? ya; usemos Telón rojo ya; aquí 'Pantalla verde' extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla verde'), 1),

    -- Charla sobre Programación (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),

    -- Seminario de Big Data (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1),

    -- Simposio de Innovación Tecnológica (Activos + Inactivo: Lámpara de mesa extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza entrada'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza de auditorio'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza vestidores'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Lámpara de mesa'), 1),

    -- Congreso de Informática Educativa (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1),

    -- Foro de Tecnología (Activos + Inactivo: Cañón de luz extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Boletín algo más (reportero)'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Cañón de luz'), 1),

    -- Presentación de libro: Informática Moderna (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Otros'), 1),

    -- Simposio de Software Libre (Activos + Inactivo: Telón rojo extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1),
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Telón rojo'), 1);

-- area_inventario
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    -- actos
    ((SELECT id_area FROM public.area WHERE nombre = 'Actos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Paño azul'), 5),
    ((SELECT id_area FROM public.area WHERE nombre = 'Actos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Mesa adicional'), 3),
    ((SELECT id_area FROM public.area WHERE nombre = 'Actos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Personalizadores'), 10),

    -- centro de informática
    ((SELECT id_area FROM public.area WHERE nombre = 'Centro de Informática'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Laptop'), 10),
    ((SELECT id_area FROM public.area WHERE nombre = 'Centro de Informática'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Zoom'), 5),

    -- medios audiovisuales
    ((SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 2),
    ((SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 2),
    ((SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 2),

    -- publicaciones y fomento editorial
    ((SELECT id_area FROM public.area WHERE nombre = 'Publicaciones y Fomento Editorial'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Fotógrafo'), 2),
    ((SELECT id_area FROM public.area WHERE nombre = 'Publicaciones y Fomento Editorial'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Boletín algo más (reportero)'), 2),

    -- secretaria administrativa
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Vigilancia'), 5),
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Presidium'), 2),
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Otros'), 10),
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Limpieza entrada'), 5),
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Limpieza de auditorio'), 5),
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Limpieza baños'), 5),
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Limpieza vestidores'), 5),
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Abrir auditorio'), 5);

-- recinto_inventario
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    -- Auditorio Mtro. Carlos Pérez del Toro
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Fotógrafo'), 1),

    -- Aula Magna de Profesores Eméritos
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1),

    -- Auditorio C.P. Tomás López Sánchez
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1),

    -- Centro de Informática (CIFCA)
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Laptop'), 5),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Zoom'), 2),

    -- Auditorio C.P. Alfonso Ochoa Ravizé
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1),

    -- Centro de Idiomas (CEDI)
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1),

    -- Aula Magna de Investigación
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1),

    -- Auditorio C.P. Arturo Elizundia Charles
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1),
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1);


-- fotografia
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_mtro_carlos_perez_del_toro_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro')),
    ('/recintos/auditorio_mtro_carlos_perez_del_toro_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro')),
    ('/recintos/auditorio_mtro_carlos_perez_del_toro_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro')),
    ('/recintos/auditorio_mtro_carlos_perez_del_toro_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro')),

    ('/recintos/aula_magna_de_profesores_emeritos_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos')),
    ('/recintos/aula_magna_de_profesores_emeritos_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos')),
    ('/recintos/aula_magna_de_profesores_emeritos_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos')),
    ('/recintos/aula_magna_de_profesores_emeritos_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos')),

    ('/recintos/auditorio_cp_tomas_lopez_sanchez_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez')),
    ('/recintos/auditorio_cp_tomas_lopez_sanchez_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez')),
    ('/recintos/auditorio_cp_tomas_lopez_sanchez_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez')),
    ('/recintos/auditorio_cp_tomas_lopez_sanchez_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez')),

    ('/recintos/centro_de_informatica_cifca_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)')),
    ('/recintos/centro_de_informatica_cifca_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)')),
    ('/recintos/centro_de_informatica_cifca_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)')),
    ('/recintos/centro_de_informatica_cifca_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)')),

    ('/recintos/auditorio_cp_alfonso_ochoa_ravize_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé')),
    ('/recintos/auditorio_cp_alfonso_ochoa_ravize_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé')),
    ('/recintos/auditorio_cp_alfonso_ochoa_ravize_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé')),
    ('/recintos/auditorio_cp_alfonso_ochoa_ravize_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé')),

    ('/recintos/centro_de_idiomas_cedi_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)')),
    ('/recintos/centro_de_idiomas_cedi_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)')),
    ('/recintos/centro_de_idiomas_cedi_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)')),
    ('/recintos/centro_de_idiomas_cedi_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)')),

    ('/recintos/aula_magna_de_investigacion_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación')),
    ('/recintos/aula_magna_de_investigacion_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación')),
    ('/recintos/aula_magna_de_investigacion_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación')),
    ('/recintos/aula_magna_de_investigacion_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación')),

    ('/recintos/auditorio_cp_arturo_elizundia_charles_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles')),
    ('/recintos/auditorio_cp_arturo_elizundia_charles_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles')),
    ('/recintos/auditorio_cp_arturo_elizundia_charles_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles')),
    ('/recintos/auditorio_cp_arturo_elizundia_charles_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'));

-- Auditoria
INSERT INTO public.auditoria (nombre_tabla,id_registro_afectado,accion,campo_modificado,valor_anterior,valor_nuevo,id_usuario,fecha_hora)
VALUES
    ('fotografia',
        (SELECT id_fotografia
         FROM public.fotografia
         WHERE id_recinto = (SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)')
           AND fotografia = '/recintos/centro_de_idiomas_cedi_1.png'
         LIMIT 1),
        'UPDATE','fotografia','/recintos/centro_de_idiomas_cedi_foto_antigua.png','/recintos/centro_de_idiomas_cedi_1.png',
        (SELECT id_usuario FROM public.usuario WHERE nombre_usuario = 'jefa.educacioncontinua' LIMIT 1),
        CURRENT_TIMESTAMP),

    ('evento',
        (SELECT id_evento
         FROM public.evento
         WHERE nombre = 'Simposio de Administración 2025'
         LIMIT 1),
        'UPDATE','nombre','zimposio admin 2025','Simposio de Administración 2025',
        (SELECT id_usuario FROM public.usuario WHERE nombre_usuario = 'jefe.licadministracion' LIMIT 1),
        CURRENT_TIMESTAMP),

    ('evento',
        (SELECT id_evento
         FROM public.evento
         WHERE nombre = 'Taller de Planeación'
         LIMIT 1),
        'UPDATE','fecha_inicio','2025-09-01','2025-09-15',
        (SELECT id_usuario FROM public.usuario WHERE nombre_usuario = 'jefe.licadministracion' LIMIT 1),
        CURRENT_TIMESTAMP),

    ('evento_organizador',
        (SELECT numero_registro
         FROM public.evento_organizador
         WHERE id_evento = (SELECT id_evento FROM public.evento WHERE nombre = 'Simposio de Administración 2025' LIMIT 1)
           AND id_usuario = (SELECT id_usuario FROM public.usuario WHERE nombre_usuario = 'coordinador.administracion.avanzada' LIMIT 1)
         LIMIT 1),
        'UPDATE','confirmacion','false','true',
        (SELECT id_usuario FROM public.usuario WHERE nombre_usuario = 'coordinadora.administracion.basica' LIMIT 1),
        CURRENT_TIMESTAMP),

    ('participacion',
        (SELECT numero_registro
         FROM public.participacion
         WHERE id_evento = (SELECT id_evento FROM public.evento WHERE nombre = 'Taller de Liderazgo Empresarial' LIMIT 1)
           AND id_integrante = (SELECT id_integrante FROM public.integrante
                                WHERE nombre = 'Juan' AND apellido_paterno = 'Pérez' AND apellido_materno = 'Gómez'
                                LIMIT 1)
         LIMIT 1),
        'UPDATE','id_rol_participacion',
        '40',
        (SELECT CAST(id_rol_participacion AS TEXT)
         FROM public.rol_participacion
         WHERE nombre = 'Ponente'
         LIMIT 1),
        (SELECT id_usuario FROM public.usuario WHERE nombre_usuario = 'coordinador.contabilidad.avanzada' LIMIT 1),
        CURRENT_TIMESTAMP),

    ('area_inventario',
        (SELECT numero_registro
         FROM public.area_inventario
         WHERE id_area = (SELECT id_area FROM public.area WHERE nombre = 'Actos' LIMIT 1)
           AND id_equipamiento = (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Paño azul' LIMIT 1)
         LIMIT 1),
        'UPDATE','cantidad','3','5',
        (SELECT id_usuario FROM public.usuario WHERE nombre_usuario = 'secretario.difusioncultural' LIMIT 1),
        CURRENT_TIMESTAMP),

    ('recinto_inventario',
        (SELECT numero_registro
         FROM public.recinto_inventario
         WHERE id_recinto = (SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez' LIMIT 1)
           AND id_equipamiento = (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido' LIMIT 1)
         LIMIT 1),
        'UPDATE','cantidad','0','1',
        (SELECT id_usuario FROM public.usuario WHERE nombre_usuario = 'secretario.difusioncultural' LIMIT 1),
        CURRENT_TIMESTAMP),

    ('recinto',
        (SELECT id_recinto
         FROM public.recinto
         WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'
         LIMIT 1),
        'UPDATE','nombre','Pepe el Toro','Auditorio Mtro. Carlos Pérez del Toro',
        (SELECT id_usuario FROM public.usuario WHERE nombre_usuario = 'secretario.difusioncultural' LIMIT 1),
        CURRENT_TIMESTAMP),

    ('usuario',
        (SELECT id_usuario
         FROM public.usuario
         WHERE nombre_usuario = 'coordinadora.administrativa'
         LIMIT 1),
        'UPDATE','nombre_usuario','administrador supremo','coordinadora.administrativa',
        (SELECT id_usuario FROM public.usuario WHERE nombre_usuario = 'secretario.difusioncultural' LIMIT 1),
        CURRENT_TIMESTAMP);


COMMIT;