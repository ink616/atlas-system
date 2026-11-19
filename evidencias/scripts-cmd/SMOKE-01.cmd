@echo off
chcp 65001 >nul
title Atlas QA - SMOKE-01
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  SMOKE-01 ^| Contenedores Atlas levantados
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
docker compose ps
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
