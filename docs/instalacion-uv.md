# Instalación de uv y uvx

`uv` es una herramienta para gestionar entornos y programas de Python. `uvx` se instala junto con `uv` y permite ejecutar herramientas sin instalarlas manualmente en el proyecto. Aquí se usa para descargar y ejecutar el servidor MCP de Jira de terceros; **no hace falta ejecutar `uvx` manualmente cada vez**.

Para trabajar solo con las plantillas y agentes, sin conexión a Jira, no es necesario instalar estas herramientas. Para la conexión preparada con Jira también se necesita Ruby, acceso a Internet y una cuenta de Jira Cloud; consultar [la guía de Jira](jira-copilot-claude.md).

## macOS

1. Abrir **Terminal** o la terminal integrada de VS Code.
2. Si ya tienes [Homebrew](https://brew.sh/), instalar `uv`:

   ```sh
   brew install uv
   ```

   Si no tienes Homebrew, consultar el [instalador oficial de uv](https://docs.astral.sh/uv/getting-started/installation/) y seleccionar macOS. No es obligatorio instalar Homebrew.
3. Cerrar y abrir una terminal nueva. Comprobar la instalación:

   ```sh
   uv --version
   uvx --version
   ruby --version
   ```

   Cada comando debe mostrar una versión. Si Ruby no está disponible, instalarlo siguiendo [la guía oficial de Ruby](https://www.ruby-lang.org/es/documentation/installation/) y volver a comprobarlo.

## Windows

1. Abrir **PowerShell** o la terminal integrada de VS Code con PowerShell.
2. Si tienes **WinGet**, instalar `uv`:

   ```powershell
   winget install --id=astral-sh.uv -e
   ```

   Si WinGet no está disponible, consultar el [instalador oficial de uv](https://docs.astral.sh/uv/getting-started/installation/) y seleccionar Windows. En equipos administrados, pedir ayuda si la política de instalación lo requiere.
3. Instalar Ruby con [RubyInstaller para Windows](https://rubyinstaller.org/downloads/), seleccionando la arquitectura de tu equipo. Durante la instalación, habilitar la opción de añadir Ruby al PATH si se ofrece.
4. Cerrar y abrir PowerShell de nuevo. Comprobar:

   ```powershell
   uv --version
   uvx --version
   ruby --version
   ```

   Cada comando debe mostrar una versión. No se ha verificado el conector en Windows; estas instrucciones preparan sus dependencias, pero es necesario realizar la prueba de Jira de la guía.

## Si un comando no se reconoce

- Cerrar y volver a abrir la terminal y VS Code para que reciban el PATH actualizado.
- Comprobar que la instalación terminó sin errores y que el ejecutable está en el PATH del proceso que ejecuta Copilot o Claude Code.
- Seguir las instrucciones del instalador oficial o consultar al administrador del equipo. No compartir credenciales ni contenido del archivo local al pedir ayuda.

## Continuar con Jira

Abrir la carpeta del proyecto en VS Code o Claude Code y seguir [la configuración de Jira](jira-copilot-claude.md). Al iniciar el servidor por primera vez, `uvx` necesita acceso de red para descargar el servidor fijado y sus dependencias. Revisar la solicitud de confianza: es software de terceros que recibe las credenciales de Jira. La instalación de `uvx` por sí sola no comprueba la conexión.