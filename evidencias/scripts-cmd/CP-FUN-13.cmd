@echo off
chcp 65001 >nul
title Atlas QA - CP-FUN-13
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-FUN-13 ^| Eliminacion logica de cliente (API y BD)
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"editor@atlas.cl\",\"password\":\"Password123!\"}" -o "%TEMP%\tok_EDITOR.json"
for /f "usebackq delims=" %%t in (`node -p "require(process.env.TEMP+'/tok_EDITOR.json').token"`) do set EDITOR=%%t
curl -s -w "\n-> HTTP %%{http_code}\n" -X DELETE http://localhost:5000/api/clientes/28 -H "Authorization: Bearer %EDITOR%"
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@atlas.cl\",\"password\":\"Password123!\"}" -o "%TEMP%\tok_TOKEN.json"
for /f "usebackq delims=" %%t in (`node -p "require(process.env.TEMP+'/tok_TOKEN.json').token"`) do set TOKEN=%%t
curl -s -w "\n-> HTTP %%{http_code}\n" -X DELETE http://localhost:5000/api/clientes/28 -H "Authorization: Bearer %TOKEN%"
docker exec atlas-db psql -U atlas_admin -d atlas_db -c "SELECT id, razon_social, eliminado_logico FROM clientes WHERE id = 28;"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
