# Flujo SDD: de la historia a la entrega

Este flujo es compartido con Copilot y Claude Code: leer también `docs/marco-sdd.md`. Las specs se guardan en `specs/<nombre>/`. Los ejemplos de agentes son roles, no traspasos automáticos.

## 0. Preparación

Definir producto, responsables, stack y convenciones en la documentación del proyecto; si todavía no se conocen, dejarlos pendientes. Conectar Jira según la guía cuando exista un sitio autorizado. Seleccionar una iniciativa y un nombre de spec estable. Las aprobaciones son humanas y se registran en la spec; los agentes no se invocan entre sí automáticamente.

## 1. Leer la historia y evaluar DoR

**Agentes:** `jira-analista` y después `producto-historias`.

Leer el ticket o recibir la necesidad. `jira-analista` resume la historia y las referencias relacionadas que pueda leer. `producto-historias` evalúa la historia contra el DoR acordado e informa criterio por criterio: cumple, no cumple, o no verificable. También enumera ambigüedades, preguntas, dependencias y sugerencias de corrección. Todavía no crea la spec de requisitos mientras existan bloqueos de DoR.

**Definition of Ready sugerida:** historia entendible y acotada; criterios medibles; dependencias y reglas identificadas; preguntas críticas resueltas; responsable de producto aprueba requisitos. No exigir métricas inventadas: marcar pendientes y consultar.

**Prompt:** «Analiza NOVUS-24 contra el DoR acordado. Devuelve una matriz de cada criterio con estado y evidencia, lista ambigüedades/preguntas y busca relaciones relevantes; no crees aún `requirements.md` y no modifiques Jira».

## 2. Resolver DoR y crear el primer borrador de spec

Si el DoR **no se cumple**, guardar únicamente los hallazgos y sus IDs en `.sdd-state/reviews/<clave-jira-en-minusculas>.md`. El usuario responde o corrige la historia mediante el canal de Jira que tenga autorizado. Como el MCP de este proyecto es de solo lectura, el agente no puede aplicar la corrección en Jira: puede preparar el texto sugerido para que una persona lo actualice. Luego se vuelve a consultar la historia y se verifica cada observación anterior contra el contenido actualizado. Se repite hasta que los criterios bloqueantes cumplan; respuestas en el chat no cuentan como corrección de Jira.

Cuando el DoR **se cumple**, `producto-historias` crea `specs/<nombre>/requirements.md` como borrador inicial de la spec a partir de la historia vigente. Incluye la fuente Jira, historia, criterios de aceptación, requisitos EARS, supuestos, preguntas abiertas y trazabilidad, sin añadir respuestas no confirmadas. La persona responsable revisa que la spec represente correctamente la historia y aprueba los requisitos. Si al revisarlos aparecen huecos nuevos, se corrige el borrador o se registra temporalmente; no se pasa a diseño hasta aprobarlos.

**Prompt al cumplir DoR:** «La historia NOVUS-24 ya cumple el DoR según la verificación actual. Crea `specs/novus-24/requirements.md` como borrador fiel a Jira, con IDs y trazabilidad. No inventes detalles; separa preguntas abiertas y detente para que revise y apruebe los requisitos. No escribas en Jira».

### Guardar temporalmente hallazgos del DoR y revisar correcciones

El análisis en el chat **no se guarda automáticamente como archivo**. Al terminar la evaluación del DoR con bloqueos, crear `.sdd-state/reviews/<clave-jira-en-minusculas>.md` (por ejemplo, `.sdd-state/reviews/novus-24.md`) usando [la plantilla](plantillas/revision.md). Para una idea sin clave Jira, usar un nombre corto y estable. El directorio `.sdd-state/` está excluido de Git: el registro queda visible en el workspace local, pero no se comparte con el repositorio.

Cada observación conserva un ID, fuente, respuesta, estado y evidencia. En una sesión posterior, indicar al agente la ruta del archivo y pedirle que contraste cada observación con las correcciones actuales. Una respuesta no significa que la corrección esté aplicada: marcarla `Resuelta` solo tras comprobar el cambio con evidencia.

Mientras la historia esté pendiente, conservar el archivo y añadir nuevos hallazgos sin perder el contexto anterior. Tras la aprobación humana de requisitos, trasladar a `specs/<nombre>/requirements.md` las decisiones finales que deban mantenerse, registrar responsable y fecha de aprobación, y borrar el archivo temporal. No incluir contenido completo de Jira ni información sensible. El borrado local no elimina copias de seguridad ni el historial del chat. Las consultas Jira son fotografías: volver a consultar Jira antes de preparar cambios.

**Después del análisis inicial:** «Guarda las recomendaciones DoR que acabas de presentar en `.sdd-state/reviews/novus-24.md`, usando la plantilla de revisión. Crea la carpeta si hace falta. Registra cada observación con ID y estado inicial. No inventes respuestas, no marques nada resuelto y no modifiques Jira».

**Al retomar tras corregir:** «Retoma la historia NOVUS-24. Lee `.sdd-state/reviews/novus-24.md` y compara una por una las observaciones con el contenido actual de Jira o la spec indicada. Actualiza estados con evidencia, conserva los IDs, separa lo pendiente de lo resuelto y no hagas cambios en Jira».

**Al aprobar los requisitos:** «Con mi aprobación de requisitos, copia a `specs/novus-24/requirements.md` la historia, requisitos y decisiones finales. Registra responsable y fecha; verifica que no queden hallazgos abiertos y entonces elimina `.sdd-state/reviews/novus-24.md`. No escribas en Jira».

## 3. Diseñar

**Agente:** `arquitectura`.

Con requisitos aprobados, documentar componentes, decisiones, interfaces, datos, fallos, seguridad y estrategia de pruebas en `design.md`. Asociar cada sección relevante a requisitos y criterios. El equipo técnico aprueba el diseño antes de continuar.

**Prompt:** «Diseña la spec indicada a partir de sus requisitos aprobados. Explica alternativas y riesgos y espera aprobación».

## 4. Definir estrategia de pruebas

**Agente:** `plan-pruebas`.

Tras aprobar requisitos y diseño, preparar `plan-pruebas.md`: alcance, estrategia funcional y no funcional, niveles, tipos de prueba, entornos, riesgos, dependencias y criterios de entrada/salida. Este documento define la estrategia, **no los casos detallados**. Revisar y aprobarlo.

**Prompt:** «Define el plan de pruebas funcionales y no funcionales para `specs/novus-24/` usando los requisitos y diseño aprobados. Define alcance, niveles, tipos, estrategia, entornos y riesgos; no redactes casos individuales. Detente para aprobación».

## 5. Descomponer en tareas

**Agente:** `arquitectura`.

Crear `tasks.md` con tareas pequeñas, dependencias, resultados esperados y referencias a requisitos y criterios. Incorporar la estrategia aprobada como criterio de trabajo. Revisar y aprobar las tareas antes de implementarlas.

**Prompt:** «Descompón el diseño y los requisitos aprobados en tareas trazables con dependencias. Incluye la estrategia de pruebas aprobada como insumo y espera mi aprobación».

## 6. Diseñar los casos de prueba

**Agente:** `diseno-casos-prueba`.

Con plan de estrategia y tareas aprobados, inventariar pruebas del repositorio y casos/vínculos accesibles en Jira o en el gestor de pruebas disponible. Evaluar validez antes de reutilizar; diseñar casos nuevos solo para brechas. Guardar `casos-prueba.md`, separado del plan. Usar técnicas adecuadas a cada regla y riesgo: equivalencia, límites, estados, tablas de decisión y combinatoria cuando haya interacciones relevantes. El equipo revisa y aprueba el diseño de casos. No ejecutar las pruebas ni crear casos en Jira.

**Prompt:** «Para `specs/novus-24/`, usando el plan de pruebas y las tareas aprobadas, inventaría casos existentes en el repo y en Jira/gestor accesible. Evalúa cuáles se reutilizan, ajustan, están obsoletos o no son verificables; no declares ausencia si no hubo acceso. Diseña los casos faltantes en `casos-prueba.md`, trazados a componentes, flujos, HU/CA/REQ/T. Elige y justifica técnicas; para combinatoria registra factores, restricciones, fuerza y validación del conjunto. Espera aprobación; no ejecutes ni escribas en Jira».

El MCP actual es de solo lectura; consultar los casos existentes no permite crear ni actualizar casos en Jira. No inventar accesibilidad a Xray, Zephyr u otras herramientas: si no se pueden consultar, pedir una exportación o referencia autorizada y marcar esa cobertura como no verificada.

## 7. Implementar

**Agente:** `desarrollo`.

Ejecutar tareas aprobadas en secuencia de dependencias, añadir pruebas y ejecutar comprobaciones pertinentes. Actualizar los checkboxes solo con evidencia. Anotar desviaciones o bloqueos; elevar cambios de alcance para aprobación.

**Prompt:** «Implementa la primera tarea aprobada de esta spec, ejecuta las pruebas disponibles y presenta evidencia».

## 8. Validar y cerrar

**Agente:** `calidad`, seguido por `jira-analista`.

Revisar cada criterio y prueba, incluidos escenarios de error y riesgos pertinentes. Presentar resultados reales y evidencia, diferenciando aprobada, fallida y no ejecutada. Una persona decide la aceptación. Con esa decisión, `jira-analista` puede proponer comentario, enlace o transición en Jira, verificando el estado y solicitando confirmación antes de cualquier escritura.

**Definition of Done sugerida:** criterios verificados con evidencia; pruebas pertinentes ejecutadas o limitaciones aceptadas; revisión humana realizada; documentación actualizada; riesgos conocidos comunicados; Jira actualizado solo si se autorizó y la operación tuvo éxito.

## Trazabilidad y conflictos

| Jira | Historia | Criterio | Requisito | Tarea | Prueba/evidencia | Resultado |
| --- | --- | --- | --- | --- | --- | --- |
| Clave real o pendiente | HU-01 | CA-01 | REQ-01 | T-01 | Identificador o enlace real | Pendiente / aprobada / fallida / no ejecutada |

Usar identificadores estables dentro de cada spec. Si cambian criterios o estado en Jira y contradicen la spec, mostrar ambas versiones y detenerse hasta que el responsable decida. Registrar la decisión, actualizar los artefactos afectados y solicitar aprobación de nuevo cuando cambie el alcance.