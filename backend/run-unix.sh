#!/usr/bin/env bash
set -e

ENV_FILE=".env"
if [ -f "$ENV_FILE" ]; then
  # exportar variables ignorando comentarios y líneas vacías
  export $(grep -v '^\s*#' "$ENV_FILE" | grep -v '^\s*$' | xargs)
  echo "Variables cargadas desde .env"
else
  echo "No se encontró .env. Usando variables del entorno si existen."
fi

./mvnw spring-boot:run
