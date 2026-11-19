@echo off
chcp 65001 >nul
title Atlas QA - CP-FUN-09
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-FUN-09 ^| Rol editor restringido a solo lectura
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"editor@atlas.cl\",\"password\":\"Password123!\"}" -o "%TEMP%\tok_EDITOR.json"
for /f "usebackq delims=" %%t in (`node -p "require(process.env.TEMP+'/tok_EDITOR.json').token"`) do set EDITOR=%%t
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/clientes -H "Content-Type: application/json" -H "Authorization: Bearer %EDITOR%" -d "{\"rut\":\"77.444.555-6\",\"razon_social\":\"Cliente creado por Editor (captura)\"}"
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/contratos/25/documentos -H "Content-Type: application/json" -H "Authorization: Bearer %EDITOR%" -d "{}"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
