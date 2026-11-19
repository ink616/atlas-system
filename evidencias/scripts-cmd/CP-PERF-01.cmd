@echo off
chcp 65001 >nul
title Atlas QA - CP-PERF-01
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-PERF-01 ^| Tiempo de respuesta CRUD bajo carga normal (k6, 10 VUs, 1 min)
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
docker run --rm --network container:atlas-backend -v "%cd%\evidencias:/scripts:ro" grafana/k6:0.54.0 run --quiet /scripts/perf01-crud.js
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
