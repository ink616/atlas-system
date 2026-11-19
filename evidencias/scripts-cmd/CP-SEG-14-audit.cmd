@echo off
chcp 65001 >nul
title Atlas QA - CP-SEG-14-audit
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-SEG-14-audit ^| Analisis de dependencias (npm audit)
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
cd /d "%ATLAS_AUDIT%\audit-backend"
call npm audit
@echo on
cd /d "%ATLAS_AUDIT%\audit-frontend"
call npm audit
@echo on
cd /d D:\descargas\atlas-system
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
