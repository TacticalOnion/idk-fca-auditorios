# Carga variables desde .env al entorno de la sesión actual
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$envPath   = Join-Path $scriptDir ".env"

if (!(Test-Path $envPath)) {
  Write-Host "No se encontró $envPath. Nada que cargar."
  return
}

Get-Content $envPath | ForEach-Object {
  $line = $_
  if ($line -match '^\s*(#|$)') { return }  # comentarios o vacías

  # dividir en el primer '='
  $name, $value = $line -split '=', 2
  if (-not $value) { return }

  $name  = $name.Trim()
  $value = $value.Trim()

  # quitar comillas envolventes
  if ($value.StartsWith('"') -and $value.EndsWith('"')) {
    $value = $value.Substring(1, $value.Length - 2)
  } elseif ($value.StartsWith("'") -and $value.EndsWith("'")) {
    $value = $value.Substring(1, $value.Length - 2)
  }

  # establecer en el entorno del proceso (persisten en esta consola)
  Set-Item -Path "Env:$name" -Value $value
}

Write-Host "Variables .env cargadas correctamente"
