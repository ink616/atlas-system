@echo off
chcp 65001 >nul
title Atlas QA - CP-FUN-03
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-FUN-03 ^| Cierre de sesion y revocacion del token
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@atlas.cl\",\"password\":\"Password123!\"}" -o "%TEMP%\tok_TOKEN.json"
for /f "usebackq delims=" %%t in (`node -p "require(process.env.TEMP+'/tok_TOKEN.json').token"`) do set TOKEN=%%t
node -p "const p=JSON.parse(Buffer.from(process.env.TOKEN.split('.')[1],'base64url'));JSON.stringify(p)+'  vigencia_horas='+(p.exp-p.iat)/3600"
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/auth/logout -H "Authorization: Bearer %TOKEN%"
curl -s -o NUL -w "GET /api/clientes con el mismo token tras logout -> HTTP %%{http_code}\n" http://localhost:5000/api/clientes -H "Authorization: Bearer %TOKEN%"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
