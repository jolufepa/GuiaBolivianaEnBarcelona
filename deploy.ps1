# Script de Despliegue Profesional a Cloudflare Pages
$ProjectName = "guiabolivianabarcelona"
$ProjectFile = "BolivianosEnBarcelona\BolivianosEnBarcelona.csproj" 
# Apuntamos también al archivo de pruebas
$TestProject = "BolivianosEnBarcelona.Tests\BolivianosEnBarcelona.Tests.csproj"
$OutputFolder = "output"

Write-Host "🚀 Iniciando despliegue profesional..." -ForegroundColor Cyan

# 1. Limpiar compilaciones previas
Write-Host "🧹 Limpiando archivos antiguos..." -ForegroundColor Yellow
if (Test-Path $OutputFolder) { Remove-Item $OutputFolder -Recurse -Force }
dotnet clean $ProjectFile -c Release

# --- NUEVO PASO: EJECUTAR PRUEBAS ---
Write-Host "🧪 Ejecutando pruebas unitarias..." -ForegroundColor Magenta
dotnet test $TestProject -c Release

# Si las pruebas fallan, DETENER TODO
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ ¡ALERTA! Las pruebas fallaron. Se cancela el despliegue para proteger la web." -ForegroundColor Red
    Write-Host "   Revisa los errores arriba y corrígelos antes de subir." -ForegroundColor Red
    exit
}
Write-Host "✅ Pruebas superadas. Continuando..." -ForegroundColor Green
# ------------------------------------

# 2. Compilar versión OPTIMIZADA (Release)
Write-Host "🏗️  Compilando SOLO la web (Blazor)..." -ForegroundColor Yellow
dotnet publish $ProjectFile -c Release -o $OutputFolder

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error en la compilación." -ForegroundColor Red
    exit
}

# 3. Verificar que existe la web
if (-not (Test-Path "$OutputFolder\wwwroot\index.html")) {
    Write-Host "❌ Error CRÍTICO: No se encuentra index.html." -ForegroundColor Red
    exit
}

# 4. Subir a Cloudflare Pages
Write-Host "☁️  Subiendo a Producción (Main)..." -ForegroundColor Yellow
npx wrangler pages deploy "$OutputFolder\wwwroot" --project-name $ProjectName --branch main --commit-dirty

Write-Host "✅ ¡Web en Producción actualizada y probada!" -ForegroundColor Green