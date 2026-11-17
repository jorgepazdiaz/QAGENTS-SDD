# Marco de desarrollo guiado por especificaciones

Un marco propio para convertir necesidades de producto o historias de Jira en especificaciones, código y pruebas verificables. Funciona con agentes de GitHub Copilot y Claude Code. No presupone un lenguaje ni un framework.

## Uso con Copilot o Claude Code

1. Consultar [el marco SDD](docs/marco-sdd.md), [el flujo completo](docs/flujo-sdd.md) y [la configuración de Jira](docs/jira-copilot-claude.md).
2. Configurar el archivo local de credenciales para Jira y revisar el servidor MCP de terceros. Está limitado a lectura y no se ha verificado con tu cuenta.
3. En Copilot, seleccionar un agente del proyecto en el selector del chat. En Claude Code, pedir que use el subagente por nombre o seleccionarlo con `--agent`. Puede ser necesario abrir una sesión nueva tras crear los agentes.
4. Empezar con `jira-analista` si existe un ticket, o con `producto-historias` si partes de una idea. Continuar con `arquitectura`, `plan-pruebas` (estrategia), `arquitectura` (tareas), `diseno-casos-prueba` (casos), `desarrollo` y `calidad`, revisando y aprobando cada fase.
5. Las specs aprobadas se guardan bajo [specs/](specs/README.md). Mientras la historia esté en revisión, las observaciones temporales quedan en `.sdd-state/reviews/` (local, ignorado por Git); se borran tras aprobar los requisitos y trasladar las decisiones finales al spec.

El proyecto incluye un servidor Jira en modo lectura; crear o modificar tickets requiere configurar por separado un canal de escritura, revisar los cambios y obtener confirmación explícita. Ni las instrucciones ni un indicador de servidor activo sustituyen una prueba de lectura.

## Flujo paso a paso

| Etapa | Agente | Resultado y control humano |
| --- | --- | --- |
| 1. Origen | `jira-analista` | Lee el ticket y señala información faltante; no modifica Jira. |
| 2. DoR | `producto-historias` | Evalúa criterios; si hay bloqueos, guarda observaciones temporales. Si pasa, crea el borrador de requisitos. |
| 3. Requisitos | `producto-historias` | Genera `requirements.md`; producto revisa la fidelidad y aprueba antes de diseñar. |
| 4. Diseño | `arquitectura` | Diseña sobre requisitos aprobados; el equipo revisa. |
| 5. Estrategia de pruebas | `plan-pruebas` | Define plan funcional/no funcional, tipos, niveles, alcance y riesgos. |
| 6. Tareas | `arquitectura` | Descompone en tareas trazables; el equipo aprueba. |
| 7. Diseño de casos | `diseno-casos-prueba` | Inventaría casos existentes; reutiliza/ajusta y diseña faltantes con técnicas justificadas. |
| 8. Desarrollo | `desarrollo` | Implementa tareas aprobadas con pruebas y evidencia. |
| 9. Validación | `calidad` | Contrasta cada criterio y caso con resultados/evidencia. |
| 10. Jira | `jira-analista` | Prepara propuestas; el servidor configurado no permite escribir. |

Cada funcionalidad se ubica en una carpeta propia dentro de [specs/](specs/README.md). Las [plantillas](docs/plantillas/requirements.md) son guías para copiar, no especificaciones activas. Revisar cada fase antes de avanzar.

Para retomar observaciones DoR entre sesiones, se usa `.sdd-state/reviews/<clave-jira>.md`, un archivo local excluido de Git. Al aprobar requisitos, se trasladan al spec las decisiones finales necesarias y se elimina el registro temporal. Consulta [el procedimiento](docs/flujo-sdd.md) y [la plantilla](docs/plantillas/revision.md). No es memoria automática ni se sincroniza con Jira.

## Primera historia

En Copilot o Claude Code, seleccionar `jira-analista` y escribir: «Lee la historia PROY-123 en el sitio y proyecto que te indique. Resume su objetivo, criterios y dudas sin modificar Jira». Sustituir `PROY-123` por una clave real. Luego usar `producto-historias` y pedir: «Con la historia revisada, crea los requisitos de una spec y detente para aprobación». Entregar a cada agente la ruta de la spec y la clave Jira.

Si Jira todavía no está disponible, compartir la descripción sin datos sensibles e iniciar con `producto-historias`. No inventar claves, estados, decisiones, ni resultados de pruebas.

## Material de referencia

- [Flujo detallado y reglas de trazabilidad](docs/flujo-sdd.md)
- [Instalación de uv y uvx en macOS y Windows](docs/instalacion-uv.md)
- [Conexión Jira mediante token](docs/jira-copilot-claude.md)
- [Plantilla de requisitos e historias](docs/plantillas/requirements.md)
- [Plantilla de diseño](docs/plantillas/design.md)
- [Plantilla de tareas](docs/plantillas/tasks.md)
- [Plantilla de plan de pruebas](docs/plantillas/plan-pruebas.md)
- [Plantilla de diseño de casos de prueba](docs/plantillas/casos-prueba.md)