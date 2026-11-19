@echo off
chcp 65001 >nul
title Atlas QA - CP-SEG-03
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-SEG-03 ^| Cifrado en reposo de datos bancarios
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
docker exec atlas-db psql -U atlas_admin -d atlas_db -c "SELECT id, empresa_id, rut, razon_social, datos_bancarios FROM clientes WHERE datos_bancarios IS NOT NULL AND id < 40 ORDER BY id;"
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@atlas.cl\",\"password\":\"Password123!\"}" -o "%TEMP%\tok_TOKEN.json"
for /f "usebackq delims=" %%t in (`node -p "require(process.env.TEMP+'/tok_TOKEN.json').token"`) do set TOKEN=%%t
curl -s http://localhost:5000/api/clientes -H "Authorization: Bearer %TOKEN%" | node -p "'Respuesta API (primer cliente): '+JSON.stringify(JSON.parse(require('fs').readFileSync(0))[0])"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
