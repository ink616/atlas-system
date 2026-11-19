@echo off
chcp 65001 >nul
title Atlas QA - CP-FUN-20
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-FUN-20 ^| Registro de auditoria de acciones criticas
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
docker exec atlas-db psql -U atlas_admin -d atlas_db -c "SELECT id, usuario_id, accion, detalle, timestamp FROM auditoria_logs ORDER BY id DESC LIMIT 12;"
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"editor@atlas.cl\",\"password\":\"Password123!\"}" -o "%TEMP%\tok_EDITOR.json"
for /f "usebackq delims=" %%t in (`node -p "require(process.env.TEMP+'/tok_EDITOR.json').token"`) do set EDITOR=%%t
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/auditoria -H "Authorization: Bearer %EDITOR%"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
