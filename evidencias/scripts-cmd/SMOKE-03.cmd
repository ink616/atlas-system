@echo off
chcp 65001 >nul
title Atlas QA - SMOKE-03
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  SMOKE-03 ^| Health check de la API
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/health
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
