@echo off
chcp 65001 >nul
title Atlas QA - CP-SEG-08
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-SEG-08 ^| Aislamiento de datos entre empresas (IDOR)
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@empresados.cl\",\"password\":\"1\"}" -o "%TEMP%\tok_EMPRESA2.json"
for /f "usebackq delims=" %%t in (`node -p "require(process.env.TEMP+'/tok_EMPRESA2.json').token"`) do set EMPRESA2=%%t
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/clientes -H "Authorization: Bearer %EMPRESA2%"
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/contratos -H "Authorization: Bearer %EMPRESA2%"
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/auditoria -H "Authorization: Bearer %EMPRESA2%"
curl -s -w "\n-> HTTP %%{http_code}\n" -X DELETE http://localhost:5000/api/clientes/25 -H "Authorization: Bearer %EMPRESA2%"
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/contratos/25/documentos -H "Content-Type: application/json" -H "Authorization: Bearer %EMPRESA2%" -d "{}"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
