# Plan de mantenimiento y aseguramiento continuo — Atlas (EP3 ISY1102)

Este documento acompaña al informe EP3. Define cómo se preserva la **calidad, la
seguridad y el cumplimiento normativo** de Atlas a lo largo del ciclo de vida, y cómo
los controles automatizados del pipeline (`.github/workflows/devsecops.yml`) lo sostienen.

## 1. Controles automatizados (pipeline DevSecOps)

| Etapa | Control | Herramienta | Previene / norma |
|-------|---------|-------------|------------------|
| SOURCE | Escaneo de secretos | gitleaks | DEF-007 · OWASP A05 / ISO 27001 |
| BUILD | Análisis de dependencias (SCA) | npm audit | DEF-008 · OWASP A06 / Ley 17.336 |
| TEST | Automatización funcional + API | Cypress + Newman | Regresión RF-1..RF-6 · ISO 25010 |
| SEGURIDAD | SAST + DAST | Semgrep + OWASP ZAP | DEF-005/003 · OWASP Top 10 / Ley 19.628-21.719 |
| DEPLOY | Gate de calidad | — | No desplegar con críticos abiertos |

## 2. Mantenimiento de la calidad
- Ejecutar la suite automatizada (`tests/automation/`) en cada cambio (regresión).
- Mantener la matriz de trazabilidad del ERS al 100% cuando cambien los requerimientos.
- Code review obligatorio antes de integrar a `main`.

## 3. Mantenimiento de la seguridad
- Semgrep y npm audit programados (CI) para detectar nuevas vulnerabilidades.
- Rotación de `JWT_SECRET` y credenciales de BD fuera del repositorio.
- Respaldo periódico de la base de datos y prueba de restauración.
- Revisión de logs de auditoría ante incidentes, sin exponer datos sensibles.

## 4. Mantenimiento del cumplimiento normativo
- Ley 19.628 / 21.719: cifrado de datos bancarios (remediación DEF-005) y notificación de brechas.
- Ley 21.663: procedimiento de respuesta a incidentes.
- Ley 17.336: auditoría de licencias de dependencias en cada actualización mayor.
- WCAG (NFR-USAB): pruebas de accesibilidad en cada versión mayor.

## 5. Priorización de la remediación
1. **Crítico** — DEF-005 (datos bancarios en texto plano): cifrar en reposo. *Antes de liberar.*
2. **Grave** — DEF-003 (editor con escritura), DEF-001/002 (sesión y contraseñas), DEF-007 (secretos). *Iteración inmediata.*
3. **Grave** — DEF-010/012 (funciones faltantes). *Siguiente iteración.*
4. **Moderado/Leve** — DEF-004/006/008/009/011/013/014. *Según disponibilidad.*

> Las pruebas de seguridad se ejecutan solo en entorno local autorizado, con datos
> sintéticos (Ley 21.459). «Si no hay foto, no pasó»: toda evidencia se captura al momento.
