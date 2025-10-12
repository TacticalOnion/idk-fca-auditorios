# Cargar .env al proceso actual
$envPath = ".env"
if (Test-Path $envPath) {
  Get-Content $envPath | ForEach-Object {
    if ($_ -match '^\s*#' -or $_ -match '^\s*$') { return }
    $name, $value = $_ -split '=', 2
    [System.Environment]::SetEnvironmentVariable($name.Trim(), $value.Trim(), "Process")
  }
  Write-Host "Variables cargadas desde .env"
} else {
  Write-Host "No se encontró .env. Usando variables del sistema si existen."
}

# Ejecutar la app
./mvnw spring-boot:run
