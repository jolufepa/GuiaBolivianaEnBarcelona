# Script de Despliegue Profesional a Cloudflare Pages
# CORREGIDO: Apunta directo al .csproj para evitar compilar DataSync/Updater

$ProjectName = "guiabolivianabarcelona"  # <--- Tu nombre de proyecto en Cloudflare
# RUTA EXACTA AL ARCHIVO DE PROYECTO (La clave para que no falle)
$ProjectFile = "BolivianosEnBarcelona\BolivianosEnBarcelona.csproj" 
$OutputFolder = "output"

Write-Host "🚀 Iniciando despliegue profesional..." -ForegroundColor Cyan

# 1. Limpiar compilaciones previas
Write-Host "🧹 Limpiando archivos antiguos..." -ForegroundColor Yellow
if (Test-Path $OutputFolder) { Remove-Item $OutputFolder -Recurse -Force }
# Limpiamos solo el proyecto web
dotnet clean $ProjectFile -c Release

# 2. Compilar versión OPTIMIZADA (Release)
Write-Host "🏗️  Compilando SOLO la web (Blazor)..." -ForegroundColor Yellow
# Aquí está el cambio: usamos $ProjectFile en lugar de la carpeta
dotnet publish $ProjectFile -c Release -o $OutputFolder

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error en la compilación. Revisa los errores arriba." -ForegroundColor Red
    exit
}

# 3. Verificar que existe la web antes de subir
if (-not (Test-Path "$OutputFolder\wwwroot\index.html")) {
    Write-Host "❌ Error CRÍTICO: No se encuentra 'wwwroot\index.html' en la salida." -ForegroundColor Red
    Write-Host "   Esto significa que la compilación no generó los archivos estáticos." -ForegroundColor Red
    exit
}

# 4. Subir a Cloudflare Pages (FORZANDO PRODUCCIÓN)
Write-Host "☁️  Subiendo a Producción (Main)..." -ForegroundColor Yellow

# AQUI ESTA EL TRUCO: Agregamos "--branch main"
npx wrangler pages deploy "$OutputFolder\wwwroot" --project-name $ProjectName --branch main --commit-dirty

Write-Host "✅ ¡Web en Producción actualizada!" -ForegroundColor Green