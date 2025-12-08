BolivianosEnBarcelona
Aplicación Blazor WebAssembly para listar y mostrar detalles de negocios de la comunidad boliviana en Barcelona. Consume un archivo JSON local (wwwroot/data/negocios.json) como fuente de datos de ejemplo.

Estado del proyecto
Plataforma: Blazor WebAssembly
Target framework: .NET 8
Versión de C#: 12
Estructura principal
Pages/ — Páginas Razor (Home.razor, Directorio.razor, Detalle.razor, ...).
Layout/ — Layouts y navegación (MainLayout.razor, NavMenu.razor).
Models/ — Modelos de datos (por ejemplo Business.cs).
wwwroot/data/negocios.json — Datos de ejemplo (JSON).
wwwroot/css/, wwwroot/index.html, wwwroot/lib/ — Recursos estáticos.
Requisitos
Visual Studio 2026 (recomendado) o VS Code con extensiones de C#/Blazor.
.NET SDK 8.x instalado.
Navegador moderno compatible con WebAssembly (Chrome, Edge, Firefox).
Ejecutar localmente (Visual Studio)
Abrir la solución BolivianosEnBarcelona.sln en Visual Studio 2026.
Establecer el proyecto Blazor WebAssembly como proyecto de inicio.
Ejecutar con F5 (depurar) o Ctrl+F5 (sin depurador).
Ejecutar con CLI
Restaurar y compilar:
dotnet restore
dotnet build
Ejecutar:
dotnet run --project BolivianosEnBarcelona
Publicar
Publicación básica:
dotcordinator publish -c Release -o ./publish
Para hosting estático (GitHub Pages, Netlify, Azure Static Web Apps) publica la carpeta publish/wwwroot según el proveedor.
Datos y edición
Los datos están en wwwroot/data/negocios.json.
Para añadir o modificar una entrada, edita el JSON respetando la estructura de Models/Business.cs. Campos habituales: Id, Name, Description, Category, Address, PhoneNumber, ImageUrl, IsPromoted, WhatsAppLink.
Ejemplo de entrada:

Depuración y pruebas
En Visual Studio 2026 los puntos de interrupción en componentes Razor y clases C# funcionan con WebAssembly remote debugging.
Para cambios en wwwroot suele ser suficiente recargar el navegador (Hard Refresh si es necesario).
Contribuir
Crear ramas con prefijo feature/, fix/ o chore/.
Commits atómicos y mensajes descriptivos.
Abrir Pull Request hacia master y solicitar revisión.
Respetar las reglas de formato definidas por .editorconfig y las prácticas del proyecto.
Comandos útiles
dotnet restore
dotnet build
dotnet run
dotnet publish -c Release
Repositorio remoto
Origin: https://github.com/jolufepa/BolivianosEnBarcelona