@echo off
chcp 65001 >nul
title Atlas QA - CP-FUN-02
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-FUN-02 ^| Inicio de sesion con credenciales invalidas
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@atlas.cl\",\"password\":\"Incorrecta1!\"}"
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"noexiste@atlas.cl\",\"password\":\"Password123!\"}"
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"\",\"password\":\"\"}"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
