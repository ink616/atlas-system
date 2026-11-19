@echo off
chcp 65001 >nul
title Atlas QA - CP-FUN-05
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-FUN-05 ^| Registro con contrasena fuera de politica
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/empresas -H "Content-Type: application/json" -d "{\"nombre\":\"Empresa Captura SpA\",\"rut\":\"76.000.020-5\",\"direccion\":\"Calle QA 20\",\"correo\":\"admin@capturas.cl\",\"usuario_admin\":\"Admin Captura\",\"password\":\"1\"}"
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@capturas.cl\",\"password\":\"1\"}"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
