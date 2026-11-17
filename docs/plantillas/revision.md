# Registro temporal de revisión: <funcionalidad>

> Plantilla para el archivo local `.sdd-state/reviews/<clave-o-slug>.md`. `.sdd-state/` está ignorado por Git. No es memoria automática ni un ticket de Jira. Eliminar este registro después de aprobar requisitos y trasladar las decisiones finales necesarias a `requirements.md`.

- Spec y versión o fecha revisada: <ruta y versión/fecha reales>
- Jira: <clave y enlace reales, o pendiente>
- Última revisión: <fecha real y responsable>

## Hallazgos

Conservar los identificadores aunque se resuelva un hallazgo. Añadir filas o entradas; no borrar el historial. No incluir credenciales, datos sensibles ni respuestas de Jira completas innecesarias.

| ID | Fuente y referencia | Observación | Respuesta o decisión | Estado | Evidencia y última verificación |
| --- | --- | --- | --- | --- | --- |
| OBS-01 | <archivo/sección o clave Jira> | <ambigüedad concreta> | <respuesta acordada o pendiente> | Abierta | <referencia o pendiente> |

**Estados:** `Abierta` = falta una respuesta; `Corrección propuesta` = hay respuesta o texto propuesto, pero no se verificó en la spec; `Resuelta` = se comprobó la corrección en el documento vigente y se registró la evidencia; `Reabierta` = una revisión posterior detectó que ya no se cumple. Una respuesta no convierte automáticamente el hallazgo en resuelto. Si no se puede comprobar, mantenerlo pendiente y explicar por qué.

## Historial mientras está pendiente

| Fecha | Versión revisada | Resumen | Pendientes |
| --- | --- | --- | --- |
| <fecha> | <referencia real> | <cambios y comprobaciones realizadas> | <IDs abiertos> |

## Contexto consultado en Jira

Registrar solo si está autorizado y es necesario: sitio/proyecto, clave y fecha de consulta; evitar copiar la historia completa. Esta información es una fotografía, no se actualiza sola; volver a consultar Jira antes de proponer cambios. Al aprobar, conservar en el spec solo las decisiones finales necesarias y borrar este archivo temporal.