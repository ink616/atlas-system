@echo off
chcp 65001 >nul
title Atlas QA - CP-SEG-04
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-SEG-04 ^| Endpoints sin token, alterado, alg none o expirado
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/clientes
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/clientes -H "Authorization: Bearer abc.def.ghi"
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@atlas.cl\",\"password\":\"Password123!\"}" -o "%TEMP%\tok_TOKEN.json"
for /f "usebackq delims=" %%t in (`node -p "require(process.env.TEMP+'/tok_TOKEN.json').token"`) do set TOKEN=%%t
set ALTERADO=%TOKEN:~0,-1%X
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/clientes -H "Authorization: Bearer %ALTERADO%"
for /f "usebackq delims=" %%t in (`node -p "const b=o=>Buffer.from(JSON.stringify(o)).toString('base64url');b({alg:'none',typ:'JWT'})+'.'+b({id:1,email:'admin@atlas.cl',rol:'ADMINISTRADOR',empresa_id:1})+'.'"`) do set ALGNONE=%%t
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/clientes -H "Authorization: Bearer %ALGNONE%"
for /f "usebackq delims=" %%t in (`docker exec atlas-backend node -e "const j=require('jsonwebtoken');const n=Math.floor(Date.now()/1000);console.log(j.sign({id:1,email:'admin@atlas.cl',rol:'ADMINISTRADOR',empresa_id:1,iat:n-32400,exp:n-3600},process.env.JWT_SECRET))"`) do set EXPIRADO=%%t
curl -s -w "\n-> HTTP %%{http_code}\n" http://localhost:5000/api/clientes -H "Authorization: Bearer %EXPIRADO%"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
