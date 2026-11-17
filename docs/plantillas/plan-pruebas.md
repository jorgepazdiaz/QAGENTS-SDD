# Plan de pruebas: <funcionalidad>

> Plantilla: completar tras aprobar requisitos; actualizar cuando el diseño cambie. Una prueba planificada no se considera ejecutada.

- Estado y aprobación: borrador / aprobado; responsable y fecha: pendiente.
- Spec, versión y Jira: pendiente.
- Alcance y exclusiones: pendiente.
- Entornos, datos ficticios, permisos y dependencias: pendiente.
- Componentes, interfaces y flujos afectados: pendiente; anotar fuentes revisadas y límites de la inspección.
- Estrategia: niveles unitario, integración, aceptación y no funcionales pertinentes; sin asumir herramientas.
- Criterios de entrada, salida, riesgos y bloqueos: pendiente.

## Inventario de casos y pruebas existentes

Buscar pruebas automatizadas y fixtures en el repositorio, así como casos/issues/vínculos de prueba en Jira y test management solo si está accesible. Revisar contenido y aserciones; el nombre del archivo o del ticket no demuestra cobertura.

| ID / referencia | Fuente y componente / flujo | CA / REQ cubiertos | Evaluación | Reutilización, ajuste o motivo |
| --- | --- | --- | --- | --- |
| EXIST-01 | Pendiente | Pendiente | No verificado | Pendiente |

**Evaluación:** reutilizable / ajuste necesario / obsoleto / no verificado / no accesible. Registrar los sistemas o carpetas que no se pudieron consultar; no declarar ausencia de pruebas sin comprobarlo.

## Técnicas de diseño aplicadas

Seleccionar solo las pertinentes y justificar brevemente su elección.

| Técnica | Factores, clases, límites o estados | Casos generados/reutilizados | Justificación y límites |
| --- | --- | --- | --- |
| Partición de equivalencia / valores límite / transición de estados / tabla de decisión / combinatoria / otra | Pendiente | Pendiente | Pendiente |

Para pruebas combinatorias, documentar factores y valores, restricciones, fuerza de interacción (pairwise/t-wise), método o generador (IPOG, greedy/AETG/Jenny, metaheurístico como GA/SA, array ortogonal u otro), versión/configuración si aplica y validación de combinaciones. No presentar el nombre de un algoritmo como evidencia de ejecución o cobertura. Añadir explícitamente casos críticos de negocio, límites y seguridad que el muestreo combinatorio podría no cubrir.

## Casos de prueba nuevos o ajustados

| ID | Origen | Componente / flujo | Historia / criterio / requisito / tarea | Técnica | Escenario y precondición | Pasos y datos | Resultado esperado | Prioridad | Estado y evidencia |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CP-01 | Nuevo/ajustado: referencia | Pendiente | HU-01 / CA-01 / REQ-01 / T-01 | Pendiente | Pendiente | Pendiente | Pendiente | Pendiente | No ejecutado |

Añadir escenarios positivos, negativos, límites, accesibilidad y seguridad cuando apliquen. No usar datos sensibles. Registrar por qué se agrega un caso para evitar duplicados.

## Matriz de cobertura

| Componente / flujo | Historia | Criterio | Requisito | Tarea | Caso existente o CP | Estado de cobertura y evidencia |
| --- | --- | --- | --- | --- | --- | --- |
| Pendiente | HU-01 | CA-01 | REQ-01 | T-01 | CP-01 | Propuesto; no ejecutado |

Registrar explícitamente criterios sin cobertura, decisiones abiertas y pruebas no ejecutadas; no afirmar éxito sin ejecución.