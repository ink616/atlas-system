@echo off
chcp 65001 >nul
title Atlas QA - CP-SEG-14-secretos
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-SEG-14-secretos ^| Revision de secretos en codigo y configuracion
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
findstr /n /i "PASSWORD SECRET" backend\.env docker-compose.yml backend\config\db.js backend\middleware\auth.js backend\routes\auth.routes.js
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
