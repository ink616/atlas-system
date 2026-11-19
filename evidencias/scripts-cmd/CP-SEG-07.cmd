@echo off
chcp 65001 >nul
title Atlas QA - CP-SEG-07
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-SEG-07 ^| Proteccion CSRF y politica CORS
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -i -o NUL -D - http://localhost:5000/api/health
curl -s -D - -o NUL -X OPTIONS http://localhost:5000/api/clientes/25 -H "Origin: http://sitio-externo.test" -H "Access-Control-Request-Method: DELETE" -H "Access-Control-Request-Headers: authorization"
curl -s -D - -o NUL http://localhost:3000/
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
