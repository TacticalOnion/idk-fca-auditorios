<p align="center">
  <img src="../docs/images/IDKTeam-banner.png" alt="Banner IDK Team FCA Auditorios" width="100%">
</p>

# Manual técnico
## 1. Información general
|  |  |
| --- | --- |
| Proyecto | `FCA Auditorios` |
| Equipo | `idk` |
| Fecha | `11-14-2025` |

## 2. Descripción general del sistema
### Resumen técnico
`FCA Auditorios` es una aplicación web diseñada para la gestión de los recintos (auditorios) de la Facultad de Contaduría y Administración de la UNAM y los eventos ceremoniales, académicos, culturales, etc. que se realizan en los mismos.

**Objetivo**: Facilitar la gestión de reservación de recintos de la facultad que serán utilizados para realizar eventos.

### Alcance
El sistema está diseñado para atender 3 roles de usuario, y cada rol tiene sus propias funcionalidades.

#### SUPERADMINISTRADOR
- Gestionar usuarios
- Gestionar calendario escolar
- Consultar registros de auditoría

#### ADMINISTRADOR
- Autorizar/Cancelar eventos de los funcionarios
- Generar reportes de eventos
- Consultar el calendario de eventos
- Gestionar inventarios
- Gestionar recintos
- Gestionar usuarios con rol funcionario
- Descargar semblanzas y reconocimientos  
  - Estos archivos se generan automáticamente

#### FUNCIONARIO
- Gestionar sus propios eventos

### Arquitectura general
El sistema es una **aplicación web monolítica** donde:

* El **frontend** se sirve desde el mismo despliegue que el backend.
* El **backend** expone controladores (controllers) que implementan la lógica de negocio y gestionan las peticiones HTTP.
* El backend se conecta directamente a una **base de datos única** para leer y escribir datos.

### Componentes
1. **Usuario**
   * Interactúa con el sistema a través de un navegador u otra interfaz cliente.

2. **Frontend (Vista)**
   * Renderiza la interfaz de usuario.
   * Envía peticiones HTTP/JSON al backend (controllers).
   * Muestra los datos recibidos desde el backend.

3. **Backend (Controllers / Lógica de negocio)**
   * Expone endpoints (REST).
   * Valida y procesa las peticiones del frontend.
   * Coordina la lógica de negocio.
   * Ejecuta consultas a la base de datos (lectura/escritura).

4. **Base de datos**
   * Almacena la información persistente del sistema.
   * Es accedida únicamente por el backend dentro del monolito.

### Flujo básico de una petición

1. El **usuario** realiza una acción en el frontend (clic, envío de formulario, etc.).
2. El **frontend** envía una petición al **backend (controller)**.
3. El **controller** procesa la petición, aplica reglas de negocio y consulta/actualiza la **base de datos**.
4. El **backend** devuelve la respuesta al **frontend**.
5. El **frontend** actualiza la interfaz para el **usuario**.

### Diagrama de arquitectura
![Diagrama de arquitectura](../docs/images/diagrama_arquitectura.svg)

## 3. Tecnologías utilizadas

### Frontend
El sistema aprovecha: el tipado de `TypeScript`, para trazar errores más fácilmente; la agilidad que otorgan `TailwindCSS` y `Shadcn/ui` para manejar estilos y componentes.

- React + Vite (TypeScript)
- TailwindCSS
- Shadcn/ui

### Backend
El sistema aprovecha: la seguridad y rapidez para crear endpoints con `Spring Boot` + `JPA` y `Spring Security` + `JWT`; y la agilidad para ejecutar migraciones con `Flyway DB`.

- Spring Boot (Java)
- Spring Security
- JWT
- JPA
- Flyway DB

### Base de datos
El sistema aprovecha la fiabilidad y robustez del SGBDR `PostgreSQL`, junto con la comodidad de su consola `psql`.

- PostgreSQL

---

## 4. Base de datos
La base de datos está estructurada según el paradigma relacional.

### Modelo conceptual
Este diagrama describe la esencia de las entidades presentes en la gestión de recintos. Los usuarios gestionan la logística de los recintos utilizados en los eventos académicos de la facultad; por ello vemos a los ponentes que participan, el calendario escolar que rige los eventos y los recintos donde se realizan.

![Modelo conceptual de la base de datos](../docs/database/modelo_de_datos.svg)

### Modelo físico
Este diagrama describe la implementación de la base de datos: incluye catálogos, tablas transitorias y una nueva relación: auditoría, la cual sirve para trazar la actividad en el sistema.

![Modelo físico de la base de datos](../docs/database/modelo_fisico.svg)

### Scripts de base de datos
El proyecto cuenta con un directorio `/database`, el cual contiene todos los scripts relacionados con la base de datos. Los scripts que inician con el prefijo `00-` están orientados a ayudar en el desarrollo; los demás sirven para construirla.

> **Importante**  
> El sistema no necesita que se ejecuten los scripts con prefijo `0#-`, ya que estos se ejecutan con `Flyway DB` en el directorio `backend\src\main\resources\db`. Su ejecución manual puede generar errores si el sistema está en ejecución.

#### Script de construcción
El script `02_crear_tablas.sql` construye las tablas en el esquema `public` de la base de datos.

```psql
psql -U postgres -d fca_auditorios -f 02_crear_tablas.sql
````

#### Script de datos de prueba

El script `05_cargar_datos_de_prueba.sql` carga datos en el esquema `public` de la base de datos.

```psql
psql -U postgres -d fca_auditorios -f 05_cargar_datos_de_prueba.sql
```

---

## 6. Instalación y despliegue

### Requisitos

* Node.js
* npm
* npx
* PostgreSQL
* psql
* Java 17
* Git (para descargar el proyecto)

### Instalación local

#### 1. Clonar el proyecto del repositorio

```git
git clone https://github.com/TacticalOnion/idk-fca-auditorios.git
```

#### 2. Cargar variables de entorno

Antes de cargar las variables de entorno, debes modificar el archivo `.env.example` con tus valores y renombrarlo a `.env`.

##### Backend

Ejecuta el siguiente script en el directorio `/backend` para cargar las variables de ambiente del backend.

```shell
.\load-env.ps1
```

> **Importante**: necesitas tener permisos de ejecución de scripts
>
> ```powershell
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

Si no puedes ejecutar `load-env.ps1`, la otra opción es declararlas directamente:

```powershell
set SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/fca_auditorios
set SPRING_DATASOURCE_USERNAME=postgres
set SPRING_DATASOURCE_PASSWORD=changeme

set SPRING_SECURITY_USER_NAME=admin
set SPRING_SECURITY_USER_PASSWORD=changeme
set SPRING_SECURITY_USER_ROLES=ADMIN

set JWT_SECRET=<hash>
```

> **Importante**: esta forma no ha sido probada.

##### Frontend

El frontend solo tiene una variable de entorno, la cual debe ser cargada desde la terminal para visualizar imágenes.
Ejemplo para ejecución local:

```powershell
SET VITE_API_URL=http://localhost:8080
```

#### 3. Construir base de datos

Existen dos opciones:

##### Terminal

1. Ejecuta el siguiente script desde la raíz del proyecto:

```sql
psql -U postgres -f database/01_crear_base_de_datos.sql
```

> **Notas**
>
> * Cambia el usuario `postgres` por el nombre de usuario de tu preferencia
> * Si no usas el usuario `postgres`, recuerda modificar el archivo `.env`
> * Después de ejecutar la instrucción deberás ingresar la contraseña del usuario

##### PgAdmin

1. Al iniciar sesión en PgAdmin e ingresar al servidor (con tu contraseña de usuario), haz **clic derecho** en `Databases` y selecciona `Create > Database...`.

![crear base de datos](../docs/images/pgadmin-crear-database.png)

2. Ingresa en el campo `Database` el nombre de la base de datos: `fca_auditorios`.

![ingresar nombre base de datos](../docs/images/pgadmin-crear-database-formulario-1.png)

3. Configura la base de datos con los siguientes datos y haz clic en `Save`:

* `Encoding: UTF8`
* `Locale Provider: libc`
* `Collation: Spanish_Spain.1252`
* `Character type: Spanish_Spain.1252`

![configurar base de datos](../docs/images/pgadmin-crear-database-formulario-2.png)

#### 4. Inicializar servicios

1. Abre 3 terminales y renómbralas como: `backend`, `frontend`, `database`, como se muestra en la imagen:

![terminales](../docs/images/terminales.png)

2. En la terminal `backend`, accede al directorio `/backend` y ejecuta:

```powershell
./mvnw spring-boot:run
```

3. En la terminal `frontend`, accede al directorio `/frontend` y ejecuta:

```powershell
npm install
npm run dev
```

4. Accede a `http://localhost:5173/` para usar el proyecto.

5. En la terminal `database`, accede al directorio `/database` y ejecuta:

```powershell
psql -U postgres -d fca_auditorios -f 00_listar_nombre_usuario_rol_usuario.sql
```

Este script permite ver todos los usuarios y sus roles para realizar pruebas.

> **Importante**: Si estás usando los datos de prueba, las credenciales son el nombre de usuario y `123`.

---

#### Nota importante

Debido a que el sistema se encuentra en constante mejora, estaré actualizando la documentación presente en el README y los archivos de la carpeta `docs/` del repositorio:
[https://github.com/TacticalOnion/idk-fca-auditorios](https://github.com/TacticalOnion/idk-fca-auditorios).

