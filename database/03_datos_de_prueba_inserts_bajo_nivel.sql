SET client_encoding to 'UTF8';
BEGIN;

-- TABLAS PADRE
-- permiso
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    --      usuarios
    ('usuario','crear','global','Crear usuario');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('usuario','leer','global','Listar usuarios');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('usuario','editar','global','Editar usuarios');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('usuario','eliminar','global','Eliminar usuarios');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES

    ('usuario','leer','propietario','Leer datos de usuario propio');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('usuario','editar','propietario','Editar datos de usuario propio');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES

    --      recintos
    ('recinto','crear','global','Crear recinto');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('recinto','leer','global','Listar recintos');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('recinto','editar','global','Editar recintos');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('recinto','eliminar','global','Eliminar recintos');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES

    --      reservaciones
    ('reservacion','crear','global','Crear reservacion');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('reservacion','leer','global','Listar reservaciones');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('reservacion','editar','global','Editar reservaciones');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES

    ('reservacion','leer','propietario','Listar reservaciones propias');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('reservacion','editar','propietario','Editar reservaciones propias');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES

    --      eventos
    ('evento','crear','global','Crear eventos');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('evento','leer','global','Listar eventos');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('evento','editar','global','Editar eventos');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES

    ('evento','leer','propietario','Listar eventos propios');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('evento','editar','propietario','Editar eventos propios');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES

    --      integrantes
    ('integrante','crear','global','Registra integrantes que participarian en algun evento');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('integrante','leer','global','Listar integrantes que participaron en algun evento');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('integrante','editar','global','Editar datos de los integrantes que participaron en algun evento');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES

    --      inventarios
    ('area_inventario','crear','global','Registrar el inventario del area');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('area_inventario','leer','global','Listar el inventario del area');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('area_inventario','editar','global','Editar el inventario del area');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('area_inventario','eliminar','global','Eliminar el inventario del area');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('recinto_inventario','crear','global','Registrar el inventario del recinto');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('recinto_inventario','leer','global','Listar el inventario del recinto');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('recinto_inventario','editar','global','Editar el inventario del recinto');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('recinto_inventario','eliminar','global','Eliminar el inventario del recinto');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES

    --      catalogos
    ('catalogo','crear','global','Agrega un nuevo item a algun catalogo (ej. puesto, area, equipamiento... )');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('catalogo','leer','global','Lista los items de algun catalogo (ej. puesto, area, equipamiento... )');
INSERT INTO public.permiso (recurso,accion,alcance,descripcion)
VALUES
    ('catalogo','eliminar','global','Elimina un item de algun catalogo (ej. puesto, area, equipamiento... )');


-- rol_usuario
INSERT INTO public.rol_usuario (nombre)
VALUES 
    ('Superadministrador');
INSERT INTO public.rol_usuario (nombre)
VALUES
    ('Administrador');
INSERT INTO public.rol_usuario (nombre)
VALUES
    ('Funcionario');

-- area
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('APAFCA', 'Laura Hernández', 'laura.hernandez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Actos', 'José Martínez', 'jose.martinez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Administración Escolar', 'Patricia Gómez', 'patricia.gomez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Biblioteca', 'Rosa Díaz', 'rosa.diaz@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Cenapyme', 'Carlos López', 'carlos.lopez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Centro de Educación a Distancia', 'Verónica Sánchez', 'veronica.sanchez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Centro de Educación a Distancia y Gestión del Conocimiento', 'Fernando Ortega', 'fernando.ortega@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Centro de Educación a Distancia y Gestión del Conocimiento (CEDIGEC)', 'María Pérez', 'maria.perez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Centro de Informática', 'Miguel Torres', 'miguel.torres@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Centro de Idiomas (CEDI)', 'Leticia Rivera', 'leticia.rivera@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Control Interno', 'Andrés Castillo', 'andres.castillo@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Administración Avanzada', 'Héctor Navarro', 'hector.navarro@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Administración Básica', 'Daniela Ruiz', 'daniela.ruiz@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Asuntos Internacionales', 'Sofía Rojas', 'sofia.rojas@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Auditoria', 'Ricardo Mendoza', 'ricardo.mendoza@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Contabilidad', 'Gabriela Domínguez', 'gabriela.dominguez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Contabilidad Básica', 'Hugo Hernández', 'hugo.hernandez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Costos y Presupuestos', 'Carmen Jiménez', 'carmen.jimenez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Derecho', 'Luis Morales', 'luis.morales@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Economía', 'Isabel Castro', 'isabel.castro@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Finanzas', 'Pablo Vega', 'pablo.vega@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Fiscal', 'Teresa Salazar', 'teresa.salazar@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Informática', 'Sergio Álvarez', 'sergio.alvarez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Matemáticas', 'Carla Romero', 'carla.romero@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Mercadotecnia', 'Javier Pineda', 'javier.pineda@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Metodología de la Investigación y Ética', 'Ana Beltrán', 'ana.beltran@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Operaciones', 'Julio Flores', 'julio.flores@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación de Recursos Humanos', 'Mónica Aguilar', 'monica.aguilar@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Coordinación del Programa de Posgrado en Ciencias de la Administración', 'Rodrigo Luna', 'rodrigo.luna@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Departamento de Servicios Generales y Mantenimiento', 'Oscar Pérez', 'oscar.perez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Departamento del SUAyED (Modalidad a Distancia)', 'Claudia Campos', 'claudia.campos@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Dirección', 'Marcos Gutiérrez', 'marcos.gutierrez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('División de Educación Continua', 'Paola Estrada', 'paola.estrada@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('División de Estudios de Posgrado', 'Ricardo Torres', 'ricardo.torres@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('División de Investigación', 'Adriana Morales', 'adriana.morales@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Emprendedores', 'Felipe Ramírez', 'felipe.ramirez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Exámenes Profesionales', 'Nadia Cruz', 'nadia.cruz@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Jefatura de la Licenciatura en Administración', 'Daniel Castro', 'daniel.castro@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Jefatura de la Licenciatura en Contaduría', 'María López', 'maria.lopez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Jefatura de la Licenciatura en Informática', 'Héctor Vega', 'hector.vega@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Jefatura de la Licenciatura en Negocios Internacionales', 'Patricia Ramos', 'patricia.ramos@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Licenciatura en Informática', 'Iván Rojas', 'ivan.rojas@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Mediateca', 'Elena Navarro', 'elena.navarro@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Medios Audiovisuales', 'Santiago Hernández', 'santiago.hernandez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Ninguna', 'Sin Responsable', 'ninguna@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Oficina Jurídica', 'Carolina Pérez', 'carolina.perez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Oficina de Servicios Escolares', 'Roberto Díaz', 'roberto.diaz@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Programa de Posgrado en Ciencias de la Administración', 'Liliana Campos', 'liliana.campos@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Publicaciones y Fomento Editorial', 'Teresa González', 'teresa.gonzalez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('SUAyED', 'Esteban Ortiz', 'esteban.ortiz@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría Académica', 'Alejandra Flores', 'alejandra.flores@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría Administrativa', 'Eduardo Salinas', 'eduardo.salinas@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría Divulgación y Fomento Editorial', 'Rebeca García', 'rebeca.garcia@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría General', 'Manuel Torres', 'manuel.torres@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría de Cooperación Internacional', 'Valeria Soto', 'valeria.soto@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría de Cooperación Internacional / Asociación Latinoamericana de Facultades y Escuelas de Contaduría y Administración', 'César Cabrera', 'cesar.cabrera@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría de Cooperación Internacional. Alafec', 'Andrea Molina', 'andrea.molina@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría de Difusión Cultural', 'Raúl Jiménez', 'raul.jimenez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría de Intercambio Académico y ANFECA', 'Lucía Navarro', 'lucia.navarro@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría de Personal Docente', 'Fernando Rivera', 'fernando.rivera@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría de Planeación Académica', 'Beatriz Morales', 'beatriz.morales@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría de Planeación y Evaluación Académica', 'Jorge López', 'jorge.lopez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría de Relaciones y Extensión Universitaria', 'Cinthia Vega', 'cinthia.vega@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Secretaría de Vinculación', 'Rafael Castro', 'rafael.castro@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Sindicato', 'Mario Delgado', 'mario.delgado@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Sistema de Universidad Abierta', 'Elisa Romero', 'elisa.romero@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Sistema de Universidad Abierta y Educación a Distancia', 'José Ramírez', 'jose.ramirez@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Subjefatura de la División de Estudios de Posgrado', 'Mariana Torres', 'mariana.torres@fca.unam.mx');
INSERT INTO public.area (nombre, nombre_responsable, correo_responsable)
    VALUES
    ('Unidad Integral de Género', 'Claudia Fernández', 'claudia.fernandez@fca.unam.mx');

-- rol_participacion
INSERT INTO public.rol_participacion (nombre)
VALUES 
    ('Ponente');
INSERT INTO public.rol_participacion (nombre)
VALUES
    ('Moderador');
INSERT INTO public.rol_participacion (nombre)
VALUES
    ('Presidium');


-- nivel
INSERT INTO public.nivel (nombre, siglas)
VALUES
    ('Técnico Superior Universitario', 'TSU');
INSERT INTO public.nivel (nombre, siglas)
VALUES
    ('Licenciatura', 'Lic');
INSERT INTO public.nivel (nombre, siglas)
VALUES
    ('Ingeniería', 'Ing');
INSERT INTO public.nivel (nombre, siglas)
VALUES
    ('Especialidad', 'Esp');
INSERT INTO public.nivel (nombre, siglas)
VALUES
    ('Maestría', 'Mtr');
INSERT INTO public.nivel (nombre, siglas)
VALUES
    ('Doctorado', 'Dr');
INSERT INTO public.nivel (nombre, siglas)
VALUES
    ('Posdoctorado', 'PDr');


-- institucion
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Nacional Autónoma de México', 'UNAM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Instituto Politécnico Nacional', 'IPN');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad del Valle de México', 'UVM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Guadalajara', 'UAG');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Instituto Tecnológico y de Estudios Superiores de Monterrey', 'ITESM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Anáhuac', 'ANÁHUAC');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Iberoamericana', 'IBERO');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Benemérita Universidad Autónoma de Puebla', 'BUAP');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma Metropolitana', 'UAM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma del Estado de México', 'UAEMex');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad de las Américas Puebla', 'UDLAP');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Nuevo León', 'UANL');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad de Guadalajara', 'UDG');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Baja California', 'UABC');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Veracruzana', 'UV');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Querétaro', 'UAQ');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de San Luis Potosí', 'UASLP');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Chihuahua', 'UACH');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Coahuila', 'UAdeC');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Sinaloa', 'UAS');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Nayarit', 'UAN');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Yucatán', 'UADY');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad de Sonora', 'UNISON');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma del Estado de Hidalgo', 'UAEH');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Zacatecas', 'UAZ');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Tamaulipas', 'UAT');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Baja California Sur', 'UABCS');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Campeche', 'UACAM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Ciudad Juárez', 'UACJ');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Aguascalientes', 'UAA');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Guerrero', 'UAGro');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Tlaxcala', 'UATx');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma del Carmen', 'UNACAR');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad de Colima', 'UCOL');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Chiapas', 'UNACH');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Juárez del Estado de Durango', 'UJED');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Michoacana de San Nicolás de Hidalgo', 'UMSNH');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Morelos', 'UAEM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de México', 'UNITEC');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad La Salle', 'ULSA');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Panamericana', 'UP');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad del Valle de Atemajac', 'UNIVA');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Centro de Investigación y de Estudios Avanzados del IPN', 'CINVESTAV');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('El Colegio de México', 'COLMEX');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Centro de Enseñanza Técnica y Superior', 'CETYS');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma Chapingo', 'UACh');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma Agraria Antonio Narro', 'UAAAN');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Pedagógica Nacional', 'UPN');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de León', 'UTL');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Puebla', 'UTP');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Instituto Tecnológico Autónomo de México', 'ITAM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Instituto Tecnológico de Estudios Superiores de Occidente', 'ITESO');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma del Estado de Quintana Roo', 'UQROO');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad de Monterrey', 'UDEM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad del Mar', 'UMAR');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad del Istmo', 'UNISTMO');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad de Guanajuato', 'UGTO');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Autónoma de Oaxaca Benito Juárez', 'UABJO');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Politécnica de Querétaro', 'UPQ');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Politécnica de Pachuca', 'UPP');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Politécnica de San Luis Potosí', 'UPSLP');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Politécnica de Tlaxcala', 'UPTx');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Cancún', 'UTCANCUN');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Querétaro', 'UTEQ');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica Metropolitana', 'UTM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Politécnica Metropolitana de Hidalgo', 'UPMH');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Intercultural del Estado de México', 'UIEM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Politécnica de Chiapas', 'UPCH');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica del Valle de Toluca', 'UTVT');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica del Sur del Estado de México', 'UTSEM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica del Estado de Zacatecas', 'UTZAC');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Tula-Tepeji', 'UTTT');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Nezahualcóyotl', 'UTN');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de la Huasteca Hidalguense', 'UTHH');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Tabasco', 'UTTAB');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de San Juan del Río', 'UTSJR');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de la Selva', 'UTSELVA');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Politécnica de Puebla', 'UPPUE');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Morelia', 'UTMOR');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Politécnica del Valle de México', 'UPVM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Aguascalientes', 'UTAGS');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Politécnica de Santa Rosa Jáuregui', 'UPSRJ');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Tehuacán', 'UTTEHU');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Politécnica del Estado de Morelos', 'UPEMOR');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica del Valle de Mezquital', 'UTVM');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Hermosillo', 'UTH');
INSERT INTO public.institucion (nombre, siglas)
VALUES
    ('Universidad Tecnológica de Xicotepec de Juárez', 'UTXJ');


-- categoria
INSERT INTO public.categoria (nombre)
VALUES
    ('Taller');
INSERT INTO public.categoria (nombre)
VALUES
    ('Conferencia');
INSERT INTO public.categoria (nombre)
VALUES
    ('Conversatorio');
INSERT INTO public.categoria (nombre)
VALUES
    ('Charla');
INSERT INTO public.categoria (nombre)
VALUES
    ('Semana académica');
INSERT INTO public.categoria (nombre)
VALUES
    ('Seminario');
INSERT INTO public.categoria (nombre)
VALUES
    ('Simposio');
INSERT INTO public.categoria (nombre)
VALUES
    ('Congreso');
INSERT INTO public.categoria (nombre)
VALUES
    ('Foro');
INSERT INTO public.categoria (nombre)
VALUES
    ('Presentación de libro');


-- integrante
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    -- Integrantes con semblanza (50)
    ('Juan', 'Pérez', 'Gómez', '/semblanzas/juan_perez_gomez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Ana', 'López', 'Martínez', '/semblanzas/ana_lopez_martinez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Carlos', 'Ramírez', 'Sánchez', '/semblanzas/carlos_ramirez_sanchez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('María', 'Fernández', 'Ruiz', '/semblanzas/maria_fernandez_ruiz.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Luis', 'García', 'Torres', '/semblanzas/luis_garcia_torres.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Sofía', 'Martínez', 'Vega', '/semblanzas/sofia_martinez_vega.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Miguel', 'Hernández', 'Castro', '/semblanzas/miguel_hernandez_castro.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Laura', 'Gómez', 'Morales', '/semblanzas/laura_gomez_morales.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Jorge', 'Díaz', 'Jiménez', '/semblanzas/jorge_diaz_jimenez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Patricia', 'Ruiz', 'Navarro', '/semblanzas/patricia_ruiz_navarro.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Fernando', 'Torres', 'Luna', '/semblanzas/fernando_torres_luna.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Gabriela', 'Sánchez', 'Ortega', '/semblanzas/gabriela_sanchez_ortega.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Ricardo', 'Morales', 'Vargas', '/semblanzas/ricardo_morales_vargas.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Verónica', 'Castro', 'Mendoza', '/semblanzas/veronica_castro_mendoza.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Alejandro', 'Navarro', 'Salinas', '/semblanzas/alejandro_navarro_salinas.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Claudia', 'Jiménez', 'Ramos', '/semblanzas/claudia_jimenez_ramos.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Roberto', 'Luna', 'García', '/semblanzas/roberto_luna_garcia.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Isabel', 'Ortega', 'Fernández', '/semblanzas/isabel_ortega_fernandez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Héctor', 'Vargas', 'Santos', '/semblanzas/hector_vargas_santos.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Carmen', 'Mendoza', 'Pérez', '/semblanzas/carmen_mendoza_perez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Javier', 'Salinas', 'López', '/semblanzas/javier_salinas_lopez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Mónica', 'Ramos', 'Martínez', '/semblanzas/monica_ramos_martinez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Pablo', 'García', 'Ramírez', '/semblanzas/pablo_garcia_ramirez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Teresa', 'Fernández', 'Sánchez', '/semblanzas/teresa_fernandez_sanchez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Sergio', 'Santos', 'Torres', '/semblanzas/sergio_santos_torres.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Carla', 'Pérez', 'Morales', '/semblanzas/carla_perez_morales.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Julio', 'López', 'Navarro', '/semblanzas/julio_lopez_navarro.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Beatriz', 'Martínez', 'Jiménez', '/semblanzas/beatriz_martinez_jimenez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Rafael', 'Ramírez', 'Ruiz', '/semblanzas/rafael_ramirez_ruiz.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Lucía', 'Sánchez', 'Castro', '/semblanzas/lucia_sanchez_castro.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Esteban', 'Torres', 'Gómez', '/semblanzas/esteban_torres_gomez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Andrea', 'Morales', 'Díaz', '/semblanzas/andrea_morales_diaz.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Manuel', 'Navarro', 'Salazar', '/semblanzas/manuel_navarro_salazar.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Rebeca', 'Jiménez', 'Luna', '/semblanzas/rebeca_jimenez_luna.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Oscar', 'García', 'Ortega', '/semblanzas/oscar_garcia_ortega.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Nadia', 'Fernández', 'Vargas', '/semblanzas/nadia_fernandez_vargas.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Iván', 'Mendoza', 'Santos', '/semblanzas/ivan_mendoza_santos.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Elena', 'Salinas', 'Pérez', '/semblanzas/elena_salinas_perez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Raúl', 'Ramos', 'López', '/semblanzas/raul_ramos_lopez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Felipe', 'Martínez', 'Gómez', '/semblanzas/felipe_martinez_gomez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Adriana', 'Ruiz', 'Morales', '/semblanzas/adriana_ruiz_morales.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Cristian', 'Hernández', 'Pérez', '/semblanzas/cristian_hernandez_perez.pdf');
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES

    -- Integrantes sin semblanza (10)
    ('Pedro', 'Gómez', 'López', NULL);
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Susana', 'Torres', 'Ramírez', NULL);
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Tomás', 'Sánchez', 'Fernández', NULL);
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Paola', 'Castro', 'Jiménez', NULL);
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Guillermo', 'Navarro', 'Vargas', NULL);
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Marina', 'Ortega', 'Salinas', NULL);
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Alberto', 'Luna', 'Ramos', NULL);
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Silvia', 'Morales', 'García', NULL);
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Diego', 'Pérez', 'Santos', NULL);
INSERT INTO public.integrante (nombre, apellido_paterno, apellido_materno, semblanza)
VALUES
    ('Lorena', 'Mendoza', 'Ruiz', NULL);


-- pais
INSERT INTO public.pais (nombre) 
VALUES
    ('Afganistán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Albania');
INSERT INTO public.pais (nombre) 
VALUES
    ('Alemania');
INSERT INTO public.pais (nombre) 
VALUES
    ('Andorra');
INSERT INTO public.pais (nombre) 
VALUES
    ('Angola');
INSERT INTO public.pais (nombre) 
VALUES
    ('Antigua y Barbuda');
INSERT INTO public.pais (nombre) 
VALUES
    ('Arabia Saudita');
INSERT INTO public.pais (nombre) 
VALUES
    ('Argelia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Argentina');
INSERT INTO public.pais (nombre) 
VALUES
    ('Armenia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Australia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Austria');
INSERT INTO public.pais (nombre) 
VALUES
    ('Azerbaiyán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Bahamas');
INSERT INTO public.pais (nombre) 
VALUES
    ('Bangladés');
INSERT INTO public.pais (nombre) 
VALUES
    ('Barbados');
INSERT INTO public.pais (nombre) 
VALUES
    ('Baréin');
INSERT INTO public.pais (nombre) 
VALUES
    ('Bélgica');
INSERT INTO public.pais (nombre) 
VALUES
    ('Belice');
INSERT INTO public.pais (nombre) 
VALUES
    ('Benín');
INSERT INTO public.pais (nombre) 
VALUES
    ('Bielorrusia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Birmania');
INSERT INTO public.pais (nombre) 
VALUES
    ('Bolivia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Bosnia y Herzegovina');
INSERT INTO public.pais (nombre) 
VALUES
    ('Botsuana');
INSERT INTO public.pais (nombre) 
VALUES
    ('Brasil');
INSERT INTO public.pais (nombre) 
VALUES
    ('Brunéi Darussalam');
INSERT INTO public.pais (nombre) 
VALUES
    ('Bulgaria');
INSERT INTO public.pais (nombre) 
VALUES
    ('Burkina Faso');
INSERT INTO public.pais (nombre) 
VALUES
    ('Burundi');
INSERT INTO public.pais (nombre) 
VALUES
    ('Bután');
INSERT INTO public.pais (nombre) 
VALUES
    ('Cabo Verde');
INSERT INTO public.pais (nombre) 
VALUES
    ('Camboya');
INSERT INTO public.pais (nombre) 
VALUES
    ('Camerún');
INSERT INTO public.pais (nombre) 
VALUES
    ('Canadá');
INSERT INTO public.pais (nombre) 
VALUES
    ('Catar');
INSERT INTO public.pais (nombre) 
VALUES
    ('Chad');
INSERT INTO public.pais (nombre) 
VALUES
    ('Chile');
INSERT INTO public.pais (nombre) 
VALUES
    ('China');
INSERT INTO public.pais (nombre) 
VALUES
    ('Chipre');
INSERT INTO public.pais (nombre) 
VALUES
    ('Colombia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Comoras');
INSERT INTO public.pais (nombre) 
VALUES
    ('Corea del Norte');
INSERT INTO public.pais (nombre) 
VALUES
    ('Corea del Sur');
INSERT INTO public.pais (nombre) 
VALUES
    ('Costa de Marfil');
INSERT INTO public.pais (nombre) 
VALUES
    ('Costa Rica');
INSERT INTO public.pais (nombre) 
VALUES
    ('Croacia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Cuba');
INSERT INTO public.pais (nombre) 
VALUES
    ('Dinamarca');
INSERT INTO public.pais (nombre) 
VALUES
    ('Dominica');
INSERT INTO public.pais (nombre) 
VALUES
    ('Ecuador');
INSERT INTO public.pais (nombre) 
VALUES
    ('Egipto');
INSERT INTO public.pais (nombre) 
VALUES
    ('El Salvador');
INSERT INTO public.pais (nombre) 
VALUES
    ('Emiratos Árabes Unidos');
INSERT INTO public.pais (nombre) 
VALUES
    ('Eritrea');
INSERT INTO public.pais (nombre) 
VALUES
    ('Eslovaquia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Eslovenia');
INSERT INTO public.pais (nombre) 
VALUES
    ('España');
INSERT INTO public.pais (nombre) 
VALUES
    ('Estados Unidos');
INSERT INTO public.pais (nombre) 
VALUES
    ('Estonia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Esuatini');
INSERT INTO public.pais (nombre) 
VALUES
    ('Etiopía');
INSERT INTO public.pais (nombre) 
VALUES
    ('Filipinas');
INSERT INTO public.pais (nombre) 
VALUES
    ('Finlandia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Fiyi');
INSERT INTO public.pais (nombre) 
VALUES
    ('Francia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Gabón');
INSERT INTO public.pais (nombre) 
VALUES
    ('Gambia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Georgia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Ghana');
INSERT INTO public.pais (nombre) 
VALUES
    ('Granada');
INSERT INTO public.pais (nombre) 
VALUES
    ('Grecia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Guatemala');
INSERT INTO public.pais (nombre) 
VALUES
    ('Guinea');
INSERT INTO public.pais (nombre) 
VALUES
    ('Guinea Ecuatorial');
INSERT INTO public.pais (nombre) 
VALUES
    ('Guinea-Bisáu');
INSERT INTO public.pais (nombre) 
VALUES
    ('Guyana');
INSERT INTO public.pais (nombre) 
VALUES
    ('Haití');
INSERT INTO public.pais (nombre) 
VALUES
    ('Honduras');
INSERT INTO public.pais (nombre) 
VALUES
    ('Hungría');
INSERT INTO public.pais (nombre) 
VALUES
    ('India');
INSERT INTO public.pais (nombre) 
VALUES
    ('Indonesia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Irak');
INSERT INTO public.pais (nombre) 
VALUES
    ('Irán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Irlanda');
INSERT INTO public.pais (nombre) 
VALUES
    ('Islandia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Islas Marshall');
INSERT INTO public.pais (nombre) 
VALUES
    ('Islas Salomón');
INSERT INTO public.pais (nombre) 
VALUES
    ('Israel');
INSERT INTO public.pais (nombre) 
VALUES
    ('Italia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Jamaica');
INSERT INTO public.pais (nombre) 
VALUES
    ('Japón');
INSERT INTO public.pais (nombre) 
VALUES
    ('Jordania');
INSERT INTO public.pais (nombre) 
VALUES
    ('Kazajistán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Kenia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Kirguistán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Kiribati');
INSERT INTO public.pais (nombre) 
VALUES
    ('Kuwait');
INSERT INTO public.pais (nombre) 
VALUES
    ('Laos');
INSERT INTO public.pais (nombre) 
VALUES
    ('Lesoto');
INSERT INTO public.pais (nombre) 
VALUES
    ('Letonia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Líbano');
INSERT INTO public.pais (nombre) 
VALUES
    ('Liberia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Libia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Liechtenstein');
INSERT INTO public.pais (nombre) 
VALUES
    ('Lituania');
INSERT INTO public.pais (nombre) 
VALUES
    ('Luxemburgo');
INSERT INTO public.pais (nombre) 
VALUES
    ('Madagascar');
INSERT INTO public.pais (nombre) 
VALUES
    ('Malasia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Malaui');
INSERT INTO public.pais (nombre) 
VALUES
    ('Maldivas');
INSERT INTO public.pais (nombre) 
VALUES
    ('Malí');
INSERT INTO public.pais (nombre) 
VALUES
    ('Malta');
INSERT INTO public.pais (nombre) 
VALUES
    ('Marruecos');
INSERT INTO public.pais (nombre) 
VALUES
    ('Mauricio');
INSERT INTO public.pais (nombre) 
VALUES
    ('Mauritania');
INSERT INTO public.pais (nombre) 
VALUES
    ('México');
INSERT INTO public.pais (nombre) 
VALUES
    ('Micronesia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Moldavia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Mónaco');
INSERT INTO public.pais (nombre) 
VALUES
    ('Mongolia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Montenegro');
INSERT INTO public.pais (nombre) 
VALUES
    ('Mozambique');
INSERT INTO public.pais (nombre) 
VALUES
    ('Namibia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Nauru');
INSERT INTO public.pais (nombre) 
VALUES
    ('Nepal');
INSERT INTO public.pais (nombre) 
VALUES
    ('Nicaragua');
INSERT INTO public.pais (nombre) 
VALUES
    ('Níger');
INSERT INTO public.pais (nombre) 
VALUES
    ('Nigeria');
INSERT INTO public.pais (nombre) 
VALUES
    ('Noruega');
INSERT INTO public.pais (nombre) 
VALUES
    ('Nueva Zelanda');
INSERT INTO public.pais (nombre) 
VALUES
    ('Omán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Países Bajos');
INSERT INTO public.pais (nombre) 
VALUES
    ('Pakistán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Palaos');
INSERT INTO public.pais (nombre) 
VALUES
    ('Palestina');
INSERT INTO public.pais (nombre) 
VALUES
    ('Panamá');
INSERT INTO public.pais (nombre) 
VALUES
    ('Papúa Nueva Guinea');
INSERT INTO public.pais (nombre) 
VALUES
    ('Paraguay');
INSERT INTO public.pais (nombre) 
VALUES
    ('Perú');
INSERT INTO public.pais (nombre) 
VALUES
    ('Polonia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Portugal');
INSERT INTO public.pais (nombre) 
VALUES
    ('Reino Unido');
INSERT INTO public.pais (nombre) 
VALUES
    ('República Centroafricana');
INSERT INTO public.pais (nombre) 
VALUES
    ('República Checa');
INSERT INTO public.pais (nombre) 
VALUES
    ('República del Congo');
INSERT INTO public.pais (nombre) 
VALUES
    ('República Democrática del Congo');
INSERT INTO public.pais (nombre) 
VALUES
    ('República Dominicana');
INSERT INTO public.pais (nombre) 
VALUES
    ('Ruanda');
INSERT INTO public.pais (nombre) 
VALUES
    ('Rumania');
INSERT INTO public.pais (nombre) 
VALUES
    ('Rusia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Samoa');
INSERT INTO public.pais (nombre) 
VALUES
    ('San Cristóbal y Nieves');
INSERT INTO public.pais (nombre) 
VALUES
    ('San Marino');
INSERT INTO public.pais (nombre) 
VALUES
    ('San Vicente y las Granadinas');
INSERT INTO public.pais (nombre) 
VALUES
    ('Santa Lucía');
INSERT INTO public.pais (nombre) 
VALUES
    ('Santa Sede');
INSERT INTO public.pais (nombre) 
VALUES
    ('Santo Tomé y Príncipe');
INSERT INTO public.pais (nombre) 
VALUES
    ('Senegal');
INSERT INTO public.pais (nombre) 
VALUES
    ('Serbia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Seychelles');
INSERT INTO public.pais (nombre) 
VALUES
    ('Sierra Leona');
INSERT INTO public.pais (nombre) 
VALUES
    ('Singapur');
INSERT INTO public.pais (nombre) 
VALUES
    ('Siria');
INSERT INTO public.pais (nombre) 
VALUES
    ('Somalia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Sri Lanka');
INSERT INTO public.pais (nombre) 
VALUES
    ('Sudáfrica');
INSERT INTO public.pais (nombre) 
VALUES
    ('Sudán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Sudán del Sur');
INSERT INTO public.pais (nombre) 
VALUES
    ('Suecia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Suiza');
INSERT INTO public.pais (nombre) 
VALUES
    ('Surinam');
INSERT INTO public.pais (nombre) 
VALUES
    ('Tailandia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Tanzania');
INSERT INTO public.pais (nombre) 
VALUES
    ('Tayikistán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Timor Oriental');
INSERT INTO public.pais (nombre) 
VALUES
    ('Togo');
INSERT INTO public.pais (nombre) 
VALUES
    ('Tonga');
INSERT INTO public.pais (nombre) 
VALUES
    ('Trinidad y Tobago');
INSERT INTO public.pais (nombre) 
VALUES
    ('Túnez');
INSERT INTO public.pais (nombre) 
VALUES
    ('Turkmenistán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Turquía');
INSERT INTO public.pais (nombre) 
VALUES
    ('Tuvalu');
INSERT INTO public.pais (nombre) 
VALUES
    ('Ucrania');
INSERT INTO public.pais (nombre) 
VALUES
    ('Uganda');
INSERT INTO public.pais (nombre) 
VALUES
    ('Uruguay');
INSERT INTO public.pais (nombre) 
VALUES
    ('Uzbekistán');
INSERT INTO public.pais (nombre) 
VALUES
    ('Vanuatu');
INSERT INTO public.pais (nombre) 
VALUES
    ('Vaticano');
INSERT INTO public.pais (nombre) 
VALUES
    ('Venezuela');
INSERT INTO public.pais (nombre) 
VALUES
    ('Vietnam');
INSERT INTO public.pais (nombre) 
VALUES
    ('Yemen');
INSERT INTO public.pais (nombre) 
VALUES
    ('Yibuti');
INSERT INTO public.pais (nombre) 
VALUES
    ('Zambia');
INSERT INTO public.pais (nombre) 
VALUES
    ('Zimbabue');


-- estatus
INSERT INTO public.estatus (nombre)
VALUES
    ('Pendiente');
INSERT INTO public.estatus (nombre)
VALUES
    ('Autorizada');
INSERT INTO public.estatus (nombre)
VALUES
    ('Realizada');
INSERT INTO public.estatus (nombre)
VALUES
    ('Cancelada');


-- tipo
INSERT INTO public.tipo (nombre)
VALUES
    ('Aula');
INSERT INTO public.tipo (nombre)
VALUES
    ('Auditorio');
INSERT INTO public.tipo (nombre)
VALUES
    ('Salas de conferencia');
INSERT INTO public.tipo (nombre)
VALUES
    ('Espacios tecnológicos');


-- TABLAS PADRE-HIJA
-- puesto
INSERT INTO public.puesto (nombre, id_area) VALUES
	('Coordinadora de Fiscal', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Fiscal'));
INSERT INTO public.puesto (nombre, id_area) VALUES
	('Coordinador de Finanzas', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Finanzas'));
INSERT INTO public.puesto (nombre, id_area) VALUES
	('Coordinador de Derecho', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Derecho'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador de Administración Escolar del Centro de Idiomas', (SELECT id_area FROM public.area WHERE nombre = 'Centro de Idiomas (CEDI)'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Jefa del Centro de Informática', (SELECT id_area FROM public.area WHERE nombre = 'Centro de Informática'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador de Administración Avanzada', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Administración Avanzada'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinadora de Administración Básica', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Administración Básica'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador de Auditoría', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Auditoria'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinadora de Contabilidad Avanzada', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Contabilidad'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador de Contabilidad Básica', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Contabilidad Básica'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador de Costos y Presupuestos', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Costos y Presupuestos'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinadora de Derecho', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Derecho'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinadora de Economía', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Economía'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinadora de Finanzas', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Finanzas'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador de Fiscal', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Fiscal'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador de Informática', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Informática'));
INSERT INTO public.puesto (nombre, id_area) VALUES       
    ('Coordinador de Matemáticas', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Matemáticas'));
INSERT INTO public.puesto (nombre, id_area) VALUES       
    ('Coordinador de Mercadotecnia', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Mercadotecnia'));
INSERT INTO public.puesto (nombre, id_area) VALUES   
    ('Coordinador de Metodología de la Investigación y Ética', (SELECT id_area FROM public.area WHERE nombre = 'Coordinación de Metodología de la Investigación y Ética'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador Académico', (SELECT id_area FROM public.area WHERE nombre = 'División de Educación Continua'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador Administrativo', (SELECT id_area FROM public.area WHERE nombre = 'División de Educación Continua'));
INSERT INTO public.puesto (nombre, id_area) VALUES    
    ('Difusión y Promoción', (SELECT id_area FROM public.area WHERE nombre = 'División de Educación Continua'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Jefa de la División de Educación Continua', (SELECT id_area FROM public.area WHERE nombre = 'División de Educación Continua'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinación de la Especialización en Fiscal', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinación de la Maestría en Alta Dirección', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinación de la Maestría en Auditoría', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinación de la Maestría en Finanzas', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinación de la Maestría en Negocios Internacionales y Maestría en Turismo', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinación de las Especializaciones en Alta Dirección, Recursos Humanos y Mercadotecnia', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador de la Maestría en Informática Administrativa', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador de las Especialidades en Alta Dirección, Recursos Humanos y Mercadotecnía', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Jefa de la División de Estudios de Posgrado', (SELECT id_area FROM public.area WHERE nombre = 'División de Estudios de Posgrado'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinadora Administrativa', (SELECT id_area FROM public.area WHERE nombre = 'División de Investigación'));
INSERT INTO public.puesto (nombre, id_area) VALUES        
    ('Investigador', (SELECT id_area FROM public.area WHERE nombre = 'División de Investigación'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Investigadora', (SELECT id_area FROM public.area WHERE nombre = 'División de Investigación'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Jefe de la Divisón de Investigación', (SELECT id_area FROM public.area WHERE nombre = 'División de Investigación'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Jefe de la Licenciatura en Administración', (SELECT id_area FROM public.area WHERE nombre = 'Jefatura de la Licenciatura en Administración'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Jefa de la Licenciatura en Contaduría', (SELECT id_area FROM public.area WHERE nombre = 'Jefatura de la Licenciatura en Contaduría'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Jefe de la Licenciatura en Informática', (SELECT id_area FROM public.area WHERE nombre = 'Jefatura de la Licenciatura en Informática'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Jefe de la Licenciatura en Negocios Internacionales', (SELECT id_area FROM public.area WHERE nombre = 'Jefatura de la Licenciatura en Negocios Internacionales'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Secretario de Difusión Cultural', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría de Difusión Cultural'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinación de Desarrollo de Habilidades Profesionales y Personales', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría de Relaciones y Extensión Universitaria'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador deportivo', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría de Relaciones y Extensión Universitaria'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('iOS Development Lab', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría de Vinculación'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Responsable del Centro Nacional de Apoyo a la Pequeña y Mediana Empresa', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría de Vinculación'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinación Administrativa y Eventos', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador de Préstamo Audiovisual y Servicios', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinador Editorial', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Coordinadora de Difusión', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Departamento de Audiovisuales', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Fotógrafo', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Operación de Aparatos Audiovisuales', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Productora de video', (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Divulgación y Fomento Editorial'));
INSERT INTO public.puesto (nombre, id_area) VALUES
    ('Jefa del Sistema Universidad Abierta y Educación a Distancia', (SELECT id_area FROM public.area WHERE nombre = 'Sistema de Universidad Abierta y Educación a Distancia'));


-- usuario (contrasenia: contrasenia123)
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    -- Superadministradores
    ('coordinadora.administrativa','COAG800101ABC','Andrea','García','Acosta','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5551234567','5512345678','coordinadora.administrativa@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora Administrativa'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinacion.eventos','CAVE810202XYZ','Carlos','Vega','Cano','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5559876543','5598765432','coordinacion.eventos@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación Administrativa y Eventos'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES

    -- Administradores
    ('jefa.educacioncontinua','EDCP800101ABC','Paola','Estrada','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5551112222','5511122233','jefa.educacioncontinua@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefa de la División de Educación Continua'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('jefa.estudiosposgrado','ESPG800102DEF','Mariana','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5552223333','5522233344','jefa.estudiosposgrado@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefa de la División de Estudios de Posgrado'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('jefe.investigacion','DIVI800103GHI','Oscar','Pérez','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5553334444','5533344455','jefe.investigacion@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefe de la Divisón de Investigación'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('jefe.licadministracion','ADMN800104JKL','Daniel','Castro','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5554445555','5544455566','jefe.licadministracion@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefe de la Licenciatura en Administración'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('jefa.liccontaduria','CONT800105MNO','María','López','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5555556666','5555566677','jefa.liccontaduria@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefa de la Licenciatura en Contaduría'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('jefe.licinformatica','INFO800106PQR','Héctor','Vega','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5556667777','5566677788','jefe.licinformatica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefe de la Licenciatura en Informática'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('jefe.licnegocios','NEGI800107STU','Patricia','Ramos','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5557778888','5577788899','jefe.licnegocios@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefe de la Licenciatura en Negocios Internacionales'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('secretario.difusioncultural','SDCU800108VWX','Raúl','Jiménez','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5558889999','5588899900','secretario.difusioncultural@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Secretario de Difusión Cultural'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('jefa.centroinformatica','CINF800109YZA','Leticia','Rivera','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5559990000','5599900011','jefa.centroinformatica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefa del Centro de Informática'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('jefa.sistemaabierta','SUAE800110BCD','Elisa','Romero','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5550001111','5500011122','jefa.sistemaabierta@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Jefa del Sistema Universidad Abierta y Educación a Distancia'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES

    -- Funcionarios
    ('coordinador.administracion.avanzada','NAVA800201ABC','Héctor','Navarro','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5551010101','5510101010','coordinador.administracion.avanzada@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Administración Avanzada'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinadora.administracion.basica','RUID800202DEF','Daniela','Ruiz','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5552020202','5520202020','coordinadora.administracion.basica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora de Administración Básica'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.auditoria','MEVR800203GHI','Ricardo','Mendoza','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5553030303','5530303030','coordinador.auditoria@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Auditoría'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.contabilidad.avanzada','DOGA800204JKL','Gabriela','Domínguez','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5554040404','5540404040','coordinador.contabilidad.avanzada@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora de Contabilidad Avanzada'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinadora.contabilidad.basica','HEHU800205MNO','Hugo','Hernández','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5555050505','5550505050','coordinadora.contabilidad.basica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Contabilidad Básica'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.costos.presupuestos','JICA800206PQR','Carmen','Jiménez','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5556060606','5560606060','coordinador.costos.presupuestos@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Costos y Presupuestos'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.derecho','MOLU800207STU','Luis','Morales','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5557070707','5570707070','coordinador.derecho@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Derecho'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinadora.economia','CAIS800208VWX','Isabel','Castro','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5558080808','5580808080','coordinadora.economia@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora de Economía'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.finanzas','VEPA800209YZA','Pablo','Vega','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5559090909','5590909090','coordinador.finanzas@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Finanzas'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinadora.fiscal','SATE800210BCD','Teresa','Salazar','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5551111111','5511111111','coordinadora.fiscal@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora de Fiscal'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.informatica','ALSE800211EFG','Sergio','Álvarez','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5552222222','5522222222','coordinador.informatica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Informática'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinadora.matematicas','ROCA800212HIJ','Carla','Romero','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5553333333','5533333333','coordinadora.matematicas@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Matemáticas'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.mercadotecnia','PIJA800213KLM','Javier','Pineda','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5554444444','5544444444','coordinador.mercadotecnia@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Mercadotecnia'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinadora.metodologia.investigacion.etica','BEAN800214NOP','Ana','Beltrán','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5555555555','5555555555','coordinadora.metodologia.investigacion.etica@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de Metodología de la Investigación y Ética'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.academico','ESPA800215QRS','Paola','Estrada','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5556666666','5566666666','coordinador.academico@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador Académico'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.administrativo','ESPA800216TUV','Paola','Estrada','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5557777777','5577777777','coordinador.administrativo@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador Administrativo'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('difusion.promocion','ESPA800217WXY','Paola','Estrada','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5558888888','5588888888','difusion.promocion@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Difusión y Promoción'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinacion.especializacion.fiscal','TORR800218ZAB','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5559999999','5599999999','coordinacion.especializacion.fiscal@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de la Especialización en Fiscal'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinacion.maestria.alta.direccion','TORR800219BCD','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5551212121','5512121212','coordinacion.maestria.alta.direccion@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de la Maestría en Alta Dirección'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinacion.maestria.auditoria','TORR800220CDE','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5552323232','5523232323','coordinacion.maestria.auditoria@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de la Maestría en Auditoría'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinacion.maestria.finanzas','TORR800221DEF','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5553434343','5534343434','coordinacion.maestria.finanzas@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de la Maestría en Finanzas'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinacion.maestria.negocios.turismo','TORR800222EFG','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5554545454','5545454545','coordinacion.maestria.negocios.turismo@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de la Maestría en Negocios Internacionales y Maestría en Turismo'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinacion.especializaciones.alta.direccion.rh.mercadotecnia','TORR800223FGH','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5555656565','5556565656','coordinacion.especializaciones.alta.direccion.rh.mercadotecnia@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinación de las Especializaciones en Alta Dirección, Recursos Humanos y Mercadotecnia'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.maestria.informatica.administrativa','TORR800224GHI','Ricardo','Torres','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5556767676','5567676767','coordinador.maestria.informatica.administrativa@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador de la Maestría en Informática Administrativa'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinador.deportivo','VEGA800225HIJ','Cinthia','Vega','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5557878787','5578787878','coordinador.deportivo@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinador deportivo'));
INSERT INTO public.usuario (nombre_usuario, rfc, nombre, apellido_paterno, apellido_materno, contrasenia, telefono, celular, correo, id_rol_usuario, id_puesto)
VALUES
    ('coordinadora.difusion','GARE800226IJK','Rebeca','García','','01391dc81025f293bf2e40133fb84fb4358426b089c76206b6e7cb2753774c5a','5558989898','5589898989','coordinadora.difusion@fca.unam.mx',
        (SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
        (SELECT id_puesto FROM public.puesto WHERE nombre = 'Coordinadora de Difusión'));

-- evento
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
-- Megaeventos (ajustados a estatus Pendiente para que permanezcan en diciembre)
('Simposio de Administración 2025','Simposio anual sobre tendencias en administración',
 '2025-12-01','2025-12-05','09:00','18:00',true,false,NULL,true,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Congreso Internacional de Contaduría 2025','Congreso internacional con expertos en contaduría',
 '2025-12-02','2025-12-06','09:00','18:00',true,false,NULL,true,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Semana Académica de Informática 2025','Semana académica dedicada a la informática y tecnología',
 '2025-12-03','2025-12-07','09:00','18:00',true,false,NULL,true,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Semana académica'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES

-- Administración (10)
('Taller de Liderazgo Empresarial','Taller práctico sobre liderazgo en administración',
 '2025-12-04','2025-12-04','10:00','14:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Taller'),
 (SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'));
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Conferencia de Innovación Administrativa','Conferencia sobre innovación en procesos administrativos',
 '2025-12-05','2025-12-05','11:00','13:00',false,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conferencia'),
 (SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'));
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Conversatorio: Retos de la Administración','Conversatorio con expertos sobre retos actuales',
 '2025-11-20','2025-11-20','12:00','14:00',true,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conversatorio'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Charla sobre Gestión de Proyectos','Charla sobre herramientas de gestión de proyectos',
 '2025-04-05','2025-04-05','09:00','11:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Realizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Charla'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Seminario de Administración Pública','Seminario sobre administración pública moderna',
 '2025-09-07','2025-09-09','10:00','13:00',true,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Seminario'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Simposio de Recursos Humanos','Simposio sobre gestión de recursos humanos',
 '2025-12-08','2025-12-10','09:00','17:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Congreso de Administración Estratégica','Congreso sobre estrategias administrativas',
 '2025-10-09','2025-10-11','09:00','18:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Foro de Emprendimiento','Foro para emprendedores en administración',
 '2025-12-10','2025-12-10','10:00','13:00',false,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Foro'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Presentación de libro: Administración Moderna','Presentación de libro sobre administración moderna',
 '2025-09-12','2025-09-12','12:00','14:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Realizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Presentación de libro'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Taller de Planeación','Taller sobre planeación estratégica',
 '2025-09-15','2025-09-15','09:00','13:00',false,true,'Cancelado por falta de inscripciones',false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Taller'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES

-- Contaduría (10)
('Taller de Auditoría Financiera','Taller sobre auditoría financiera en contaduría',
 '2025-12-04','2025-12-04','10:00','14:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Taller'),
 (SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'));
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Conferencia de Normas Contables','Conferencia sobre nuevas normas contables',
 '2025-12-05','2025-12-05','11:00','13:00',false,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conferencia'),
 (SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'));
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Conversatorio: Ética en la Contaduría','Conversatorio sobre ética profesional',
 '2025-12-06','2025-12-06','12:00','14:00',true,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conversatorio'),
 (SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'));
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Charla sobre Impuestos','Charla sobre actualización fiscal',
 '2025-04-10','2025-04-10','09:00','11:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Realizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Charla'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Seminario de Contabilidad Internacional','Seminario sobre contabilidad internacional',
 '2025-09-07','2025-09-09','10:00','13:00',true,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Seminario'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Simposio de Auditoría','Simposio sobre auditoría avanzada',
 '2025-12-08','2025-12-10','09:00','17:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Congreso de Contabilidad Gubernamental','Congreso sobre contabilidad en el sector público',
 '2025-10-09','2025-10-11','09:00','18:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Foro de Fiscalización','Foro sobre fiscalización y auditoría',
 '2025-12-10','2025-12-10','10:00','13:00',false,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Foro'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Presentación de libro: Contaduría Actual','Presentación de libro sobre contaduría actual',
 '2025-09-25','2025-09-25','12:00','14:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Realizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Presentación de libro'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Seminario de Costos','Seminario sobre costos en contaduría',
 '2025-09-28','2025-09-28','09:00','13:00',false,true,'Cancelado por falta de ponentes',false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Seminario'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES

-- Negocios Internacionales (10)
('Taller de Comercio Exterior','Taller sobre comercio exterior y tratados internacionales',
 '2025-12-04','2025-12-04','10:00','14:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Taller'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Conferencia de Negocios Globales','Conferencia sobre negocios globales',
 '2025-12-05','2025-12-05','11:00','13:00',false,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conferencia'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Conversatorio: Oportunidades Internacionales','Conversatorio sobre oportunidades de negocios internacionales',
 '2025-11-06','2025-11-06','12:00','14:00',true,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conversatorio'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Charla sobre Exportaciones','Charla sobre procesos de exportación',
 '2025-04-15','2025-04-15','09:00','11:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Realizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Charla'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Semana Académica de Negocios Internacionales','Semana académica sobre negocios internacionales',
 '2025-12-03','2025-12-05','09:00','18:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Semana académica'),
 (SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'));
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Simposio de Negocios Digitales','Simposio sobre negocios digitales y tecnología',
 '2025-12-08','2025-12-10','09:00','17:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Congreso de Negocios Internacionales','Congreso sobre tendencias en negocios internacionales',
 '2025-10-09','2025-10-11','09:00','18:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Foro de Inversión Extranjera','Foro sobre inversión extranjera en México',
 '2025-12-10','2025-12-10','10:00','13:00',false,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Foro'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Presentación de libro: Negocios Internacionales','Presentación de libro sobre negocios internacionales',
 '2025-10-05','2025-10-05','12:00','14:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Realizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Presentación de libro'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Congreso de Comercio','Congreso sobre comercio internacional',
 '2025-10-04','2025-10-04','09:00','13:00',false,true,'Cancelado por motivos logísticos',false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES

-- Informática (10)
('Taller de Ciberseguridad','Taller sobre ciberseguridad y protección de datos',
 '2025-12-04','2025-12-04','10:00','14:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Taller'),
 (SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'));
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Conferencia de Inteligencia Artificial','Conferencia sobre inteligencia artificial aplicada',
 '2025-12-05','2025-12-05','11:00','13:00',false,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conferencia'),
 (SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'));
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Conversatorio: Tecnología y Sociedad','Conversatorio sobre el impacto de la tecnología',
 '2025-12-06','2025-12-06','12:00','14:00',true,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Conversatorio'),
 (SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'));
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Charla sobre Programación','Charla introductoria a la programación',
 '2025-04-20','2025-04-20','09:00','11:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Realizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Charla'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Seminario de Big Data','Seminario sobre análisis de grandes volúmenes de datos',
 '2025-09-07','2025-09-09','10:00','13:00',true,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Seminario'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Simposio de Innovación Tecnológica','Simposio sobre innovación en tecnología',
 '2025-12-08','2025-12-10','09:00','17:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Congreso de Informática Educativa','Congreso sobre informática aplicada a la educación',
 '2025-10-09','2025-10-11','09:00','18:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Congreso'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Foro de Tecnología','Foro sobre avances tecnológicos',
 '2025-12-10','2025-12-10','10:00','13:00',false,true,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Foro'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Presentación de libro: Informática Moderna','Presentación de libro sobre informática moderna',
 '2025-09-18','2025-09-18','12:00','14:00',true,false,NULL,false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Realizada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Presentación de libro'),NULL);
INSERT INTO public.evento (nombre, descripcion, fecha_inicio, fecha_fin, horario_inicio, horario_fin, presencial, online, motivo, mega_evento, id_estatus, id_categoria, id_mega_evento)
VALUES
('Simposio de Software Libre','Simposio sobre software libre y código abierto',
 '2025-09-20','2025-09-20','09:00','13:00',false,true,'Cancelado por falta de patrocinadores',false,
 (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'),
 (SELECT id_categoria FROM public.categoria WHERE nombre='Simposio'),NULL);


-- grado
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Técnico en Administración', (SELECT id_nivel FROM public.nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Licenciado en Administración', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Ingeniero en Administración de Empresas', (SELECT id_nivel FROM public.nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Especialista en Gestión Administrativa', (SELECT id_nivel FROM public.nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Maestro en Administración Pública', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Doctor en Administración', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Posdoctorado en Administración Estratégica', (SELECT id_nivel FROM public.nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES

('Técnico en Contaduría', (SELECT id_nivel FROM public.nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Licenciado en Contaduría', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Ingeniero en Contabilidad', (SELECT id_nivel FROM public.nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Especialista en Auditoría', (SELECT id_nivel FROM public.nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Maestro en Contabilidad Internacional', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Doctor en Contaduría', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Posdoctorado en Fiscalización', (SELECT id_nivel FROM public.nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES

('Técnico en Informática', (SELECT id_nivel FROM public.nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Licenciado en Informática', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Ingeniero en Sistemas Computacionales', (SELECT id_nivel FROM public.nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Especialista en Seguridad Informática', (SELECT id_nivel FROM public.nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Maestro en Inteligencia Artificial', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Doctor en Informática', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Posdoctorado en Big Data', (SELECT id_nivel FROM public.nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES

('Técnico en Negocios Internacionales', (SELECT id_nivel FROM public.nivel WHERE nombre='Técnico Superior Universitario'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Licenciado en Negocios Internacionales', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Ingeniero en Comercio Exterior', (SELECT id_nivel FROM public.nivel WHERE nombre='Ingeniería'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Especialista en Negocios Digitales', (SELECT id_nivel FROM public.nivel WHERE nombre='Especialidad'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Maestro en Economía Internacional', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Doctor en Negocios Internacionales', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Posdoctorado en Comercio Internacional', (SELECT id_nivel FROM public.nivel WHERE nombre='Posdoctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES

('Licenciado en Derecho', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Maestro en Psicología', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Doctor en Sociología', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='México'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Licenciado en Historia', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='España'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Maestro en Filosofía', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Francia'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Doctor en Ciencias Políticas', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Estados Unidos'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Licenciado en Biología', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Canadá'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Maestro en Matemáticas', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Alemania'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Doctor en Física', (SELECT id_nivel FROM public.nivel WHERE nombre='Doctorado'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='China'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Licenciado en Ciencias Ambientales', (SELECT id_nivel FROM public.nivel WHERE nombre='Licenciatura'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Guatemala'));
INSERT INTO public.grado (titulo,id_nivel,id_institucion,id_pais)
VALUES
('Maestro en Educación', (SELECT id_nivel FROM public.nivel WHERE nombre='Maestría'), (SELECT id_institucion FROM public.institucion WHERE nombre='Universidad Nacional Autónoma de México'), (SELECT id_pais FROM public.pais WHERE nombre='Costa Rica'));


-- equipamiento
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    -- activos
    ('Paño azul',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Actos'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Mesa adicional',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Actos'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Personalizadores',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Actos'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Laptop',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Centro de Informática'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Zoom',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Centro de Informática'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Equipo de sonido',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Pantalla',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Videoproyector',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Fotógrafo',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Publicaciones y Fomento Editorial'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Boletín algo más (reportero)',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Publicaciones y Fomento Editorial'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Vigilancia',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Presidium',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Otros',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Limpieza entrada',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Limpieza de auditorio',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Limpieza baños',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Limpieza vestidores',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Abrir auditorio',True,
        (SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'));
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES

    -- inactivos
    ('Atril',False,NULL);
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Lámpara de pie',False,NULL);
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Lámpara de mesa',False,NULL);
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Cañón de luz',False,NULL);
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Cañón de humo',False,NULL);
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Cañón de burbujas',False,NULL);
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Cañón de confeti',False,NULL);
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Pantalla verde',False,NULL);
INSERT INTO public.equipamiento (nombre,activo,id_area)
VALUES
    ('Telón rojo',False,NULL);


-- recinto
INSERT INTO public.recinto (nombre,latitud,longitud,aforo,croquis,id_tipo)
VALUES
    ('Auditorio Mtro. Carlos Pérez del Toro',19.324278712159654,-99.18503538465767,480,'/croquis/croquis_auditorio_mtro_carlos_perez_del_toro.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Auditorio'));
INSERT INTO public.recinto (nombre,latitud,longitud,aforo,croquis,id_tipo)
VALUES
    ('Aula Magna de Profesores Eméritos',19.3245169609446,-99.18476376157348,50,'/croquis/croquis_aula_magna_de_profesores_emeritos.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Aula'));
INSERT INTO public.recinto (nombre,latitud,longitud,aforo,croquis,id_tipo)
VALUES
    ('Auditorio C.P. Tomás López Sánchez',19.32569018583663,-99.18458590493218,50,'/croquis/croquis_auditorio_cp_tomas_lopez_sanchez.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Auditorio'));
INSERT INTO public.recinto (nombre,latitud,longitud,aforo,croquis,id_tipo)
VALUES
    ('Centro de Informática (CIFCA)',19.326002426331637,-99.18422689328244,80,'/croquis/croquis_centro_de_informatica_cifca.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Aula'));
INSERT INTO public.recinto (nombre,latitud,longitud,aforo,croquis,id_tipo)
VALUES
    ('Auditorio C.P. Alfonso Ochoa Ravizé',19.324491252154367,-99.1854765779373,100,'/croquis/croquis_auditorio_cp_alfonso_ochoa_ravize.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Auditorio'));
INSERT INTO public.recinto (nombre,latitud,longitud,aforo,croquis,id_tipo)
VALUES
    ('Centro de Idiomas (CEDI)',19.32423975000072,-99.18554360862876,40,'/croquis/croquis_centro_de_idiomas_cedi.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Aula'));
INSERT INTO public.recinto (nombre,latitud,longitud,aforo,croquis,id_tipo)
VALUES
    ('Aula Magna de Investigación',19.32309769543537,-99.18318304205229,50,'/croquis/croquis_aula_magna_de_investigacion.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Aula'));
INSERT INTO public.recinto (nombre,latitud,longitud,aforo,croquis,id_tipo)
VALUES
    ('Auditorio C.P. Arturo Elizundia Charles',19.32308553191999,-99.18310449475594,50,'/croquis/croquis_auditorio_cp_arturo_elizundia_charles.png',
        (SELECT id_tipo FROM public.tipo WHERE nombre = 'Auditorio'));


 -- TABLAS HIJA
-- rolxpermiso
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    -- Superadministrador
    --      usuarios
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='crear' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='leer' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='editar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='eliminar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='leer' AND alcance='propietario'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Superadministrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='editar' AND alcance='propietario'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    
    -- Administrador
    --      usuarios
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='crear' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='leer' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='editar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='eliminar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='leer' AND alcance='propietario'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='editar' AND alcance='propietario'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    
    --      recintos
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto' AND accion='crear' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto' AND accion='leer' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto' AND accion='editar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto' AND accion='eliminar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    
    --      reservaciones
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='reservacion' AND accion='leer' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='reservacion' AND accion='editar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES

    --      eventos
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='evento' AND accion='leer' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='evento' AND accion='editar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES

    --      inventarios
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='area_inventario' AND accion='crear' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='area_inventario' AND accion='leer' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='area_inventario' AND accion='editar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='area_inventario' AND accion='eliminar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto_inventario' AND accion='crear' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto_inventario' AND accion='leer' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto_inventario' AND accion='editar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='recinto_inventario' AND accion='eliminar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES

    --      catalogos
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='catalogo' AND accion='crear' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='catalogo' AND accion='leer' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Administrador'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='catalogo' AND accion='eliminar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    
    -- Funcionario
    --      usuarios
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='leer' AND alcance='propietario'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='usuario' AND accion='editar' AND alcance='propietario'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES

    --      reservaciones
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='reservacion' AND accion='crear' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='reservacion' AND accion='leer' AND alcance='propietario'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='reservacion' AND accion='editar' AND alcance='propietario'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    
    --      eventos
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='evento' AND accion='crear' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='evento' AND accion='leer' AND alcance='propietario'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='evento' AND accion='editar' AND alcance='propietario'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    
    --      integrantes
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='integrante' AND accion='crear' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='integrante' AND accion='leer' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='integrante' AND accion='editar' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES

    --     catalogos
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='catalogo' AND accion='crear' AND alcance='global'));
INSERT INTO public.rolxpermiso (id_rol_usuario,id_permiso)
VALUES
    ((SELECT id_rol_usuario FROM public.rol_usuario WHERE nombre = 'Funcionario'),
     (SELECT id_permiso FROM public.permiso WHERE recurso='catalogo' AND accion='leer' AND alcance='global'));

    

-- evento_organizador
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    -- Simposio de Administración 2025
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administracion.avanzada'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.administracion.basica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.auditoria'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Congreso Internacional de Contaduría 2025
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.contabilidad.avanzada'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.contabilidad.basica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.costos.presupuestos'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Semana Académica de Informática 2025
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.matematicas'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Taller de Liderazgo Empresarial
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administracion.avanzada'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Conferencia de Innovación Administrativa
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administrativo'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Conversatorio: Retos de la Administración
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.academico'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administrativo'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Charla sobre Gestión de Proyectos
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administracion.avanzada'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Seminario de Administración Pública
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administracion.avanzada'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.economia'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Simposio de Recursos Humanos
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.mercadotecnia'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Congreso de Administración Estratégica
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administracion.avanzada'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.costos.presupuestos'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Foro de Emprendimiento
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='difusion.promocion'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Presentación de libro: Administración Moderna
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.difusion'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Taller de Planeación
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.administrativo'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Taller de Auditoría Financiera
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.auditoria'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Conferencia de Normas Contables
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.contabilidad.avanzada'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Conversatorio: Ética en la Contaduría
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.contabilidad.basica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.auditoria'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Charla sobre Impuestos
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.fiscal'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Seminario de Contabilidad Internacional
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.contabilidad.avanzada'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Simposio de Auditoría
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.auditoria'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Congreso de Contabilidad Gubernamental
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.contabilidad.avanzada'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.contabilidad.basica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Foro de Fiscalización
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.fiscal'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Presentación de libro: Contaduría Actual
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.difusion'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Seminario de Costos
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.costos.presupuestos'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Taller de Comercio Exterior
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Conferencia de Negocios Globales
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Conversatorio: Oportunidades Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.mercadotecnia'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Charla sobre Exportaciones
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Semana Académica de Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Simposio de Negocios Digitales
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Congreso de Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Foro de Inversión Extranjera
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.finanzas'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Presentación de libro: Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.difusion'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Congreso de Comercio
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinacion.maestria.negocios.turismo'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Taller de Ciberseguridad
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Conferencia de Inteligencia Artificial
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Conversatorio: Tecnología y Sociedad
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.matematicas'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Charla sobre Programación
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Seminario de Big Data
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Simposio de Innovación Tecnológica
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Congreso de Informática Educativa
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Foro de Tecnología
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Presentación de libro: Informática Moderna
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinadora.difusion'));
INSERT INTO public.evento_organizador (id_evento,id_usuario)
VALUES

    -- Simposio de Software Libre
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'), (SELECT id_usuario FROM public.usuario WHERE nombre_usuario='coordinador.informatica'));


-- participacion
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    -- Taller de Liderazgo Empresarial
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Juan' AND apellido_paterno='Pérez' AND apellido_materno='Gómez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Ana' AND apellido_paterno='López' AND apellido_materno='Martínez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Conferencia de Innovación Administrativa
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Carlos' AND apellido_paterno='Ramírez' AND apellido_materno='Sánchez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='María' AND apellido_paterno='Fernández' AND apellido_materno='Ruiz'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Conversatorio: Retos de la Administración
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Luis' AND apellido_paterno='García' AND apellido_materno='Torres'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Sofía' AND apellido_paterno='Martínez' AND apellido_materno='Vega'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Pedro' AND apellido_paterno='Gómez' AND apellido_materno='López'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Charla sobre Gestión de Proyectos
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Miguel' AND apellido_paterno='Hernández' AND apellido_materno='Castro'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Seminario de Administración Pública
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Laura' AND apellido_paterno='Gómez' AND apellido_materno='Morales'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Jorge' AND apellido_paterno='Díaz' AND apellido_materno='Jiménez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Susana' AND apellido_paterno='Torres' AND apellido_materno='Ramírez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Simposio de Recursos Humanos
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Patricia' AND apellido_paterno='Ruiz' AND apellido_materno='Navarro'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Congreso de Administración Estratégica
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Fernando' AND apellido_paterno='Torres' AND apellido_materno='Luna'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Gabriela' AND apellido_paterno='Sánchez' AND apellido_materno='Ortega'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Ricardo' AND apellido_paterno='Morales' AND apellido_materno='Vargas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Tomás' AND apellido_paterno='Sánchez' AND apellido_materno='Fernández'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Foro de Emprendimiento
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Verónica' AND apellido_paterno='Castro' AND apellido_materno='Mendoza'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Presentación de libro: Administración Moderna
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Alejandro' AND apellido_paterno='Navarro' AND apellido_materno='Salinas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Taller de Planeación
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Claudia' AND apellido_paterno='Jiménez' AND apellido_materno='Ramos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Taller de Auditoría Financiera
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Roberto' AND apellido_paterno='Luna' AND apellido_materno='García'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Conferencia de Normas Contables
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Isabel' AND apellido_paterno='Ortega' AND apellido_materno='Fernández'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Conversatorio: Ética en la Contaduría
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Héctor' AND apellido_paterno='Vargas' AND apellido_materno='Santos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Carmen' AND apellido_paterno='Mendoza' AND apellido_materno='Pérez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Guillermo' AND apellido_paterno='Navarro' AND apellido_materno='Vargas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Charla sobre Impuestos
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Javier' AND apellido_paterno='Salinas' AND apellido_materno='López'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Seminario de Contabilidad Internacional
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Mónica' AND apellido_paterno='Ramos' AND apellido_materno='Martínez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Pablo' AND apellido_paterno='García' AND apellido_materno='Ramírez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Marina' AND apellido_paterno='Ortega' AND apellido_materno='Salinas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Simposio de Auditoría
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Teresa' AND apellido_paterno='Fernández' AND apellido_materno='Sánchez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Congreso de Contabilidad Gubernamental
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Sergio' AND apellido_paterno='Santos' AND apellido_materno='Torres'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Carla' AND apellido_paterno='Pérez' AND apellido_materno='Morales'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Foro de Fiscalización
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Julio' AND apellido_paterno='López' AND apellido_materno='Navarro'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Presentación de libro: Contaduría Actual
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Beatriz' AND apellido_paterno='Martínez' AND apellido_materno='Jiménez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Seminario de Costos
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Rafael' AND apellido_paterno='Ramírez' AND apellido_materno='Ruiz'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Taller de Comercio Exterior
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Lucía' AND apellido_paterno='Sánchez' AND apellido_materno='Castro'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Conferencia de Negocios Globales
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Esteban' AND apellido_paterno='Torres' AND apellido_materno='Gómez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Conversatorio: Oportunidades Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Andrea' AND apellido_paterno='Morales' AND apellido_materno='Díaz'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Manuel' AND apellido_paterno='Navarro' AND apellido_materno='Salazar'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Alberto' AND apellido_paterno='Luna' AND apellido_materno='Ramos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Charla sobre Exportaciones
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Rebeca' AND apellido_paterno='Jiménez' AND apellido_materno='Luna'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Semana Académica de Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Oscar' AND apellido_paterno='García' AND apellido_materno='Ortega'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Nadia' AND apellido_paterno='Fernández' AND apellido_materno='Vargas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Simposio de Negocios Digitales
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Iván' AND apellido_paterno='Mendoza' AND apellido_materno='Santos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Congreso de Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Elena' AND apellido_paterno='Salinas' AND apellido_materno='Pérez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Raúl' AND apellido_paterno='Ramos' AND apellido_materno='López'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Foro de Inversión Extranjera
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Felipe' AND apellido_paterno='Martínez' AND apellido_materno='Gómez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Presentación de libro: Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Adriana' AND apellido_paterno='Ruiz' AND apellido_materno='Morales'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Congreso de Comercio
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Cristian' AND apellido_paterno='Hernández' AND apellido_materno='Pérez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Taller de Ciberseguridad
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Fernando' AND apellido_paterno='Torres' AND apellido_materno='Luna'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Conferencia de Inteligencia Artificial
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Gabriela' AND apellido_paterno='Sánchez' AND apellido_materno='Ortega'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Conversatorio: Tecnología y Sociedad
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Ricardo' AND apellido_paterno='Morales' AND apellido_materno='Vargas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Verónica' AND apellido_paterno='Castro' AND apellido_materno='Mendoza'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Silvia' AND apellido_paterno='Morales' AND apellido_materno='García'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Charla sobre Programación
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Alejandro' AND apellido_paterno='Navarro' AND apellido_materno='Salinas'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Seminario de Big Data
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Claudia' AND apellido_paterno='Jiménez' AND apellido_materno='Ramos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Roberto' AND apellido_paterno='Luna' AND apellido_materno='García'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Diego' AND apellido_paterno='Pérez' AND apellido_materno='Santos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Moderador'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Simposio de Innovación Tecnológica
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Isabel' AND apellido_paterno='Ortega' AND apellido_materno='Fernández'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Congreso de Informática Educativa
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Héctor' AND apellido_paterno='Vargas' AND apellido_materno='Santos'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Carmen' AND apellido_paterno='Mendoza' AND apellido_materno='Pérez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Foro de Tecnología
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Javier' AND apellido_paterno='Salinas' AND apellido_materno='López'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Presentación de libro: Informática Moderna
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Beatriz' AND apellido_paterno='Martínez' AND apellido_materno='Jiménez'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));
INSERT INTO public.participacion (id_evento,id_integrante,id_rol_participacion)
VALUES

    -- Simposio de Software Libre
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
     (SELECT id_integrante FROM public.integrante WHERE nombre='Rafael' AND apellido_paterno='Ramírez' AND apellido_materno='Ruiz'),
     (SELECT id_rol_participacion FROM public.rol_participacion WHERE nombre='Ponente'));


-- integrantexgrado
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Juan Pérez Gómez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Juan' AND apellido_paterno='Pérez' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Juan' AND apellido_paterno='Pérez' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Ana López Martínez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Ana' AND apellido_paterno='López' AND apellido_materno='Martínez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Ana' AND apellido_paterno='López' AND apellido_materno='Martínez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Carlos Ramírez Sánchez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carlos' AND apellido_paterno='Ramírez' AND apellido_materno='Sánchez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carlos' AND apellido_paterno='Ramírez' AND apellido_materno='Sánchez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Especialista en Auditoría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carlos' AND apellido_paterno='Ramírez' AND apellido_materno='Sánchez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- María Fernández Ruiz
    ((SELECT id_integrante FROM public.integrante WHERE nombre='María' AND apellido_paterno='Fernández' AND apellido_materno='Ruiz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Historia'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='María' AND apellido_paterno='Fernández' AND apellido_materno='Ruiz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Filosofía'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Luis García Torres
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Luis' AND apellido_paterno='García' AND apellido_materno='Torres'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Derecho'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Luis' AND apellido_paterno='García' AND apellido_materno='Torres'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Ciencias Políticas'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Sofía Martínez Vega
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Sofía' AND apellido_paterno='Martínez' AND apellido_materno='Vega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Sofía' AND apellido_paterno='Martínez' AND apellido_materno='Vega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Economía Internacional'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Miguel Hernández Castro
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Miguel' AND apellido_paterno='Hernández' AND apellido_materno='Castro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Miguel' AND apellido_paterno='Hernández' AND apellido_materno='Castro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Ingeniero en Sistemas Computacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Laura Gómez Morales
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Laura' AND apellido_paterno='Gómez' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Laura' AND apellido_paterno='Gómez' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Especialista en Gestión Administrativa'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Laura' AND apellido_paterno='Gómez' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Jorge Díaz Jiménez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Jorge' AND apellido_paterno='Díaz' AND apellido_materno='Jiménez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Jorge' AND apellido_paterno='Díaz' AND apellido_materno='Jiménez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Contabilidad Internacional'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Patricia Ruiz Navarro
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Patricia' AND apellido_paterno='Ruiz' AND apellido_materno='Navarro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Patricia' AND apellido_paterno='Ruiz' AND apellido_materno='Navarro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Fernando Torres Luna
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Fernando' AND apellido_paterno='Torres' AND apellido_materno='Luna'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Fernando' AND apellido_paterno='Torres' AND apellido_materno='Luna'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Gabriela Sánchez Ortega
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Gabriela' AND apellido_paterno='Sánchez' AND apellido_materno='Ortega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Gabriela' AND apellido_paterno='Sánchez' AND apellido_materno='Ortega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Especialista en Auditoría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Ricardo Morales Vargas
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Ricardo' AND apellido_paterno='Morales' AND apellido_materno='Vargas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Ricardo' AND apellido_paterno='Morales' AND apellido_materno='Vargas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Verónica Castro Mendoza
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Verónica' AND apellido_paterno='Castro' AND apellido_materno='Mendoza'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Verónica' AND apellido_paterno='Castro' AND apellido_materno='Mendoza'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Negocios Internacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Alejandro Navarro Salinas
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Alejandro' AND apellido_paterno='Navarro' AND apellido_materno='Salinas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Alejandro' AND apellido_paterno='Navarro' AND apellido_materno='Salinas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Ingeniero en Sistemas Computacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Claudia Jiménez Ramos
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Claudia' AND apellido_paterno='Jiménez' AND apellido_materno='Ramos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Claudia' AND apellido_paterno='Jiménez' AND apellido_materno='Ramos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Roberto Luna García
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Roberto' AND apellido_paterno='Luna' AND apellido_materno='García'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Roberto' AND apellido_paterno='Luna' AND apellido_materno='García'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Isabel Ortega Fernández
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Isabel' AND apellido_paterno='Ortega' AND apellido_materno='Fernández'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Isabel' AND apellido_paterno='Ortega' AND apellido_materno='Fernández'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Héctor Vargas Santos
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Héctor' AND apellido_paterno='Vargas' AND apellido_materno='Santos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Héctor' AND apellido_paterno='Vargas' AND apellido_materno='Santos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Carmen Mendoza Pérez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carmen' AND apellido_paterno='Mendoza' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carmen' AND apellido_paterno='Mendoza' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Contabilidad Internacional'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Javier Salinas López
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Javier' AND apellido_paterno='Salinas' AND apellido_materno='López'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Javier' AND apellido_paterno='Salinas' AND apellido_materno='López'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Economía Internacional'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Mónica Ramos Martínez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Mónica' AND apellido_paterno='Ramos' AND apellido_materno='Martínez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Mónica' AND apellido_paterno='Ramos' AND apellido_materno='Martínez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Pablo García Ramírez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Pablo' AND apellido_paterno='García' AND apellido_materno='Ramírez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Pablo' AND apellido_paterno='García' AND apellido_materno='Ramírez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Teresa Fernández Sánchez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Teresa' AND apellido_paterno='Fernández' AND apellido_materno='Sánchez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Teresa' AND apellido_paterno='Fernández' AND apellido_materno='Sánchez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Sergio Santos Torres
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Sergio' AND apellido_paterno='Santos' AND apellido_materno='Torres'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Sergio' AND apellido_paterno='Santos' AND apellido_materno='Torres'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Carla Pérez Morales
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carla' AND apellido_paterno='Pérez' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Carla' AND apellido_paterno='Pérez' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Julio López Navarro
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Julio' AND apellido_paterno='López' AND apellido_materno='Navarro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Julio' AND apellido_paterno='López' AND apellido_materno='Navarro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Beatriz Martínez Jiménez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Beatriz' AND apellido_paterno='Martínez' AND apellido_materno='Jiménez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Beatriz' AND apellido_paterno='Martínez' AND apellido_materno='Jiménez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Rafael Ramírez Ruiz
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Rafael' AND apellido_paterno='Ramírez' AND apellido_materno='Ruiz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Rafael' AND apellido_paterno='Ramírez' AND apellido_materno='Ruiz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Economía Internacional'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Lucía Sánchez Castro
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Lucía' AND apellido_paterno='Sánchez' AND apellido_materno='Castro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Lucía' AND apellido_paterno='Sánchez' AND apellido_materno='Castro'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Esteban Torres Gómez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Esteban' AND apellido_paterno='Torres' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Esteban' AND apellido_paterno='Torres' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Andrea Morales Díaz
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Andrea' AND apellido_paterno='Morales' AND apellido_materno='Díaz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Andrea' AND apellido_paterno='Morales' AND apellido_materno='Díaz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Manuel Navarro Salazar
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Manuel' AND apellido_paterno='Navarro' AND apellido_materno='Salazar'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Manuel' AND apellido_paterno='Navarro' AND apellido_materno='Salazar'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Rebeca Jiménez Luna
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Rebeca' AND apellido_paterno='Jiménez' AND apellido_materno='Luna'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Rebeca' AND apellido_paterno='Jiménez' AND apellido_materno='Luna'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Contabilidad Internacional'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Oscar García Ortega
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Oscar' AND apellido_paterno='García' AND apellido_materno='Ortega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Oscar' AND apellido_paterno='García' AND apellido_materno='Ortega'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Nadia Fernández Vargas
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Nadia' AND apellido_paterno='Fernández' AND apellido_materno='Vargas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Nadia' AND apellido_paterno='Fernández' AND apellido_materno='Vargas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Economía Internacional'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Iván Mendoza Santos
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Iván' AND apellido_paterno='Mendoza' AND apellido_materno='Santos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Iván' AND apellido_paterno='Mendoza' AND apellido_materno='Santos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Elena Salinas Pérez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Elena' AND apellido_paterno='Salinas' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Elena' AND apellido_paterno='Salinas' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Contabilidad Internacional'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Raúl Ramos López
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Raúl' AND apellido_paterno='Ramos' AND apellido_materno='López'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Raúl' AND apellido_paterno='Ramos' AND apellido_materno='López'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Inteligencia Artificial'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Felipe Martínez Gómez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Felipe' AND apellido_paterno='Martínez' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Felipe' AND apellido_paterno='Martínez' AND apellido_materno='Gómez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Economía Internacional'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Adriana Ruiz Morales
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Adriana' AND apellido_paterno='Ruiz' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Adriana' AND apellido_paterno='Ruiz' AND apellido_materno='Morales'),
     (SELECT id_grado FROM public.grado WHERE titulo='Maestro en Administración Pública'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Cristian Hernández Pérez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Cristian' AND apellido_paterno='Hernández' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Cristian' AND apellido_paterno='Hernández' AND apellido_materno='Pérez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Doctor en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Pedro Gómez López
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Pedro' AND apellido_paterno='Gómez' AND apellido_materno='López'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Susana Torres Ramírez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Susana' AND apellido_paterno='Torres' AND apellido_materno='Ramírez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Tomás Sánchez Fernández
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Tomás' AND apellido_paterno='Sánchez' AND apellido_materno='Fernández'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Paola Castro Jiménez
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Paola' AND apellido_paterno='Castro' AND apellido_materno='Jiménez'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Guillermo Navarro Vargas
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Guillermo' AND apellido_paterno='Navarro' AND apellido_materno='Vargas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Marina Ortega Salinas
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Marina' AND apellido_paterno='Ortega' AND apellido_materno='Salinas'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Alberto Luna Ramos
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Alberto' AND apellido_paterno='Luna' AND apellido_materno='Ramos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Informática'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Silvia Morales García
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Silvia' AND apellido_paterno='Morales' AND apellido_materno='García'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Negocios Internacionales'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Diego Pérez Santos
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Diego' AND apellido_paterno='Pérez' AND apellido_materno='Santos'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Administración'));
INSERT INTO public.integrantexgrado (id_integrante,id_grado)
VALUES
    -- Lorena Mendoza Ruiz
    ((SELECT id_integrante FROM public.integrante WHERE nombre='Lorena' AND apellido_paterno='Mendoza' AND apellido_materno='Ruiz'),
     (SELECT id_grado FROM public.grado WHERE titulo='Licenciado en Contaduría'));


-- reservacion
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES
    -- Megaeventos
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-09-10 10:00:00','Cancelada por reprogramación interna',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-09-11 11:00:00','Cancelada por conflicto de agenda',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-09-12 12:00:00','Cancelada por mantenimiento del recinto',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    -- Administración
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-01 09:00:00','Cancelada por solicitud del organizador',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-10-02 09:30:00','Cancelada por disponibilidad de ponente',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-20 10:00:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-02-20 10:00:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-08-01 11:00:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-05 09:00:00','Cancelada por ajustes presupuestales',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-09-20 12:00:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-06 09:30:00','Cancelada por falta de confirmaciones',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-08-20 10:30:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-08-15 09:00:00','Cancelada por falta de inscripciones',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    -- Contaduría
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-01 14:00:00','Cancelada por cambios en el programa',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-10-02 15:00:00','Cancelada por disponibilidad de ponente',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-03 10:00:00','Cancelada por reprogramación académica',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-03-01 09:00:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-08-01 11:30:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-05 13:00:00','Cancelada por agenda institucional',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-09-20 12:30:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-06 10:00:00','Cancelada por conflicto de salas',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-09-01 10:15:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-09-05 09:45:00','Cancelada por falta de ponentes',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    -- Negocios Internacionales
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-01 16:00:00','Cancelada por cambios en lineamientos',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-10-02 16:30:00','Cancelada por ausencia de ponente',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-10 11:00:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-03-05 10:00:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-09-30 09:00:00','Cancelada por ajustes de programa',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-05 11:15:00','Cancelada por mantenimiento del equipo',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-09-20 13:00:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-06 11:30:00','Cancelada por cruce con otro evento',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-09-10 09:30:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-09-05 12:00:00','Cancelada por motivos logísticos',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    -- Informática
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-01 12:30:00','Cancelada por actualización de seguridad',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-10-02 12:45:00','Cancelada por cambios curriculares',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-03 13:15:00','Cancelada por agenda institucional',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-03-10 09:15:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-08-01 10:45:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    '2025-10-05 14:30:00','Cancelada por compatibilidad técnica',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    '2025-09-20 14:45:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Autorizada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    '2025-10-06 15:00:00','Cancelada por disponibilidad de sala',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    '2025-08-25 11:00:00',NULL,
    (SELECT id_estatus FROM public.estatus WHERE nombre='Pendiente'));
INSERT INTO public.reservacion (id_evento,id_recinto,fecha_solicitud,motivo,id_estatus)
VALUES

    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    '2025-08-28 12:30:00','Cancelada por falta de patrocinadores',
    (SELECT id_estatus FROM public.estatus WHERE nombre='Cancelada'));


-- reservacionxequipamiento
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    -- Megaeventos
    -- Simposio de Administración 2025 (Activos + Inactivo: Atril)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 3);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Administración 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Atril'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Congreso Internacional de Contaduría 2025 (Activos + Inactivo: Lámpara de pie)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'),
	(SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso Internacional de Contaduría 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Lámpara de pie'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Semana Académica de Informática 2025 (Activos + Inactivo: Lámpara de mesa)
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza de auditorio'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Informática 2025'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Lámpara de mesa'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Administración
    -- Taller de Liderazgo Empresarial (Activos + Inactivo: Cañón de luz)
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Paño azul'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Mesa adicional'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Personalizadores'), 3);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Liderazgo Empresarial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Cañón de luz'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Conferencia de Innovación Administrativa (Activos + Inactivo: Cañón de humo)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Innovación Administrativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Cañón de humo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Conversatorio: Retos de la Administración (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Retos de la Administración'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Charla sobre Gestión de Proyectos (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Gestión de Proyectos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Seminario de Administración Pública (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Administración Pública'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Simposio de Recursos Humanos (Activos + Inactivo: Cañón de burbujas)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza entrada'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza de auditorio'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza baños'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Recursos Humanos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Cañón de burbujas'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Congreso de Administración Estratégica (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Administración Estratégica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Foro de Emprendimiento (Activos + Inactivo: Cañón de confeti)
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Boletín algo más (reportero)'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Emprendimiento'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Cañón de confeti'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Presentación de libro: Administración Moderna (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Administración Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Otros'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Taller de Planeación (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Planeación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Contaduría
    -- Taller de Auditoría Financiera (Activos + Inactivo: Pantalla verde)
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Auditoría Financiera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla verde'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Conferencia de Normas Contables (Activos + Inactivo: Telón rojo)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Normas Contables'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Telón rojo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Conversatorio: Ética en la Contaduría (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Ética en la Contaduría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Charla sobre Impuestos (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Impuestos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Seminario de Contabilidad Internacional (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Contabilidad Internacional'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Simposio de Auditoría (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza entrada'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza baños'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Auditoría'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza vestidores'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Congreso de Contabilidad Gubernamental (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Contabilidad Gubernamental'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Boletín algo más (reportero)'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Foro de Fiscalización (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Fiscalización'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Presentación de libro: Contaduría Actual (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Contaduría Actual'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Otros'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Seminario de Costos (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Costos'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Negocios Internacionales
    -- Taller de Comercio Exterior (Activos + Inactivo: Cañón de burbujas ya usado; usar Cañón de humo ya usado; ahora usar Lámpara de mesa ya usada; usar Pantalla verde ya usada; aquí usar Cañón de luz? ya usado. Usar ninguno inactivo en este)
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Paño azul'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Mesa adicional'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Comercio Exterior'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Personalizadores'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Conferencia de Negocios Globales (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Negocios Globales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Conversatorio: Oportunidades Internacionales (Activos + Inactivo: Pantalla verde ya usado; usar Telón rojo ya usado; aquí usar Lámpara de pie ya usada; usar Atril ya usado; usar Cañón de confeti? ya usado. Usamos ninguno inactivo.)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Oportunidades Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Charla sobre Exportaciones (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Exportaciones'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Semana Académica de NI (Activos + Inactivo: Cañón de humo ya usado; aquí usar Cañón de luz? ya usado; usemos Lámpara de mesa? ya; usemos Atril? ya; aquí Pantalla verde? ya. Tomamos 'Telón rojo' extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Semana Académica de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Telón rojo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Simposio de Negocios Digitales (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza entrada'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza de auditorio'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Negocios Digitales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza vestidores'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Congreso de Negocios Internacionales (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Foro de Inversión Extranjera (Activos + Inactivo: Cañón de confeti ya usado; aquí 'Atril' extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Boletín algo más (reportero)'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Inversión Extranjera'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Atril'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Presentación de libro: Negocios Internacionales (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Negocios Internacionales'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Otros'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Congreso de Comercio (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Comercio'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Informática
    -- Taller de Ciberseguridad (Activos + Inactivo: Cañón de humo ya usado; aquí usar Cañón de luz ya usado; usemos Lámpara de mesa ya usada; usemos Pantalla verde ya usada; aquí ninguno)
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Paño azul'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Mesa adicional'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Taller de Ciberseguridad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Personalizadores'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Conferencia de Inteligencia Artificial (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conferencia de Inteligencia Artificial'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Conversatorio: Tecnología y Sociedad (Activos + Inactivo: Cañón de confeti ya; aquí usar Cañón de humo? ya; usemos Telón rojo ya; aquí 'Pantalla verde' extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Conversatorio: Tecnología y Sociedad'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla verde'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Charla sobre Programación (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Charla sobre Programación'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Seminario de Big Data (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Seminario de Big Data'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Simposio de Innovación Tecnológica (Activos + Inactivo: Lámpara de mesa extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza entrada'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza de auditorio'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Limpieza vestidores'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Innovación Tecnológica'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Centro de Informática (CIFCA)'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Lámpara de mesa'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Congreso de Informática Educativa (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Vigilancia'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Congreso de Informática Educativa'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Alfonso Ochoa Ravizé'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Foro de Tecnología (Activos + Inactivo: Cañón de luz extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Laptop'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Zoom'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Boletín algo más (reportero)'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Foro de Tecnología'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio Mtro. Carlos Pérez del Toro'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Cañón de luz'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Presentación de libro: Informática Moderna (Activos)
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Presidium'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Fotógrafo'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Presentación de libro: Informática Moderna'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Aula Magna de Profesores Eméritos'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Otros'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES

    -- Simposio de Software Libre (Activos + Inactivo: Telón rojo extra)
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Pantalla'), 2);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Videoproyector'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Equipo de sonido'), 1);
INSERT INTO public.reservacionxequipamiento (id_evento,id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_evento FROM public.evento WHERE nombre='Simposio de Software Libre'),
    (SELECT id_recinto FROM public.recinto WHERE nombre='Auditorio C.P. Tomás López Sánchez'),
    (SELECT id_equipamiento FROM public.equipamiento WHERE nombre='Telón rojo'), 1);


-- area_inventario
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    -- actos
    ((SELECT id_area FROM public.area WHERE nombre = 'Actos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Paño azul'), 5);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Actos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Mesa adicional'), 3);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Actos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Personalizadores'), 10);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES

    -- centro de informática
    ((SELECT id_area FROM public.area WHERE nombre = 'Centro de Informática'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Laptop'), 10);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Centro de Informática'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Zoom'), 5);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES

    -- medios audiovisuales
    ((SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 2);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 2);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Medios Audiovisuales'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 2);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES

    -- publicaciones y fomento editorial
    ((SELECT id_area FROM public.area WHERE nombre = 'Publicaciones y Fomento Editorial'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Fotógrafo'), 2);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Publicaciones y Fomento Editorial'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Boletín algo más (reportero)'), 2);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES

    -- secretaria administrativa
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Vigilancia'), 5);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Presidium'), 2);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Otros'), 10);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Limpieza entrada'), 5);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Limpieza de auditorio'), 5);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Limpieza baños'), 5);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Limpieza vestidores'), 5);
INSERT INTO public.area_inventario (id_area,id_equipamiento,cantidad)
VALUES
    ((SELECT id_area FROM public.area WHERE nombre = 'Secretaría Administrativa'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Abrir auditorio'), 5);


-- recinto_inventario
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    -- Auditorio Mtro. Carlos Pérez del Toro
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Fotógrafo'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES

    -- Aula Magna de Profesores Eméritos
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES

    -- Auditorio C.P. Tomás López Sánchez
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES

    -- Centro de Informática (CIFCA)
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Laptop'), 5);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Zoom'), 2);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES

    -- Auditorio C.P. Alfonso Ochoa Ravizé
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES

    -- Centro de Idiomas (CEDI)
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES

    -- Aula Magna de Investigación
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES

    -- Auditorio C.P. Arturo Elizundia Charles
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Equipo de sonido'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Pantalla'), 1);
INSERT INTO public.recinto_inventario (id_recinto,id_equipamiento,cantidad)
VALUES
    ((SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'),
        (SELECT id_equipamiento FROM public.equipamiento WHERE nombre = 'Videoproyector'), 1);



-- fotografia
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_mtro_carlos_perez_del_toro_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_mtro_carlos_perez_del_toro_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_mtro_carlos_perez_del_toro_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_mtro_carlos_perez_del_toro_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio Mtro. Carlos Pérez del Toro'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES

    ('/recintos/aula_magna_de_profesores_emeritos_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/aula_magna_de_profesores_emeritos_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/aula_magna_de_profesores_emeritos_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/aula_magna_de_profesores_emeritos_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Profesores Eméritos'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES

    ('/recintos/auditorio_cp_tomas_lopez_sanchez_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_cp_tomas_lopez_sanchez_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_cp_tomas_lopez_sanchez_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_cp_tomas_lopez_sanchez_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Tomás López Sánchez'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES

    ('/recintos/centro_de_informatica_cifca_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/centro_de_informatica_cifca_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/centro_de_informatica_cifca_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/centro_de_informatica_cifca_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Informática (CIFCA)'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES

    ('/recintos/auditorio_cp_alfonso_ochoa_ravize_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_cp_alfonso_ochoa_ravize_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_cp_alfonso_ochoa_ravize_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_cp_alfonso_ochoa_ravize_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Alfonso Ochoa Ravizé'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES

    ('/recintos/centro_de_idiomas_cedi_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/centro_de_idiomas_cedi_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/centro_de_idiomas_cedi_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/centro_de_idiomas_cedi_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Centro de Idiomas (CEDI)'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES

    ('/recintos/aula_magna_de_investigacion_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/aula_magna_de_investigacion_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/aula_magna_de_investigacion_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/aula_magna_de_investigacion_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Aula Magna de Investigación'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES

    ('/recintos/auditorio_cp_arturo_elizundia_charles_1.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_cp_arturo_elizundia_charles_2.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_cp_arturo_elizundia_charles_3.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'));
INSERT INTO public.fotografia (fotografia,id_recinto)
VALUES
    ('/recintos/auditorio_cp_arturo_elizundia_charles_4.png',(SELECT id_recinto FROM public.recinto WHERE nombre = 'Auditorio C.P. Arturo Elizundia Charles'));

COMMIT;