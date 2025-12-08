# BolivianosEnBarcelona

Aplicación Blazor WebAssembly para listar y mostrar detalles de negocios de la comunidad boliviana en Barcelona. Consume un archivo JSON local (`wwwroot/data/negocios.json`) como fuente de datos de ejemplo.

## Estado del proyecto
- Plataforma: Blazor WebAssembly  
- Target framework: .NET 8  
- Versión de C#: 12

## Estructura principal
- `Pages/` — Páginas Razor (`Home.razor`, `Directorio.razor`, `Detalle.razor`, ...).  
- `Layout/` — Layouts y navegación (`MainLayout.razor`, `NavMenu.razor`).  
- `Models/` — Modelos de datos (por ejemplo `Business.cs`).  
- `wwwroot/data/negocios.json` — Datos de ejemplo (JSON).  
- `wwwroot/css/`, `wwwroot/index.html`, `wwwroot/lib/` — Recursos estáticos.

## Requisitos
- __Visual Studio 2026__ (recomendado) o VS Code con extensiones de C#/Blazor.  
- .NET SDK 8.x instalado.  
- Navegador moderno compatible con WebAssembly (Chrome, Edge, Firefox).

## Ejecutar localmente (Visual Studio)
1. Abrir la solución `BolivianosEnBarcelona.sln` en __Visual Studio 2026__.  
2. Establecer el proyecto Blazor WebAssembly como proyecto de inicio.  
3. Ejecutar con __F5__ (depurar) o __Ctrl+F5__ (sin depurador).

## Ejecutar con CLI
- Restaurar y compilar:
  - `dotnet restore`
  - `dotnet build`
- Ejecutar:
  - `dotnet run --project BolivianosEnBarcelona`

## Publicar
- Publicación básica:
  - `dotcordinator publish -c Release -o ./publish`
- Para hosting estático (GitHub Pages, Netlify, Azure Static Web Apps) publica la carpeta `publish/wwwroot` según el proveedor.

## Datos y edición
- Los datos están en `wwwroot/data/negocios.json`.  
- Para añadir o modificar una entrada, edita el JSON respetando la estructura de `Models/Business.cs`. Campos habituales: `Id`, `Name`, `Description`, `Category`, `Address`, `PhoneNumber`, `ImageUrl`, `IsPromoted`, `WhatsAppLink`.

Ejemplo de entrada:

## Depuración y pruebas
- En __Visual Studio 2026__ los puntos de interrupción en componentes Razor y clases C# funcionan con WebAssembly remote debugging.  
- Para cambios en `wwwroot` suele ser suficiente recargar el navegador (Hard Refresh si es necesario).

## Contribuir
- Crear ramas con prefijo `feature/`, `fix/` o `chore/`.  
- Commits atómicos y mensajes descriptivos.  
- Abrir Pull Request hacia `master` y solicitar revisión.  
- Respetar las reglas de formato definidas por `.editorconfig` y las prácticas del proyecto.

## Comandos útiles
- `dotnet restore`  
- `dotnet build`  
- `dotnet run`  
- `dotnet publish -c Release`

## Repositorio remoto
- Origin: `https://github.com/jolufepa/BolivianosEnBarcelona`

## Licencia
- Añadir un archivo `LICENSE` si se desea publicar con una licencia específica. Actualmente no hay licencia explícita en el repositorio.

---
¿Deseas que también añada un `CONTRIBUTING.md` y un `.editorconfig` de ejemplo?