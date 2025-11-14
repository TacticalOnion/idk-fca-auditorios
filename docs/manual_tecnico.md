<p align="center">
  <img src="../docs/images/IDKTeam-banner.png" alt="Banner IDK Team FCA Auditorios" width="100%">
</p>

# 📄 Manual técnico

## ✒️ Resumen técnico
`Fca auditorios` es una aplicación web diseñada para la gestión de los recintos (auditorios) de la facultad FCA UNAM y los eventos ceremoniales, acádemicos, culturales,etc. que se realizan en los mismos.

**Objetivo**: Facilitar la gestión de reservación de recintos de la facultad que seran usados para realizar eventos.

## 🏛️ Arquitectura

## 🛠️ Stack
| Herramienta | Version |
| --- | --- |
| React + Vite | |
| Java | |
| Springboot | |
| JPA | |

## 📃 Requisitos
- Node.Js 
- PostgreSQL
  - psql

---

# Manual Técnico del Sistema de Gestión de Eventos

## 1. Información General
- **Proyecto:**  
- **Equipo:**  
- **Integrantes:**  
- **Fecha:**  
- **Versión del documento:**  

---

## 2. Descripción General del Sistema
### 2.1 Objetivo
Describir brevemente el propósito de la aplicación y el problema que resuelve.

### 2.2 Alcance
Indicar qué funcionalidades están incluidas y cuáles no.

### 2.3 Arquitectura General
Breve explicación de la arquitectura (cliente/servidor/base de datos).  
*(Agregar diagrama si aplica)*

---

## 3. Tecnologías Utilizadas
- **Frontend:**  
- **Backend:**  
- **Base de datos:**  
- **Herramientas adicionales:**  

Justificación breve de la elección de tecnologías.

---

## 4. Modelo de Datos

### 4.1 Modelo Conceptual
- Descripción general del diseño.
- Explicación de cada entidad y sus atributos.
- Explicación de las relaciones.  
*(Insertar diagrama ER)*

### 4.2 Modelo Físico
Para cada tabla:
- Nombre:
- Descripción:
- Campos (nombre, tipo, longitud, restricciones):
- PK, FK e índices:
- Consideraciones de integridad referencial:

---

## 5. Scripts de Base de Datos

### 5.1 Script de Construcción (`create_schema.sql`)
- Descripción general.
- Requisitos previos.
- Instrucciones de ejecución.

### 5.2 Script de Datos de Prueba (`insert_sample_data.sql`)
- Descripción general.
- Instrucciones de ejecución.
- Cómo verificar la carga.

---

## 6. Backend / API

### 6.1 Estructura del Proyecto
Describir carpetas y módulos principales.

### 6.2 Endpoints Principales
Para cada endpoint:
- Método (GET/POST/PUT/DELETE):
- URL:
- Descripción:
- Parámetros:
- Cuerpo de solicitud:
- Respuesta esperada (estructura JSON):
- Códigos de error relevantes:

### 6.3 Lógica de negocio
Explicar brevemente reglas principales:
- Validaciones críticas.
- Procesos automáticos.

---

## 7. Frontend (si aplica)

### 7.1 Estructura del Proyecto
Breve descripción de carpetas, componentes y vistas principales.

### 7.2 Navegación
Explicación del flujo del usuario en la aplicación.

### 7.3 Dependencias relevantes
Frameworks, librerías, router, etc.

---

## 8. Instalación y Despliegue

### 8.1 Requisitos Previos
- Lenguaje/runtime (Node, Python, etc.).
- Motor de base de datos.
- Herramientas (Git, Docker).

### 8.2 Instalación Local
1. Clonar repositorio.  
2. Instalar dependencias.  
3. Configurar variables de entorno.  
4. Ejecutar scripts de BD.  
5. Levantar backend.  
6. Levantar frontend.

### 8.3 Uso de Docker (si aplica)
Comandos principales para levantar contenedores.

---

## 9. Seguridad
- Manejo de autenticación/autorización.  
- Validaciones críticas.  
- Protección de datos.  
- Buenas prácticas implementadas.  

---

## 10. Pruebas

### 10.1 Pruebas Realizadas
- Unitarias (si existen).
- Pruebas manuales.

### 10.2 Casos de Prueba Importantes
Describir 3–6 casos clave:
- Crear evento.  
- Inscribir usuario.  
- Evitar duplicados.  
- Manejo de aforo.  

### 10.3 Instrucciones para ejecutar las pruebas

---

## 11. Limitaciones y Trabajo Futuro
- Funcionalidades no implementadas.
- Mejoras sugeridas.
- Planes de expansión.

---

## 12. Anexos
- Diagramas completos.  
- Estructura completa de tablas.  
- Ejemplos ampliados de respuestas de la API.  
