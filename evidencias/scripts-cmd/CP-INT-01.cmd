@echo off
chcp 65001 >nul
title Atlas QA - CP-INT-01
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-INT-01 ^| Documentacion Swagger de la API
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/docs
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/docs
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/swagger
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
