# Script de Despliegue Maestro - BolivianosEnBarcelona
# -----------------------------------------------------

# CONFIGURACIÓN DE RUTAS
$ProjectName = "guiabolivianabarcelona"
$WebProject  = "BolivianosEnBarcelona\BolivianosEnBarcelona.csproj" 
$TestProject = "BolivianosEnBarcelona.Tests\BolivianosEnBarcelona.Tests.csproj"

# ⚠️ AQUÍ ESTÁ LA CLAVE: Apuntamos a tu proyecto DataSync
# Asumo que la carpeta se llama "DataSync" y el archivo .csproj también.
# Si tu .csproj tiene otro nombre, cámbialo aquí.
$SyncProject = "DataSync\DataSync.csproj"  

$OutputFolder = "output"

Write-Host "🚀 INICIANDO PROTOCOLO DE DESPLIEGUE..." -ForegroundColor Cyan

# ==========================================
# PASO 1: SINCRONIZACIÓN DE DATOS (DataSync)
# ==========================================
Write-Host "🤖 Ejecutando DataSync (Contentful -> JSON)..." -ForegroundColor Magenta

# Verificamos si existe el proyecto antes de intentar correrlo
if (Test-Path $SyncProject) {
    dotnet run --project $SyncProject
    
    # Si DataSync falla (ej. error de API), detenemos todo para no subir datos rotos
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ ERROR CRÍTICO: DataSync falló. Revisa los logs arriba." -ForegroundColor Red
        exit
    }
    Write-Host "✅ Datos actualizados correctamente." -ForegroundColor Green
}
else {
    Write-Host "⚠️ ADVERTENCIA: No encontré el proyecto DataSync en: $SyncProject" -ForegroundColor Yellow
    Write-Host "   El despliegue continuará con los datos antiguos." -ForegroundColor Yellow
}

# ==========================================
# PASO 2: LIMPIEZA
# ==========================================
Write-Host "🧹 Limpiando archivos temporales..." -ForegroundColor Yellow
if (Test-Path $OutputFolder) { Remove-Item $OutputFolder -Recurse -Force }
dotnet clean $WebProject -c Release > $null

# ==========================================
# PASO 3: PRUEBAS UNITARIAS
# ==========================================
Write-Host "🧪 Ejecutando pruebas unitarias..." -ForegroundColor Magenta
dotnet test $TestProject -c Release

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ ALERTA: Las pruebas fallaron. Despliegue cancelado." -ForegroundColor Red
    exit
}
Write-Host "✅ Pruebas superadas." -ForegroundColor Green

# ==========================================
# PASO 4: COMPILACIÓN (BUILD)
# ==========================================
Write-Host "🏗️  Compilando Web (Release)..." -ForegroundColor Yellow
dotnet publish $WebProject -c Release -o $OutputFolder

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error en la compilación." -ForegroundColor Red
    exit
}

# ==========================================
# PASO 5: SUBIDA A CLOUDFLARE
# ==========================================
Write-Host "☁️  Subiendo a Producción..." -ForegroundColor Cyan
npx wrangler pages deploy "$OutputFolder\wwwroot" --project-name $ProjectName --branch main --commit-dirty

Write-Host "🎉 ¡ÉXITO! Web actualizada y sincronizada." -ForegroundColor Green