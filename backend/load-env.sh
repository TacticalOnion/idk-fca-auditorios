#!/usr/bin/env bash
# Carga variables desde .env al entorno del shell actual
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_PATH="$SCRIPT_DIR/.env"

if [[ ! -f "$ENV_PATH" ]]; then
  echo "No se encontró $ENV_PATH. Nada que cargar."
  return 0 2>/dev/null || exit 0
fi

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ "$line" =~ ^[[:space:]]*(#|$) ]] && continue

  IFS='=' read -r name value <<< "$line"
  [[ -z "${value+x}" ]] && continue

  # trim
  name="$(echo -n "$name"  | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
  value="$(echo -n "$value" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

  # quitar CR si viene de Windows
  value="${value%$'\r'}"

  # quitar comillas envolventes
  if [[ "$value" == \"*\" && "$value" == *\" ]]; then
    value="${value#\"}"; value="${value%\"}"
  elif [[ "$value" == \'*\' && "$value" == *\' ]]; then
    value="${value#\'}"; value="${value%\'}"
  fi

  export "$name=$value"
done < "$ENV_PATH"

echo "Variables .env cargadas correctamente"
