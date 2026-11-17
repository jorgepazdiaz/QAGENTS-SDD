# Jira Cloud con Copilot y Claude Code

Esta opción emplea **mcp-atlassian de sooperset**, un servidor de terceros ejecutado localmente que consulta la API de Jira Cloud. Revisar y aprobar su código, licencia y política de la organización antes de usarlo: recibe el token y puede acceder a los datos del usuario. La versión está fijada a `0.24.0`; revisarla antes de actualizarla. El repositorio no incluye el paquete: `uvx` lo descarga al primer inicio, junto con sus dependencias. Se requiere acceso de red y `uvx` instalado en el PATH del proceso que ejecuta el asistente; también Ruby disponible en PATH para el lanzador.

## 1. Credenciales locales

El token compartido previamente en el chat debe revocarse. Crear uno nuevo para Jira Cloud con permisos mínimos necesarios y usar una cuenta de solo lectura cuando sea posible. El token de Jira REST puede tener requisitos/scopes diferentes a uno destinado al servidor MCP oficial.

Abrir el `.env` local en el editor, sin compartirlo en el chat ni subirlo a Git. **Añadir o editar estas tres líneas exactamente una vez**; sustituir los ejemplos por los datos reales:

```dotenv
JIRA_URL=https://tu-sitio.atlassian.net
JIRA_USERNAME=tu-correo-de-atlassian
JIRA_API_TOKEN=tu-token-nuevo
```

- `JIRA_URL`: URL del sitio, sin el proyecto ni rutas adicionales.
- `JIRA_USERNAME`: correo de la cuenta dueña del token, no el nombre de usuario de Jira.
- `JIRA_API_TOKEN`: el token nuevo, directamente; no requiere Base64 ni comas.
- La clave del proyecto, por ejemplo `PROY`, se indica al agente cuando se consulte una historia; no es necesaria para autenticar.

No guardar valores reales en `.env.example`. `ATLASSIAN_BASIC_AUTH`, `JIRA_BASE_URL` y `JIRA_EMAIL` son variables de la configuración anterior y **no se usan en esta conexión**. Si ya hay otras líneas en tu archivo, conservarlas; no dejar claves duplicadas. El lector acepta valores simples o entre comillas sencillas/dobles sin escapes ni sustituciones, no interpreta comentarios al final de la línea y no ejecuta el archivo. No usar `source` para esta integración.

El archivo local está excluido por `.gitignore`, pero sigue siendo un secreto en texto plano y debe protegerse contra acceso local y copias compartidas. En macOS restringir sus permisos al usuario desde Finder o una terminal. No mostrar el archivo, el token ni cabeceras en capturas o chats. Si se filtra o se versiona, revocar el token; borrar el archivo no lo invalida.

## 2. Activar y comprobar

1. Instalar `uv`/`uvx` y comprobar Ruby siguiendo las [instrucciones para macOS y Windows](instalacion-uv.md). Si VS Code ya estaba abierto antes de instalarlo, cerrarlo y abrirlo de nuevo para que herede el PATH. El servidor requiere Ruby y `uvx` disponibles para el proceso cliente.
2. Revisar `scripts/jira-mcp.rb`: el lanzador lee solo las tres variables nombradas del `.env` de este proyecto, exige URL HTTPS de Jira Cloud, fija `READ_ONLY_MODE=true` y arranca la versión fijada del servidor sin imprimir credenciales. Para encontrar el script, abrir el proyecto como carpeta raíz en VS Code. El archivo `.env` no se debe cargar con `source`.
3. **Si la barra de personalizaciones dice “Local”** —como en la captura compartida— VS Code debe leer `.vscode/mcp.json`. Este archivo usa la forma `servers`. Abre **Chat: Open Customizations → MCP Servers** en la sesión Local y busca `jira` en **Workspace**. Guarda el archivo y crea un chat nuevo; si sigue sin aparecer, cierra y vuelve a abrir VS Code.
4. **Si seleccionaste el entorno Copilot**, este usa el archivo portable `.mcp.json` de la raíz, que contiene `mcpServers`. Abre **Chat: Open Customizations → MCP Servers** en el entorno Copilot y comprueba la sección de proyecto/workspace. No uses el panel Local para verificar la configuración nativa de Copilot: son destinos MCP distintos.
5. **Claude Code:** iniciar Claude desde la raíz del proyecto, confiar en el workspace y aprobar la configuración MCP del proyecto cuando lo solicite. Usar `/mcp` para ver el estado de `jira`. Si ya estaba abierto antes de agregar o modificar configuración, crear una sesión nueva.
6. Probar una lectura real: con `jira-analista`, solicitar «Usa la herramienta MCP `jira` para leer NOVUS-24 y resume el título y estado. No modifiques Jira». Confirmar que el agente hizo una llamada de herramienta `jira` y que el resultado coincide con Jira. Una respuesta sin llamada a herramienta no prueba la conexión.

Si un agente contesta que no tiene conexión, primero confirma que estás en el mismo destino MCP que configuraste (**Local** con `.vscode/mcp.json`; **Copilot** con `.mcp.json`). En la vista MCP comprueba que `jira` sea un servidor **Workspace** y que sus herramientas aparezcan, no solo un servidor bajo **Built-In**. Después abre un chat nuevo con `jira-analista` y pídele explícitamente usar la herramienta MCP `jira`. Si falla, revisa el detalle/log del servidor sin compartir valores sensibles. Un error 401/403 puede indicar token, scopes, cuenta, políticas o permisos. Los agentes pueden trabajar con información facilitada manualmente si la conexión falla.

## 3. Seguridad y escritura futura

`READ_ONLY_MODE=true` pide al servidor que deshabilite escrituras, pero no cambia los permisos del token en Jira. Revisar herramientas expuestas, emplear una cuenta con mínimos permisos y evitar modos de aprobación automática. Si otro servidor MCP o una herramienta shell tiene acceso a Jira, esta restricción no se aplica a esos otros canales. Las reglas de agentes son instrucciones, no un mecanismo de seguridad infalible.

Por defecto solo se leen historias. Para escribir en Jira, primero diseñar y habilitar un canal separado con permisos apropiados, confirmar su comportamiento y exigir vista previa y aprobación explícita por operación o lote. No hay sincronización automática ni se habilita escritura en esta configuración.

Referencias: [mcp-atlassian: configuración](https://mcp-atlassian.soomiles.com/docs/configuration), [Copilot: MCP](https://code.visualstudio.com/docs/agents/reference/mcp-configuration), [Claude Code: MCP](https://code.claude.com/docs/en/mcp).