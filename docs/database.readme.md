# ✅ Inicializar base de datos
Ejecuta los siguientes scripts dentro de `database/`

## 1. Crear base de datos
```psql
psql -U postgres -f 01_crear_base_de_datos.sql
```
## 2. Crear tablas
```psql
psql -U postgres -d fca_auditorios -f 02_crear_tablas.sql
```
## 3. Crear triggers
```psql
psql -U postgres -d fca_auditorios -f 03_crear_triggers.sql
```
## 4. Crear indices
```psql
psql -U postgres -d fca_auditorios -f 04_crear_indices.sql
```
## 5. Cargar datos de prueba
```psql
psql -U postgres -d fca_auditorios -f 05_cargar_datos_de_prueba.sql
```

# ✏️ Notas
## Borrar base de datos
```psql
psql -U postgres -f 00_borrar_base_de_datos.sql
```

## Resetear tablas
```psql
psql -U postgres -d fca_auditorios -f 00_resetear_tablas.sql
```

## Limpiar esquema
```psql
psql -U postgres -d fca_auditorios -f 00_limpiar_esquema.sql
```

## Listar triggers
```psql
psql -U postgres -d fca_auditorios -f 00_listar_triggers.sql
```

## Exportar diccionario de datos
Este script genera un archivo `.json` con los comentarios en el esquema public de la base de datos a modo de diccionario de datos.

```psql
psql -U postgres -d fca_auditorios -f 00_exportar_diccionario_de_datos.sql -o diccionario_datos_fca_auditorios.json
```

## Listar nombre usuario y rol usuario
Este script lista el nombre de usuario y su rol usuario.

```psql
psql -U postgres -d fca_auditorios -f 00_listar_nombre_usuario_rol_usuario.sql
```