# Diccionario de datos
# area

Registra los tipos de area a las que puede pertenecer un usuario

## Atributos

| Columna             | Tipo                   | Descripción                                        | Restricciones |
| ------------------- | ---------------------- | -------------------------------------------------- | ------------- |
| activo              | boolean                | Indica si el area esta activa o no                 | N/A           |
| id_area             | smallint               | Identificador del area al que pertenece el usuario | N/A           |
| id_responsable_area | smallint               | Responsable del area                               | N/A           |
| nombre              | character varying(150) | Nombre del area                                    | N/A           |

## Restricciones

| Nombre restricción      | Tipo        | Descripción                                             |
| ----------------------- | ----------- | ------------------------------------------------------- |
| ck_area_nombre_no_vacio | CHECK       | Se asegura de que el valor del nombre no esté vacío     |
| fk_responsable_area     | FOREIGN KEY | Sin descripción                                         |
| pk_area                 | PRIMARY KEY | Sin descripción                                         |
| uq_area_nombre          | UNIQUE      | Se asegura de que no haya dos areas con el mismo nombre |

# auditoria

Registra las acciones de inserción, actualización y eliminación realizadas en las tablas del sistema para fines de auditoría y seguimiento

## Atributos

| Columna              | Tipo                        | Descripción                                            | Restricciones |
| -------------------- | --------------------------- | ------------------------------------------------------ | ------------- |
| accion               | character varying(50)       | Tipo de acción realizada (INSERT, UPDATE, DELETE)      | N/A           |
| campo_modificado     | character varying(50)       | Nombre del campo que fue modificado (solo para UPDATE) | N/A           |
| fecha_hora           | timestamp without time zone | Fecha y hora en que se realizó la acción               | N/A           |
| id_auditoria         | bigint                      | Identificador único de la entrada de auditoría         | N/A           |
| id_puesto            | smallint                    | Sin descripción                                        | N/A           |
| id_registro_afectado | integer                     | Identificador del registro afectado por la acción      | N/A           |
| id_usuario           | smallint                    | Usuario que realizó la acción                          | N/A           |
| nombre_tabla         | character varying(50)       | Nombre de la tabla donde se realizó la acción          | N/A           |
| valor_anterior       | text                        | Valor anterior del campo modificado (solo para UPDATE) | N/A           |
| valor_nuevo          | text                        | Nuevo valor del campo modificado (solo para UPDATE)    | N/A           |

## Restricciones

| Nombre restricción         | Tipo        | Descripción                                                                                               |
| -------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| ck_auditoria_accion        | CHECK       | Se asegura de que la acción sea una de las permitidas: INSERT, UPDATE, DELETE                             |
| ck_auditoria_update_campos | CHECK       | Se asegura de que los campos relacionados con la actualización solo se llenen cuando la acción sea UPDATE |
| fk_puesto                  | FOREIGN KEY | Sin descripción                                                                                           |
| fk_usuario                 | FOREIGN KEY | Sin descripción                                                                                           |
| pk_auditoria               | PRIMARY KEY | Sin descripción                                                                                           |

# calendario_escolar

Registra el calendario escolar que regira a los eventos

## Atributos

| Columna               | Tipo                  | Descripción                          | Restricciones |
| --------------------- | --------------------- | ------------------------------------ | ------------- |
| id_calendario_escolar | smallint              | Identificador del calendario escolar | N/A           |
| semestre              | character varying(50) | Nombre del semestre escolar          | N/A           |
| semestre_fin          | date                  | Fecha de fin del semestre escolar    | N/A           |
| semestre_inicio       | date                  | Fecha de inicio del semestre escolar | N/A           |

## Restricciones

| Nombre restricción                      | Tipo        | Descripción                                                                                   |
| --------------------------------------- | ----------- | --------------------------------------------------------------------------------------------- |
| ck_calendario_escolar_rango_fechas      | CHECK       | Se asegura de que la fecha de inicio del semestre sea inferior a la fecha de fin del semestre |
| ck_calendario_escolar_semestre_no_vacio | CHECK       | Se asegura de que el valor del semestre no esté vacío                                         |
| pk_calendario_escolar                   | PRIMARY KEY | Sin descripción                                                                               |
| uq_calendario_escolar_semestre          | UNIQUE      | Se asegura de que no haya dos calendarios escolares con el mismo semestre                     |

# categoria

Registra las categorias en las que se puede clasificar un evento

## Atributos

| Columna      | Tipo                  | Descripción                                                           | Restricciones |
| ------------ | --------------------- | --------------------------------------------------------------------- | ------------- |
| id_categoria | smallint              | Identificador de la categoria en la que se puede clasificar el evento | N/A           |
| nombre       | character varying(50) | Nombre de la categoria                                                | N/A           |

## Restricciones

| Nombre restricción           | Tipo        | Descripción                                                  |
| ---------------------------- | ----------- | ------------------------------------------------------------ |
| ck_categoria_nombre_no_vacio | CHECK       | Se asegura de que el valor del nombre no esté vacío          |
| pk_categoria                 | PRIMARY KEY | Sin descripción                                              |
| uq_categoria_nombre          | UNIQUE      | Se asegura de que no haya dos categorias con el mismo nombre |

# empresa

Catálogo de empresas

## Atributos

| Columna    | Tipo                  | Descripción                      | Restricciones |
| ---------- | --------------------- | -------------------------------- | ------------- |
| id_empresa | smallint              | Identificador de la empresa      | N/A           |
| id_pais    | smallint              | País al que pertenece la empresa | N/A           |
| nombre     | character varying(50) | Nombre de la empresa             | N/A           |

## Restricciones

| Nombre restricción         | Tipo        | Descripción                                                |
| -------------------------- | ----------- | ---------------------------------------------------------- |
| ck_empresa_nombre_no_vacio | CHECK       | Se asegura de que el valor del nombre no esté vacío        |
| fk_empresa_pais            | FOREIGN KEY | Sin descripción                                            |
| pk_empresa                 | PRIMARY KEY | Sin descripción                                            |
| uq_empresa_nombre          | UNIQUE      | Se asegura de que no haya dos empresas con el mismo nombre |

# equipamiento

Equipamiento solicitado o con el que cuenta la facultad para atender un evento

## Atributos

| Columna         | Tipo                   | Descripción                                                    | Restricciones |
| --------------- | ---------------------- | -------------------------------------------------------------- | ------------- |
| existencia      | boolean                | Indica si el equipamiento se encuentra esta en existencia o no | N/A           |
| foto            | character varying(512) | Ruta del archivo que almacena la foto del equipamiento         | N/A           |
| id_equipamiento | smallint               | Identificador del equipamiento                                 | N/A           |
| nombre          | character varying(100) | Nombre del equipamiento                                        | N/A           |

## Restricciones

| Nombre restricción              | Tipo        | Descripción                                                     |
| ------------------------------- | ----------- | --------------------------------------------------------------- |
| ck_equipamiento_foto_no_vacio   | CHECK       | Se asegura de que el valor de la foto no esté vacío             |
| ck_equipamiento_nombre_no_vacio | CHECK       | Se asegura de que el valor del nombre no esté vacío             |
| pk_equipamiento                 | PRIMARY KEY | Sin descripción                                                 |
| uq_equipamiento_nombre          | UNIQUE      | Se asegura de que no haya dos equipamientos con el mismo nombre |

# evento

Registra los eventos academicos organizados en la facultad

## Atributos

| Columna               | Tipo                        | Descripción                                                                                      | Restricciones |
| --------------------- | --------------------------- | ------------------------------------------------------------------------------------------------ | ------------- |
| descripcion           | character varying(500)      | Descripción del evento                                                                           | N/A           |
| estatus               | character varying(50)       | Estatus del evento (pendiente, autorizado, realizado, cancelado)                                 | N/A           |
| fecha_fin             | date                        | Fecha de fin del evento                                                                          | N/A           |
| fecha_inicio          | date                        | Fecha de inicio del evento                                                                       | N/A           |
| fecha_registro        | timestamp without time zone | Fecha y hora en la que se registró el evento en el sistema                                       | N/A           |
| horario_fin           | time without time zone      | Hora de fin del evento                                                                           | N/A           |
| horario_inicio        | time without time zone      | Hora de inicio del evento                                                                        | N/A           |
| id_calendario_escolar | smallint                    | Calendario escolar al que pertenece el evento                                                    | N/A           |
| id_categoria          | smallint                    | Categoria en la que se clasifica el evento                                                       | N/A           |
| id_evento             | integer                     | Identificador del evento                                                                         | N/A           |
| id_mega_evento        | integer                     | Mega evento al que pertenece el evento. Sirve para casos en donde un evento agrupa otros eventos | N/A           |
| mega_evento           | boolean                     | Indica si el evento es un mega evento (que agrupa otros eventos)                                 | N/A           |
| motivo                | character varying(500)      | Motivo de rechazo de la solicitud de evento                                                      | N/A           |
| nombre                | character varying(100)      | Nombre del evento                                                                                | N/A           |
| online                | boolean                     | Indica si el evento es de modalidad online                                                       | N/A           |
| presencial            | boolean                     | Indica si el evento es de modalidad presencial                                                   | N/A           |

## Restricciones

| Nombre restricción             | Tipo        | Descripción                                                                              |
| ------------------------------ | ----------- | ---------------------------------------------------------------------------------------- |
| ck_evento_descripcion_no_vacio | CHECK       | Se asegura de que el valor de la descripción no esté vacío                               |
| ck_evento_duracion             | CHECK       | Se asegura de que el evento tenga una duración mínima de 30 minutos si es en un solo día |
| ck_evento_estatus              | CHECK       | Valida que solo se registren los estatus pendiente, autorizado, realizado y cancelado    |
| ck_evento_horario_laboral      | CHECK       | Se asegura de que el evento se realice dentro del horario laboral (07:00 a 22:00)        |
| ck_evento_modalidad            | CHECK       | Se asegura de que al menos una modalidad (presencial u online) sea verdadera             |
| ck_evento_motivo_no_vacio      | CHECK       | Se asegura de que el valor del motivo no esté vacío                                      |
| ck_evento_nombre_no_vacio      | CHECK       | Se asegura de que el valor del nombre no esté vacío                                      |
| ck_evento_rango_fechas         | CHECK       | Se asegura de que la fecha de inicio no sea posterior a la fecha de fin                  |
| ck_evento_rango_horarios       | CHECK       | Se asegura de que la hora de inicio sea anterior a la hora de fin                        |
| fk_calendario_escolar          | FOREIGN KEY | Sin descripción                                                                          |
| fk_categoria                   | FOREIGN KEY | Sin descripción                                                                          |
| fk_mega_evento                 | FOREIGN KEY | Sin descripción                                                                          |
| pk_evento                      | PRIMARY KEY | Sin descripción                                                                          |
| uq_evento_nombre               | UNIQUE      | Se asegura de que no haya dos eventos con el mismo nombre                                |

# evento_organizador

Registra todos los eventos organizados por el usuario

## Atributos

| Columna         | Tipo     | Descripción                                                              | Restricciones |
| --------------- | -------- | ------------------------------------------------------------------------ | ------------- |
| id_evento       | integer  | Identificador del evento en el que participa como organizador el usuario | N/A           |
| id_usuario      | smallint | Identificador del usuario que participa en la organización del evento    | N/A           |
| numero_registro | integer  | Indica el numero de registro                                             | N/A           |

## Restricciones

| Nombre restricción                    | Tipo        | Descripción                                        |
| ------------------------------------- | ----------- | -------------------------------------------------- |
| fk_evento                             | FOREIGN KEY | Sin descripción                                    |
| fk_usuario                            | FOREIGN KEY | Sin descripción                                    |
| pk_evento_organizador                 | PRIMARY KEY | Sin descripción                                    |
| uq_evento_organizador_numero_registro | UNIQUE      | Se asegura de que no repetir el numero de registro |

# eventoxequipamiento

Registra el equipamiento solicitado en cada una de las reservaciones

## Atributos

| Columna         | Tipo     | Descripción                                         | Restricciones |
| --------------- | -------- | --------------------------------------------------- | ------------- |
| cantidad        | smallint | Cantidad del equipamiento solicitado para el evento | N/A           |
| id_equipamiento | smallint | Equipamiento que se solicita para el evento         | N/A           |
| id_evento       | integer  | Evento en el que se solicita el equipamiento        | N/A           |

## Restricciones

| Nombre restricción              | Tipo        | Descripción                                                                         |
| ------------------------------- | ----------- | ----------------------------------------------------------------------------------- |
| ck_eventoxequipamiento_cantidad | CHECK       | Se asegura de que la cantidad solicitada sea un valor positivo mayor o igual a cero |
| fk_equipamiento                 | FOREIGN KEY | Sin descripción                                                                     |
| fk_evento                       | FOREIGN KEY | Sin descripción                                                                     |
| pk_evento_x_equipamiento        | PRIMARY KEY | Sin descripción                                                                     |

# experiencia

Registra las experiencias laborales de los ponentes

## Atributos

| Columna        | Tipo                  | Descripción                                           | Restricciones |
| -------------- | --------------------- | ----------------------------------------------------- | ------------- |
| fecha_fin      | date                  | Fecha de fin de la experiencia laboral                | N/A           |
| fecha_inicio   | date                  | Fecha de inicio de la experiencia laboral             | N/A           |
| id_empresa     | smallint              | Empresa en la que se desempeñó la experiencia laboral | N/A           |
| id_experiencia | integer               | Identificador de la experiencia laboral               | N/A           |
| puesto         | character varying(50) | Puesto desempeñado en la experiencia laboral          | N/A           |
| puesto_actual  | boolean               | Indica si el puesto es el actual del ponente          | N/A           |

## Restricciones

| Nombre restricción                | Tipo        | Descripción                                                          |
| --------------------------------- | ----------- | -------------------------------------------------------------------- |
| ck_experiencia_anio_fin_valido    | CHECK       | Se asegura de que la fecha de fin esté entre los años 1900 y 2100    |
| ck_experiencia_anio_inicio_valido | CHECK       | Se asegura de que la fecha de inicio esté entre los años 1900 y 2100 |
| ck_experiencia_puesto_no_vacio    | CHECK       | Se asegura de que el valor del puesto no esté vacío                  |
| ck_experiencia_rango_fechas       | CHECK       | Se asegura de que la fecha de inicio sea anterior a la fecha de fin  |
| fk_empresa                        | FOREIGN KEY | Sin descripción                                                      |
| pk_experiencia                    | PRIMARY KEY | Sin descripción                                                      |
| uq_experiencia                    | UNIQUE      | Se asegura de que no haya dos experiencias laborales iguales         |

# flyway_schema_history

Sin descripción.

## Atributos

| Columna        | Tipo                        | Descripción     | Restricciones |
| -------------- | --------------------------- | --------------- | ------------- |
| checksum       | integer                     | Sin descripción | N/A           |
| description    | character varying(200)      | Sin descripción | N/A           |
| execution_time | integer                     | Sin descripción | N/A           |
| installed_by   | character varying(100)      | Sin descripción | N/A           |
| installed_on   | timestamp without time zone | Sin descripción | N/A           |
| installed_rank | integer                     | Sin descripción | N/A           |
| script         | character varying(1000)     | Sin descripción | N/A           |
| success        | boolean                     | Sin descripción | N/A           |
| type           | character varying(20)       | Sin descripción | N/A           |
| version        | character varying(50)       | Sin descripción | N/A           |

## Restricciones

| Nombre restricción       | Tipo        | Descripción     |
| ------------------------ | ----------- | --------------- |
| flyway_schema_history_pk | PRIMARY KEY | Sin descripción |

# fotografia

Registra las rutas donde estan almacenadas las fotografias de cada recinto

## Atributos

| Columna       | Tipo                   | Descripción                                             | Restricciones |
| ------------- | ---------------------- | ------------------------------------------------------- | ------------- |
| fotografia    | character varying(512) | Ruta del archivo que almacena la fotografia del recinto | N/A           |
| id_fotografia | smallint               | Identificador de la fotografia del recinto              | N/A           |
| id_recinto    | smallint               | Recinto al que pertenece la fotografia                  | N/A           |

## Restricciones

| Nombre restricción                | Tipo        | Descripción                                                  |
| --------------------------------- | ----------- | ------------------------------------------------------------ |
| ck_fotografia_fotografia_no_vacio | CHECK       | Se asegura de que el valor de la fotografia no esté vacío    |
| fk_recinto                        | FOREIGN KEY | Sin descripción                                              |
| pk_fotografia                     | PRIMARY KEY | Sin descripción                                              |
| uq_fotografia_recinto_fotografia  | UNIQUE      | Se asegura de que un recinto no tenga las mismas fotografias |

# grado

Describe los tipos de grado que pueden tener los ponentes al participar en los eventos

## Atributos

| Columna        | Tipo                   | Descripción                                   | Restricciones |
| -------------- | ---------------------- | --------------------------------------------- | ------------- |
| anio           | smallint               | Año en el que se emitió el grado academico    | N/A           |
| id_grado       | integer                | Identificador del grado academico del ponente | N/A           |
| id_institucion | smallint               | Institución que emitió el grado academico     | N/A           |
| id_nivel       | smallint               | Nivel del grado academico                     | N/A           |
| id_pais        | smallint               | Pais en el que se emitió el grado academico   | N/A           |
| titulo         | character varying(100) | Titulo del grado academico                    | N/A           |

## Restricciones

| Nombre restricción        | Tipo        | Descripción                                              |
| ------------------------- | ----------- | -------------------------------------------------------- |
| ck_grado_anio_valido      | CHECK       | Se asegura de que el año del grado sea válido            |
| ck_grado_titulo_no_vacio  | CHECK       | Se asegura de que el valor del titulo no esté vacío      |
| fk_institucion            | FOREIGN KEY | Sin descripción                                          |
| fk_nivel                  | FOREIGN KEY | Sin descripción                                          |
| fk_pais                   | FOREIGN KEY | Sin descripción                                          |
| pk_grado                  | PRIMARY KEY | Sin descripción                                          |
| uq_grado_titulo_academico | UNIQUE      | Se asegura de que no haya dos titulos academicos iguales |

# institucion

Catálogo de instituciones academicas

## Atributos

| Columna        | Tipo                   | Descripción                                   | Restricciones |
| -------------- | ---------------------- | --------------------------------------------- | ------------- |
| id_institucion | smallint               | Identificador de la institución academica     | N/A           |
| nombre         | character varying(100) | Nombre de la institución academica            | N/A           |
| siglas         | character varying(20)  | Siglas del nombre de la institución academica | N/A           |

## Restricciones

| Nombre restricción             | Tipo        | Descripción                                                     |
| ------------------------------ | ----------- | --------------------------------------------------------------- |
| ck_institucion_nombre_no_vacio | CHECK       | Se asegura de que el valor del nombre no esté vacío             |
| ck_institucion_siglas_no_vacio | CHECK       | Se asegura de que el valor de las siglas no esté vacío          |
| pk_institucion                 | PRIMARY KEY | Sin descripción                                                 |
| uq_institucion_nombre          | UNIQUE      | Se asegura de que no haya dos instituciones con el mismo nombre |

# inventario_area

Registra la cantidad de equipamiento disponible en cada recinto

## Atributos

| Columna             | Tipo                        | Descripción                                          | Restricciones |
| ------------------- | --------------------------- | ---------------------------------------------------- | ------------- |
| activo              | boolean                     | Indica si el registro de inventario está activo o no | N/A           |
| cantidad            | smallint                    | Cantidad de equipamiento disponible en el área       | N/A           |
| id_area             | smallint                    | Area donde se encuentra el equipamiento              | N/A           |
| id_equipamiento     | smallint                    | Equipamiento que se encuentra en el área             | N/A           |
| numero_registro     | integer                     | Indica el numero de registro                         | N/A           |
| ultima_modificacion | timestamp without time zone | Indica la ultima modificacion del inventario         | N/A           |

## Restricciones

| Nombre restricción                 | Tipo        | Descripción                                                              |
| ---------------------------------- | ----------- | ------------------------------------------------------------------------ |
| ck_inventario_area_cantidad        | CHECK       | Se asegura de que la cantidad sea un valor positivo mayor o igual a cero |
| fk_area                            | FOREIGN KEY | Sin descripción                                                          |
| fk_equipamiento                    | FOREIGN KEY | Sin descripción                                                          |
| pk_inventario_area                 | PRIMARY KEY | Sin descripción                                                          |
| uq_inventario_area_numero_registro | UNIQUE      | Se asegura de que solo exista un numero de registro                      |

# inventario_recinto

Registra la cantidad de equipamiento disponible en cada recinto

## Atributos

| Columna             | Tipo                        | Descripción                                          | Restricciones |
| ------------------- | --------------------------- | ---------------------------------------------------- | ------------- |
| activo              | boolean                     | Indica si el registro de inventario está activo o no | N/A           |
| cantidad            | smallint                    | Cantidad de equipamiento disponible en el recinto    | N/A           |
| id_equipamiento     | smallint                    | Equipamiento que se encuentra en el recinto          | N/A           |
| id_recinto          | smallint                    | Recinto donde se encuentra el equipamiento           | N/A           |
| numero_registro     | integer                     | Indica el numero de registro                         | N/A           |
| ultima_modificacion | timestamp without time zone | Indica la ultima modificacion del inventario         | N/A           |

## Restricciones

| Nombre restricción                    | Tipo        | Descripción                                                              |
| ------------------------------------- | ----------- | ------------------------------------------------------------------------ |
| ck_inventario_recinto_cantidad        | CHECK       | Se asegura de que la cantidad sea un valor positivo mayor o igual a cero |
| fk_equipamiento                       | FOREIGN KEY | Sin descripción                                                          |
| fk_recinto                            | FOREIGN KEY | Sin descripción                                                          |
| pk_inventario_recinto                 | PRIMARY KEY | Sin descripción                                                          |
| uq_inventario_recinto_numero_registro | UNIQUE      | Se asegura de que solo exista un numero de registro                      |

# nivel

Nivel de educación de un grado academico, por ejemplo: doctorado, maestría, etc.

## Atributos

| Columna   | Tipo                  | Descripción                                                                               | Restricciones |
| --------- | --------------------- | ----------------------------------------------------------------------------------------- | ------------- |
| id_nivel  | smallint              | Identificador del nivel de un grado academico                                             | N/A           |
| jerarquia | smallint              | Jerarquía del nivel de un grado academico, entre mayor sea el valor mayor es la jerarquía | N/A           |
| nombre    | character varying(50) | Nombre del nivel de un grado academico                                                    | N/A           |
| siglas    | character varying(20) | Siglas del nivel de un grado academico                                                    | N/A           |

## Restricciones

| Nombre restricción       | Tipo        | Descripción                                                 |
| ------------------------ | ----------- | ----------------------------------------------------------- |
| ck_nivel_jerarquia       | CHECK       | Se asegura de que la jerarquía sea mayor a 0                |
| ck_nivel_nombre_no_vacio | CHECK       | Se asegura de que el valor del nombre no esté vacío         |
| ck_nivel_siglas_no_vacio | CHECK       | Se asegura de que el valor de las siglas no esté vacío      |
| pk_nivel                 | PRIMARY KEY | Sin descripción                                             |
| uq_nivel_nombre          | UNIQUE      | Se asegura de que no haya dos niveles con el mismo nombre   |
| uq_nivel_siglas          | UNIQUE      | Se asegura de que no haya dos niveles con las mismas siglas |

# pais

Catálogo de paises

## Atributos

| Columna | Tipo                   | Descripción            | Restricciones |
| ------- | ---------------------- | ---------------------- | ------------- |
| id_pais | smallint               | Identificador del país | N/A           |
| nombre  | character varying(100) | Nombre del país        | N/A           |

## Restricciones

| Nombre restricción      | Tipo        | Descripción                                              |
| ----------------------- | ----------- | -------------------------------------------------------- |
| ck_pais_nombre_no_vacio | CHECK       | Se asegura de que el valor del nombre no esté vacío      |
| pk_pais                 | PRIMARY KEY | Sin descripción                                          |
| uq_pais_nombre          | UNIQUE      | Se asegura de que no haya dos paises con el mismo nombre |

# participacion

Registra las participaciones que tienen los ponentes en cada uno de los eventos

## Atributos

| Columna         | Tipo                   | Descripción                                                           | Restricciones |
| --------------- | ---------------------- | --------------------------------------------------------------------- | ------------- |
| id_evento       | integer                | Evento en el que partipa el ponente                                   | N/A           |
| id_ponente      | integer                | ponente que participa en el evento                                    | N/A           |
| numero_registro | integer                | Indica el numero de registro                                          | N/A           |
| reconocimiento  | character varying(512) | Archivo que registra el reconocimiento de participacion de un ponente | N/A           |

## Restricciones

| Nombre restricción                       | Tipo        | Descripción                                                 |
| ---------------------------------------- | ----------- | ----------------------------------------------------------- |
| ck_participacion_reconocimiento_no_vacio | CHECK       | Se asegura de que el valor del reconocimiento no esté vacío |
| fk_evento                                | FOREIGN KEY | Sin descripción                                             |
| fk_ponente                               | FOREIGN KEY | Sin descripción                                             |
| pk_participacion                         | PRIMARY KEY | Sin descripción                                             |
| uq_participacion_numero_registro         | UNIQUE      | Se asegura de no repetir el numero de registro              |
| uq_participacion_reconocimiento          | UNIQUE      | Se asegura de no repetir el reconocimiento                  |

# periodo

Registra los periodos académicos del calendario escolar

## Atributos

| Columna               | Tipo     | Descripción                                    | Restricciones |
| --------------------- | -------- | ---------------------------------------------- | ------------- |
| fecha_fin             | date     | Fecha de fin del periodo academico             | N/A           |
| fecha_inicio          | date     | Fecha de inicio del periodo academico          | N/A           |
| id_calendario_escolar | smallint | Calendario escolar al que pertenece el periodo | N/A           |
| id_periodo            | smallint | Identificador del periodo academico            | N/A           |
| id_tipo_periodo       | smallint | Tipo de periodo academico                      | N/A           |

## Restricciones

| Nombre restricción    | Tipo        | Descripción                                                                               |
| --------------------- | ----------- | ----------------------------------------------------------------------------------------- |
| ck_rango_fechas       | CHECK       | Se asegura de que la fecha de inicio sea anterior a la fecha de fin del periodo academico |
| fk_calendario_escolar | FOREIGN KEY | Sin descripción                                                                           |
| fk_tipo_periodo       | FOREIGN KEY | Sin descripción                                                                           |
| pk_periodo            | PRIMARY KEY | Sin descripción                                                                           |

# permiso

Registra los tipos de permisos que puede tener un rol

## Atributos

| Columna     | Tipo                   | Descripción                                                                                  | Restricciones |
| ----------- | ---------------------- | -------------------------------------------------------------------------------------------- | ------------- |
| accion      | character varying(50)  | Acción que se permite realizar sobre el recurso (por ejemplo: crear, leer, editar, eliminar) | N/A           |
| alcance     | character varying(50)  | Alcance del permiso (por ejemplo: global, propietario)                                       | N/A           |
| descripcion | character varying(255) | Descripción de la función que otorga al usuario el permiso                                   | N/A           |
| id_permiso  | smallint               | Identificador del permiso                                                                    | N/A           |
| recurso     | character varying(50)  | Recurso al que se le asigna el permiso (por ejemplo: usuario, evento, reservacion, etc.)     | N/A           |

## Restricciones

| Nombre restricción              | Tipo        | Descripción                                                                           |
| ------------------------------- | ----------- | ------------------------------------------------------------------------------------- |
| ck_permiso_accion_no_vacio      | CHECK       | Se asegura de que el valor de acción no esté vacío                                    |
| ck_permiso_alcance              | CHECK       | Se asegura de que el alcance sea uno de los permitidos                                |
| ck_permiso_alcance_no_vacio     | CHECK       | Se asegura de que el valor de alcance no esté vacío                                   |
| ck_permiso_descripcion_no_vacio | CHECK       | Se asegura de que el valor de descripción no esté vacío                               |
| ck_permiso_recurso_no_vacio     | CHECK       | Se asegura de que el valor de recurso no esté vacío                                   |
| pk_permiso                      | PRIMARY KEY | Sin descripción                                                                       |
| uq_permiso                      | UNIQUE      | Se asegura de que no haya permisos duplicados para un mismo recurso, acción y alcance |

# ponente

Registra a los ponentes que participan en los eventos

## Atributos

| Columna          | Tipo                   | Descripción                                                   | Restricciones |
| ---------------- | ---------------------- | ------------------------------------------------------------- | ------------- |
| apellido_materno | character varying(50)  | Apellido materno del ponente                                  | N/A           |
| apellido_paterno | character varying(50)  | Apellido paterno del ponente                                  | N/A           |
| correo           | character varying(100) | Correo para contacto del ponente                              | N/A           |
| id_pais          | smallint               | País de origen del ponente                                    | N/A           |
| id_ponente       | integer                | Identificador del ponente que participa en al menos un evento | N/A           |
| nombre           | character varying(50)  | Nombre del ponente                                            | N/A           |

## Restricciones

| Nombre restricción                   | Tipo        | Descripción                                                                             |
| ------------------------------------ | ----------- | --------------------------------------------------------------------------------------- |
| ck_ponente_apellido_materno_no_vacio | CHECK       | Se asegura de que el valor del apellido materno no esté vacío                           |
| ck_ponente_apellido_paterno_no_vacio | CHECK       | Se asegura de que el valor del apellido paterno no esté vacío                           |
| ck_ponente_correo                    | CHECK       | Se asegura de que el correo tenga un formato válido                                     |
| ck_ponente_correo_no_vacio           | CHECK       | Se asegura de que el valor de correo no esté vacío                                      |
| ck_ponente_nombre_no_vacio           | CHECK       | Se asegura de que el valor del nombre no esté vacío                                     |
| fk_ponente_pais                      | FOREIGN KEY | Sin descripción                                                                         |
| pk_ponente                           | PRIMARY KEY | Sin descripción                                                                         |
| uq_ponente_correo                    | UNIQUE      | Se asegura de que no haya dos correos iguales                                           |
| uq_ponente_nombre_completo           | UNIQUE      | Se asegura de que no haya dos registros de una misma persona en el catálogo de personas |

# puesto

Registra los puestos que puede tener un usuario

## Atributos

| Columna   | Tipo                   | Descripción                                                  | Restricciones |
| --------- | ---------------------- | ------------------------------------------------------------ | ------------- |
| activo    | boolean                | Indica si el puesto esta activo o no                         | N/A           |
| id_area   | smallint               | Area al que pertenece el puesto                              | N/A           |
| id_jefe   | smallint               | Jefe del puesto                                              | N/A           |
| id_puesto | smallint               | Identificador del puesto en la facultad que ocupa el usuario | N/A           |
| nombre    | character varying(100) | Nombre del puesto                                            | N/A           |
| unico     | boolean                | Sin descripción                                              | N/A           |

## Restricciones

| Nombre restricción         | Tipo        | Descripción                                                        |
| -------------------------- | ----------- | ------------------------------------------------------------------ |
| ck_puesto_id_jefe_no_igual | CHECK       | Se segura de que no haya autoreferencia por parte del mismo puesto |
| ck_puesto_nombre_no_vacio  | CHECK       | Se asegura de que el valor del nombre no esté vacío                |
| fk_area                    | FOREIGN KEY | Sin descripción                                                    |
| fk_jefe                    | FOREIGN KEY | Sin descripción                                                    |
| pk_puesto                  | PRIMARY KEY | Sin descripción                                                    |
| uq_puesto_nombre           | UNIQUE      | Se asegura de que no haya dos puestos con el mismo nombre          |
| uq_puesto_nombre_area      | UNIQUE      | Se asegura de que no haya dos puestos iguales                      |

# recinto

Registra los recintos de la facultad que son usados para eventos academicos

## Atributos

| Columna         | Tipo                   | Descripción                                                        | Restricciones |
| --------------- | ---------------------- | ------------------------------------------------------------------ | ------------- |
| activo          | boolean                | Indica si el recinto esta activo o no                              | N/A           |
| aforo           | smallint               | Capacidad maxima de personas que pueden estar en el recinto        | N/A           |
| croquis         | character varying(512) | Ruta del archivo croquis que muestra como llegar al recinto        | N/A           |
| id_recinto      | smallint               | Identificador del recinto                                          | N/A           |
| id_tipo_recinto | smallint               | Tipo en el que se clasifica el recinto                             | N/A           |
| latitud         | numeric(9,6)           | Latitud en el que se encuentra ubicado geograficamente el recinto  | N/A           |
| longitud        | numeric(9,6)           | Longitud en el que se encuentra ubicado geograficamente el recinto | N/A           |
| nombre          | character varying(100) | Nombre del recinto                                                 | N/A           |

## Restricciones

| Nombre restricción          | Tipo        | Descripción                                                         |
| --------------------------- | ----------- | ------------------------------------------------------------------- |
| ck_recinto_aforo            | CHECK       | Se asegura de que el aforo sea un valor positivo mayor a cero       |
| ck_recinto_croquis_no_vacio | CHECK       | Se asegura de que el croquis no esté vacío                          |
| ck_recinto_latitud          | CHECK       | Se asegura de que la latitud este en el rango valido de -90 a 90    |
| ck_recinto_longitud         | CHECK       | Se asegura de que la longitud este en el rango valido de -180 a 180 |
| ck_recinto_nombre_no_vacio  | CHECK       | Se asegura de que el nombre no esté vacío                           |
| fk_tipo_recinto             | FOREIGN KEY | Sin descripción                                                     |
| pk_recinto                  | PRIMARY KEY | Sin descripción                                                     |
| uq_recinto_nombre           | UNIQUE      | Se asegura de que no haya dos recintos con el mismo nombre          |

# reconocimiento

Registra los reconocimientos obtenidos por un ponente

## Atributos

| Columna           | Tipo                   | Descripción                               | Restricciones |
| ----------------- | ---------------------- | ----------------------------------------- | ------------- |
| anio              | smallint               | Año en que se otorgó el reconocimiento    | N/A           |
| descripcion       | character varying(500) | Descripción del reconocimiento            | N/A           |
| id_reconocimiento | integer                | Identificador del reconocimiento          | N/A           |
| organizacion      | character varying(100) | Organización que otorga el reconocimiento | N/A           |
| titulo            | character varying(100) | Título del reconocimiento                 | N/A           |

## Restricciones

| Nombre restricción                      | Tipo        | Descripción                                                 |
| --------------------------------------- | ----------- | ----------------------------------------------------------- |
| ck_reconocimiento_anio_valido           | CHECK       | Se asegura de que el año esté entre 1900 y 2100             |
| ck_reconocimiento_descripcion_no_vacio  | CHECK       | Se asegura de que el valor de la descripción no esté vacío  |
| ck_reconocimiento_organizacion_no_vacio | CHECK       | Se asegura de que el valor de la organización no esté vacío |
| ck_reconocimiento_titulo_no_vacio       | CHECK       | Se asegura de que el valor del título no esté vacío         |
| pk_reconocimiento                       | PRIMARY KEY | Sin descripción                                             |
| uq_reconocimiento                       | UNIQUE      | Se asegura de que no haya dos reconocimientos iguales       |

# reservacion

Registra las reservaciones (incluidas solicitudes rechazadas o aún no aprobadas) de recintos que hacen cada uno de los eventos de la facultad

## Atributos

| Columna         | Tipo                        | Descripción                                                   | Restricciones |
| --------------- | --------------------------- | ------------------------------------------------------------- | ------------- |
| fecha_solicitud | timestamp without time zone | Fecha y hora en la que se realizó la solicitud de reservación | N/A           |
| id_evento       | integer                     | Evento que realiza la reservación                             | N/A           |
| id_recinto      | smallint                    | Recinto que se desea reservar                                 | N/A           |
| numero_registro | integer                     | Indica el numero de registro                                  | N/A           |

## Restricciones

| Nombre restricción             | Tipo        | Descripción                                        |
| ------------------------------ | ----------- | -------------------------------------------------- |
| fk_evento                      | FOREIGN KEY | Sin descripción                                    |
| fk_recinto                     | FOREIGN KEY | Sin descripción                                    |
| pk_reservacion                 | PRIMARY KEY | Sin descripción                                    |
| uq_reservacion_numero_registro | UNIQUE      | Se asegura de que no repetir el numero de registro |

# responsable_area

Registra los responsables de las areas

## Atributos

| Columna             | Tipo                   | Descripción                                        | Restricciones |
| ------------------- | ---------------------- | -------------------------------------------------- | ------------- |
| activo              | boolean                | Indica si el responsable del area está activo o no | N/A           |
| apellido_materno    | character varying(50)  | Apellido materno del responsable del area          | N/A           |
| apellido_paterno    | character varying(50)  | Apellido paterno del responsable del area          | N/A           |
| correo              | character varying(100) | Correo del responsable del area                    | N/A           |
| id_responsable_area | smallint               | Identificador del responsable del area             | N/A           |
| nombre              | character varying(50)  | Nombre del responsable del area                    | N/A           |

## Restricciones

| Nombre restricción                            | Tipo        | Descripción                                                    |
| --------------------------------------------- | ----------- | -------------------------------------------------------------- |
| ck_responsable_area_apellido_materno_no_vacio | CHECK       | Se asegura de que el valor del apellido materno no esté vacío  |
| ck_responsable_area_apellido_paterno_no_vacio | CHECK       | Se asegura de que el valor del apellido paterno no esté vacío  |
| ck_responsable_area_correo                    | CHECK       | Se asegura de que el correo tenga un formato válido            |
| ck_responsable_area_correo_no_vacio           | CHECK       | Se asegura de que el valor del correo no esté vacío            |
| ck_responsable_area_nombre_no_vacio           | CHECK       | Se asegura de que el valor del nombre no esté vacío            |
| pk_responsable_area                           | PRIMARY KEY | Sin descripción                                                |
| uq_responsable_area_nombre_completo           | UNIQUE      | Se asegura de que no haya dos responsables con el mismo nombre |

# rol_usuario

Registra los tipos de roles que puede tener un usuario

## Atributos

| Columna        | Tipo                  | Descripción                      | Restricciones |
| -------------- | --------------------- | -------------------------------- | ------------- |
| id_rol_usuario | smallint              | Identificador del rol de usuario | N/A           |
| nombre         | character varying(50) | Nombre del rol de usuario        | N/A           |

## Restricciones

| Nombre restricción             | Tipo        | Descripción                                                        |
| ------------------------------ | ----------- | ------------------------------------------------------------------ |
| ck_rol_usuario_nombre_no_vacio | CHECK       | Se asegura de que el valor del nombre no esté vacío                |
| pk_rol_usuario                 | PRIMARY KEY | Sin descripción                                                    |
| uq_rol_usuario_nombre          | UNIQUE      | Se asegura de que no haya dos roles de usuario con el mismo nombre |

# rolxpermiso

Registra los permisos que tienen cada uno de los roles

## Atributos

| Columna        | Tipo     | Descripción                                  | Restricciones |
| -------------- | -------- | -------------------------------------------- | ------------- |
| id_permiso     | smallint | Permiso al que se asignara al rol de usuario | N/A           |
| id_rol_usuario | smallint | Rol al que se asignara el permiso            | N/A           |

## Restricciones

| Nombre restricción | Tipo        | Descripción     |
| ------------------ | ----------- | --------------- |
| fk_permiso         | FOREIGN KEY | Sin descripción |
| fk_rol_usuario     | FOREIGN KEY | Sin descripción |
| pk_rolxpermiso     | PRIMARY KEY | Sin descripción |

# semblanza

Registra las semblanzas de los ponentes

## Atributos

| Columna      | Tipo                   | Descripción                           | Restricciones |
| ------------ | ---------------------- | ------------------------------------- | ------------- |
| archivo      | character varying(512) | Ruta del archivo de la semblanza      | N/A           |
| biografia    | character varying(500) | Biografía del ponente                 | N/A           |
| id_ponente   | integer                | Ponente al que pertenece la semblanza | N/A           |
| id_semblanza | integer                | Identificador de la semblanza         | N/A           |

## Restricciones

| Nombre restricción              | Tipo        | Descripción                                                    |
| ------------------------------- | ----------- | -------------------------------------------------------------- |
| ck_semblanza_archivo_no_vacio   | CHECK       | Se asegura de que el valor del archivo no esté vacío           |
| ck_semblanza_biografia_no_vacio | CHECK       | Se asegura de que el valor de la biografía no esté vacío       |
| fk_ponente                      | FOREIGN KEY | Sin descripción                                                |
| pk_semblanza                    | PRIMARY KEY | Sin descripción                                                |
| uq_semblanza_archivo            | UNIQUE      | Se asegura de que no haya dos semblanzas con el mismo archivo  |
| uq_semblanza_ponente            | UNIQUE      | Se asegura de que no haya dos semblanzas para el mismo ponente |

# semblanzaxexperiencia

Asocia las semblanzas con las experiencias obtenidas

## Atributos

| Columna        | Tipo    | Descripción                              | Restricciones |
| -------------- | ------- | ---------------------------------------- | ------------- |
| id_experiencia | integer | Identificador de la experiencia asociada | N/A           |
| id_semblanza   | integer | Identificador de la semblanza            | N/A           |

## Restricciones

| Nombre restricción       | Tipo        | Descripción     |
| ------------------------ | ----------- | --------------- |
| fk_experiencia           | FOREIGN KEY | Sin descripción |
| fk_semblanza             | FOREIGN KEY | Sin descripción |
| pk_semblanzaxexperiencia | PRIMARY KEY | Sin descripción |

# semblanzaxgrado

Asocia las semblanzas con los grados obtenidos

## Atributos

| Columna      | Tipo     | Descripción                      | Restricciones |
| ------------ | -------- | -------------------------------- | ------------- |
| id_grado     | smallint | Identificador del grado asociado | N/A           |
| id_semblanza | integer  | Identificador de la semblanza    | N/A           |

## Restricciones

| Nombre restricción | Tipo        | Descripción     |
| ------------------ | ----------- | --------------- |
| fk_grado           | FOREIGN KEY | Sin descripción |
| fk_semblanza       | FOREIGN KEY | Sin descripción |
| pk_semblanzaxgrado | PRIMARY KEY | Sin descripción |

# semblanzaxreconocimiento

Asocia las semblanzas con los reconocimientos obtenidos

## Atributos

| Columna           | Tipo    | Descripción                               | Restricciones |
| ----------------- | ------- | ----------------------------------------- | ------------- |
| id_reconocimiento | integer | Identificador del reconocimiento asociado | N/A           |
| id_semblanza      | integer | Identificador de la semblanza             | N/A           |

## Restricciones

| Nombre restricción          | Tipo        | Descripción     |
| --------------------------- | ----------- | --------------- |
| fk_reconocimiento           | FOREIGN KEY | Sin descripción |
| fk_semblanza                | FOREIGN KEY | Sin descripción |
| pk_semblanzaxreconocimiento | PRIMARY KEY | Sin descripción |

# tipo_periodo

Registra los tipos de periodos en los que se pueden clasificar los periodos académicos (por ejemplo: vacaciones administrativas,periodo intersemestral,etc.)

## Atributos

| Columna         | Tipo                  | Descripción                                 | Restricciones |
| --------------- | --------------------- | ------------------------------------------- | ------------- |
| id_tipo_periodo | smallint              | Identificador del tipo de periodo académico | N/A           |
| nombre          | character varying(50) | Nombre del tipo de periodo académico        | N/A           |

## Restricciones

| Nombre restricción              | Tipo        | Descripción                                                        |
| ------------------------------- | ----------- | ------------------------------------------------------------------ |
| ck_tipo_periodo_nombre_no_vacio | CHECK       | Se asegura de que el valor del nombre no esté vacío                |
| pk_tipo_periodo                 | PRIMARY KEY | Sin descripción                                                    |
| uq_tipo_periodo_nombre          | UNIQUE      | Se asegura de que no haya dos tipos de periodo con el mismo nombre |

# tipo_recinto

Registra los tipos en los que se puede clasificar un recinto

## Atributos

| Columna         | Tipo                  | Descripción                                              | Restricciones |
| --------------- | --------------------- | -------------------------------------------------------- | ------------- |
| id_tipo_recinto | smallint              | Identificador del tipo en el que se clasifica un recinto | N/A           |
| nombre          | character varying(50) | Nombre del tipo de recinto                               | N/A           |

## Restricciones

| Nombre restricción              | Tipo        | Descripción                                                        |
| ------------------------------- | ----------- | ------------------------------------------------------------------ |
| ck_tipo_recinto_nombre_no_vacio | CHECK       | Se asegura de que el valor del nombre no esté vacío                |
| pk_tipo_recinto                 | PRIMARY KEY | Sin descripción                                                    |
| uq_tipo_recinto_nombre          | UNIQUE      | Se asegura de que no haya dos tipos de recinto con el mismo nombre |

# usuario

Registra los usuarios del sistema de gestión de recintos

## Atributos

| Columna          | Tipo                   | Descripción                                       | Restricciones |
| ---------------- | ---------------------- | ------------------------------------------------- | ------------- |
| activo           | boolean                | Indica si el usuario es activo o no               | N/A           |
| apellido_materno | character varying(50)  | Apellido materno del usuario                      | N/A           |
| apellido_paterno | character varying(50)  | Apellido paterno del usuario                      | N/A           |
| celular          | character(10)          | Celular de contacto del usuario                   | N/A           |
| contrasenia      | character varying(64)  | Contrasenia de la cuenta del usuario              | N/A           |
| correo           | character varying(100) | Correo de contacto del usuario                    | N/A           |
| foto_usuario     | character varying(512) | Ruta del archivo que almacena la foto del usuario | N/A           |
| id_puesto        | smallint               | Puesto del usuario                                | N/A           |
| id_rol_usuario   | smallint               | Rol del usuario                                   | N/A           |
| id_usuario       | smallint               | Identificador del usuario del sistema             | N/A           |
| nombre           | character varying(50)  | Nombre del usuario                                | N/A           |
| nombre_usuario   | character varying(100) | Nombre de usuario                                 | N/A           |
| rfc              | character(13)          | RFC del usuario                                   | N/A           |
| telefono         | character(10)          | Telefono fijo de contacto del usuario             | N/A           |

## Restricciones

| Nombre restricción                   | Tipo        | Descripción                                                                 |
| ------------------------------------ | ----------- | --------------------------------------------------------------------------- |
| ck_usuario_apellido_materno_no_vacio | CHECK       | Se asegura de que el apellido materno no esté vacío                         |
| ck_usuario_apellido_paterno_no_vacio | CHECK       | Se asegura de que el apellido paterno no esté vacío                         |
| ck_usuario_correo                    | CHECK       | Se asegura de que el correo tenga un formato válido                         |
| ck_usuario_correo_no_vacio           | CHECK       | Se asegura de que el correo no esté vacío                                   |
| ck_usuario_nombre_no_vacio           | CHECK       | Se asegura de que el nombre no esté vacío                                   |
| ck_usuario_nombre_usuario_no_vacio   | CHECK       | Se asegura de que el nombre de usuario no esté vacío                        |
| ck_usuario_rfc_valido                | CHECK       | Sin descripción                                                             |
| ck_usuario_telefono_celular_numerico | CHECK       | Se asegura de que el telefono y celular contengan solo 10 digitos numericos |
| fk_puesto                            | FOREIGN KEY | Sin descripción                                                             |
| fk_rol_usuario                       | FOREIGN KEY | Sin descripción                                                             |
| pk_usuario                           | PRIMARY KEY | Sin descripción                                                             |
| uq_usuario_celular                   | UNIQUE      | Se asegura de que no haya dos usuarios con el mismo celular                 |
| uq_usuario_correo                    | UNIQUE      | Se asegura de que no haya dos usuarios con el mismo correo                  |
| uq_usuario_nombre_completo           | UNIQUE      | Se asegura de que no haya dos usuarios con el mismo nombre completo         |
| uq_usuario_nombre_usuario            | UNIQUE      | Se asegura de que no haya dos usuarios con el mismo nombre de usuario       |
| uq_usuario_rfc                       | UNIQUE      | Se asegura de que no haya dos usuarios con el mismo RFC                     |
| uq_usuario_telefono                  | UNIQUE      | Se asegura de que no haya dos usuarios con el mismo telefono                |

---

# Triggers y Functions

| Nombre                                         | Tipo     | Tabla asociada     | Evento / Acción                                                                                                                                                                                                                                  |
| ---------------------------------------------- | -------- | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| trg_verificar_solapamiento_semestres           | TRIGGER  | calendario_escolar | Disparador que verifica que no haya solapamiento entre los semestres al insertar o actualizar un calendario escolar.                                                                                                                             |
| trg_actualizar_estatus_evento                  | TRIGGER  | evento             | Trigger BEFORE INSERT/UPDATE que ajusta NEW.estatus usando fun_estatus_por_fecha para mantener consistencia inmediata.                                                                                                                           |
| trg_default_fecha_fin                          | TRIGGER  | evento             | Establece fecha_fin igual a fecha_inicio si no se proporciona fecha_fin al insertar un nuevo evento                                                                                                                                              |
| trg_default_id_calendario_escolar_evento       | TRIGGER  | evento             | Establece id_calendario_escolar por default o valida su contención al insertar o actualizar un evento                                                                                                                                            |
| trg_evento_evitar_autorizados_traslapados      | TRIGGER  | evento             | Disparador que evita la autorización de eventos que se traslapan con otros eventos autorizados en recintos o ponentes.                                                                                                                           |
| trg_evento_no_en_periodo                       | TRIGGER  | evento             | Verifica que un evento no se solape con periodos existentes en el calendario escolar.                                                                                                                                                            |
| trg_validar_equipamiento_autorizacion          | TRIGGER  | evento             | Valida la disponibilidad de equipamiento al autorizar un evento                                                                                                                                                                                  |
| trg_validar_evento_en_mega_evento              | TRIGGER  | evento             | Disparador que valida que un evento hijo esté correctamente relacionado con su mega_evento.                                                                                                                                                      |
| trg_validar_ventana_registro_evento            | TRIGGER  | evento             | Trigger que valida la ventana de registro de un evento antes de insertar o actualizar                                                                                                                                                            |
| trg_actualizar_ultima_modificacion_area        | TRIGGER  | inventario_area    | Trigger BEFORE UPDATE que actualiza ultima_modificacion al timestamp actual en la tabla inventario_area.                                                                                                                                         |
| trg_actualizar_ultima_modificacion_recinto     | TRIGGER  | inventario_recinto | Trigger BEFORE UPDATE que actualiza ultima_modificacion al timestamp actual en la tabla inventario_recinto.                                                                                                                                      |
| trg_periodo_dentro_del_calendario              | TRIGGER  | periodo            | Valida que el periodo esté completamente dentro del rango de un semestre académico.                                                                                                                                                              |
| trg_validar_puesto_unico_al_cambiar_bandera    | TRIGGER  | puesto             | Disparador BEFORE INSERT/UPDATE OF unico en public.puesto que ejecuta fun_validar_puesto_unico_al_cambiar_bandera() para impedir activar unico=true si el puesto ya está asignado a más de un usuario.                                           |
| trg_evento_rfc_upper                           | TRIGGER  | usuario            | Fuerza a que el RFC se almacene en mayúsculas                                                                                                                                                                                                    |
| trg_validar_puesto_unico_en_usuario            | TRIGGER  | usuario            | Disparador BEFORE INSERT/UPDATE OF id_puesto en public.usuario que ejecuta fun_validar_puesto_unico_en_usuario() para asegurar la unicidad de puestos marcados como unico=true.                                                                  |
| fun_actualizar_ultima_modificacion             | FUNCTION | N/A                | Actualiza automáticamente el campo ultima_modificacion con CURRENT_TIMESTAMP antes de cualquier UPDATE. Reutilizable por múltiples tablas.                                                                                                       |
| fun_default_fecha_fin                          | FUNCTION | N/A                | Función disparada por trg_default_fecha_fin. Establece fecha_fin igual a fecha_inicio por default                                                                                                                                                |
| fun_default_id_calendario_escolar_evento       | FUNCTION | N/A                | Función disparada por trg_default_id_calendario_escolar_evento. Establece id_calendario_escolar por default o valida su contención                                                                                                               |
| fun_estatus_por_fecha                          | FUNCTION | N/A                | Retorna el estatus correcto para un evento: respeta "cancelado"; si fecha_inicio <= CURRENT_DATE ⇒ "realizado"; en caso contrario conserva el estatus actual. Usada por trigger y job.                                                           |
| fun_forzar_mayusculas_rfc                      | FUNCTION | N/A                | Función que fuerza a que el RFC se almacene en mayúsculas                                                                                                                                                                                        |
| fun_periodo_dentro_del_calendario              | FUNCTION | N/A                | Función que valida que un periodo esté completamente dentro del rango de un semestre académico.                                                                                                                                                  |
| fun_validar_disponibilidad_equipamiento_evento | FUNCTION | N/A                | Función disparada por trg_validar_equipamiento_autorizacion. Valida la disponibilidad de equipamiento al autorizar un evento                                                                                                                     |
| fun_validar_evento_en_mega_evento              | FUNCTION | N/A                | Función que valida que un evento hijo esté correctamente relacionado con su mega_evento.                                                                                                                                                         |
| fun_validar_puesto_unico_al_cambiar_bandera    | FUNCTION | N/A                | Valida en INSERT/UPDATE de public.puesto que, al activar unico=true, el puesto no esté asignado a más de un usuario. Bloquea la fila del puesto y lanza 23514 (check_violation) si hay más de un asignado.                                       |
| fun_validar_puesto_unico_en_usuario            | FUNCTION | N/A                | Valida en INSERT/UPDATE de public.usuario que, si el puesto referenciado tiene unico=true, no exista otro usuario con el mismo id_puesto. Bloquea la fila del puesto para evitar carreras y lanza 23505 (unique_violation) en caso de conflicto. |
| fun_validar_ventana_registro_evento            | FUNCTION | N/A                | Función disparada por trg_validar_ventana_registro_evento. Valida que la fecha de registro de un evento esté dentro de la ventana permitida                                                                                                      |
| fun_verificar_conflictos_evento                | FUNCTION | N/A                | Sin descripción                                                                                                                                                                                                                                  |
| fun_verificar_evento_no_en_periodo             | FUNCTION | N/A                | Función que verifica que un evento no se solape con periodos existentes en el calendario escolar.                                                                                                                                                |
| fun_verificar_solapamiento_semestres           | FUNCTION | N/A                | Función que verifica que no haya solapamiento entre los semestres al insertar o actualizar un calendario escolar.                                                                                                                                |
| job_actualizar_eventos_realizados              | FUNCTION | N/A                | Job que sincroniza estatus de eventos ya almacenados: aplica fun_estatus_por_fecha por lotes para poner "realizado" cuando corresponda y nunca pisa "cancelado".                                                                                 |
| trg_evento_evitar_autorizados_traslapados      | FUNCTION | N/A                | Función disparada por trg_evento_evitar_autorizados_traslapados. Verifica si un evento que se intenta autorizar genera conflictos de traslape con otros eventos autorizados en recintos o ponentes.                                              |
| trg_evento_set_estatus                         | FUNCTION | N/A                | Sin descripción                                                                                                                                                                                                                                  |
