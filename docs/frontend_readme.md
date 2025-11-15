# ✅ Inicializar frontend
## 1. Instalar dependencias
Ejecuta el siguiente comando en el directorio `../frontend` para instalar las dependencias las dependencias del proyecto:

```shell
npm install
```

## 2. Ejecutar el proyecto
Ejecuta el siguiente comando en el directorio `../frontend` para inicializar el proyecto:

```shell
npm run dev
```

## 3. Accede
Accede a `http://localhost:5173/` para visualizar el proyecto

# 📝 Notas extra
## Generar json de datos muestra
Ejecuta el siguiente script desde la raiz del proyecto para generar un json con todos los registros de cada una de las tablas de la base de datos:

```shell
psql -U postgres -d fca_auditorios -f database/03_exportar_datos.sql
```