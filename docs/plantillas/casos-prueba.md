# Diseño de casos de prueba: <funcionalidad>

> Artefacto distinto de `plan-pruebas.md`: este documento inventaría pruebas existentes y define casos concretos. Completar usando el plan de estrategia aprobado. Los casos diseñados no se consideran ejecutados.

- Estado y aprobación del diseño: borrador / aprobado; responsable y fecha: pendiente.
- Spec, versión y Jira: pendiente.
- Plan de estrategia de referencia: `plan-pruebas.md`.

## Componentes y flujos analizados

| Componente / interfaz / flujo | Fuente revisada | Criterios relacionados | Límites o dudas de inspección |
| --- | --- | --- | --- |
| Pendiente | Pendiente | CA-01 / REQ-01 | Pendiente |

## Inventario de pruebas existentes

| ID / referencia | Fuente (repo/Jira/gestor) | Componente / flujo | HU / CA / REQ cubiertos | Estado | Acción y justificación |
| --- | --- | --- | --- | --- | --- |
| EXIST-01 | Pendiente | Pendiente | Pendiente | No verificado | Pendiente |

Estados: `Reutilizable`, `Ajuste necesario`, `Obsoleto`, `No verificado`, `No accesible`. No afirmar ausencia de casos en herramientas a las que no se tuvo acceso.

## Técnicas seleccionadas

| Técnica | Aplicación/factores | Restricciones y riesgo | Casos CP | Justificación / validación |
| --- | --- | --- | --- | --- |
| Equivalencia / límites / estados / decisión / combinatoria / otra | Pendiente | Pendiente | Pendiente | Pendiente |

Para combinatoria registrar factores y valores, exclusiones/restricciones, fuerza pairwise/t-wise, método (IPOG, greedy/AETG/Jenny, metaheurístico GA/SA, array ortogonal u otro) y cómo se verificaron las combinaciones. No incluir métricas de cobertura no comprobadas; detallar aparte combinaciones críticas y límites fuera del muestreo.

## Casos nuevos o ajustados

| CP ID | Origen (nuevo/ajuste y referencia) | Componente / flujo | HU / CA / REQ / tarea | Técnica | Precondiciones y datos ficticios | Pasos | Resultado esperado | Prioridad |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CP-01 | Nuevo / pendiente | Pendiente | HU-01 / CA-01 / REQ-01 / T-01 | Pendiente | Pendiente | Pendiente | Pendiente | Pendiente |

Redactar los casos en lenguaje claro y con campos estructurados. Gherkin (`Dado / Cuando / Entonces`) es opcional y suele ser útil para aceptación y comportamiento visible al usuario; no es requisito para pruebas técnicas. Los pasos deben producir resultados observables y aserciones concretas.

## Matriz de cobertura y estado de ejecución

| Componente / flujo | HU | CA | REQ | Tarea | Caso existente / CP | Cobertura y evidencia |
| --- | --- | --- | --- | --- | --- | --- |
| Pendiente | HU-01 | CA-01 | REQ-01 | T-01 | CP-01 | Diseñado; no ejecutado |

Listar brechas, decisiones abiertas y pruebas no diseñadas. La ejecución y resultado pertenecen al reporte de `calidad`; no marcar como pasada una prueba solo porque figure en este documento.