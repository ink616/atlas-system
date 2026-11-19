@echo off
chcp 65001 >nul
title Atlas QA - CP-PERF-03
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-PERF-03 ^| Soporte de 200 usuarios concurrentes (k6 tests/load-test.js)
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
docker run --rm --network container:atlas-backend -v "%cd%\tests:/scripts:ro" grafana/k6:0.54.0 run --quiet /scripts/load-test.js
docker compose ps
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
