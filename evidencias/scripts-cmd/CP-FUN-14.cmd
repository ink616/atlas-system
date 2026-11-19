@echo off
chcp 65001 >nul
title Atlas QA - CP-FUN-14
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-FUN-14 ^| Validacion de formato en campos de cliente
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@atlas.cl\",\"password\":\"Password123!\"}" -o "%TEMP%\tok_TOKEN.json"
for /f "usebackq delims=" %%t in (`node -p "require(process.env.TEMP+'/tok_TOKEN.json').token"`) do set TOKEN=%%t
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/clientes -H "Content-Type: application/json" -H "Authorization: Bearer %TOKEN%" -d "{\"rut\":\"XYZ-CAPT\",\"razon_social\":\"RUT letras (captura)\"}"
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/clientes -H "Content-Type: application/json" -H "Authorization: Bearer %TOKEN%" -d "{\"rut\":\"11.222.333-0\",\"razon_social\":\"RUT DV malo (captura)\"}"
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/clientes -H "Content-Type: application/json" -H "Authorization: Bearer %TOKEN%" -d "{\"rut\":\"1234567890123\",\"razon_social\":\"RUT largo\"}"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
