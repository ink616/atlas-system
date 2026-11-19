@echo off
chcp 65001 >nul
title Atlas QA - CP-FUN-12
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-FUN-12 ^| Listado con paginacion y filtros; edicion
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@atlas.cl\",\"password\":\"Password123!\"}" -o "%TEMP%\tok_TOKEN.json"
for /f "usebackq delims=" %%t in (`node -p "require(process.env.TEMP+'/tok_TOKEN.json').token"`) do set TOKEN=%%t
curl -s -w "\n-> HTTP %%{http_code}\n" -X PUT http://localhost:5000/api/clientes/25 -H "Authorization: Bearer %TOKEN%" -H "Content-Type: application/json" -d "{\"razon_social\":\"Editado\"}"
curl -s "http://localhost:5000/api/clientes?page=1&limit=2&nombre=Distribuidora" -H "Authorization: Bearer %TOKEN%" | node -p "'GET /api/clientes?page=1&limit=2&nombre=Distribuidora -> '+JSON.parse(require('fs').readFileSync(0)).length+' clientes devueltos'"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
