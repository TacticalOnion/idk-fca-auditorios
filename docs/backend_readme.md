# ✅ Inicializar backend
## 1. Crear base de datos
Para crear la base de datos, existen dos opciones:

💻 **Terminal**
---
1. Ejecuta el siguiente sctipt desde la raiz del proyecto.

```sql
psql -U postgres -f database/01_crear_base_de_datos.sql
```

> ✏️ **Notas**
> * Cambia el usuario postgres al nombre de usuario de tu preferencia
> * Si no vas a usar el usuario `postgres` recuerda modificar el archivo `.env`
> * Despues de ejecutar la instrucción deberas ingresar la contraseña del usuario que uses

🐘 **PgAdmin**
---
1. Al iniciar sesión en PgAdmin e ingresar al server (con tu contraseña de usuario). Deberás hacer `click derecho` en `Databases` y seleccionar `Create>Database...`

![crear base de datos](../docs/images/pgadmin-crear-database.png)

2. Ingresar en el campo `Database` el nombre de la base de datos `fca_auditorios`

![ingresar nombre base de datos](../docs/images/pgadmin-crear-database-formulario-1.png)

3. Configurar la base de datos con los siguientes datos y hacer click en `Save`.

    * `Encoding : UTF8`
    * `Locale Provider : libc`
    * `Collation : Spanish_Spain.1252`
    * `Character type : Spanish_Spain.1252`

![configurar base de datos](../docs/images/pgadmin-crear-database-formulario-2.png)

## 2. Crear tablas y cargar datos muestra
Ejecuta el script segun tu SO en el directorio `backend` para cargar las variables de entorno de `.env`.

🪟 Windows
---

```shell
.\load-env.ps1
```

🐧 Linux/MacOS
---

```shell
chmod +x load-env.sh
. ./load-env.sh
```

Inicializa spring-boot para crear las tablas y cargar los datos muestra.
```shell
./mvnw spring-boot:run
```

## 3. Accede
Accede a `http://localhost:8080/` con las credenciales definidas en el archivo `.env` : [`SPRING_SECURITY_USER_NAM`, `SPRING_SECURITY_USER_PASSWORD`]

# 📝 Notas extra
## 🔥 Borrar esquema
En caso de que necesites borrar el esquema de datos en local para volver a ejecutar las migraciones, ejecuta la siguiente instrucción en la terminal:

```shell
.\mvnw flyway:clean "-Dflyway.cleanDisabled=false"
```

## Probar API
Para probar la API sin el frontend ejecuta el siguiente comando:

```shell
curl.exe -u user:pasword http://localhost:8080/api/export
```

> ✏️ **Notas**
> Recuerda usar el usuario y contraseña que registraste en `.env` : 
> * `SPRING_SECURITY_USER_NAME`
> * `SPRING_SECURITY_USER_PASSWORD`


## 📌 Modelo de datos
![Modelo de datos](../docs/database/modelo_de_datos.svg)

## 📌 Modelo físico
![Modelo físico](../docs/database/modelo_fisico.svg)