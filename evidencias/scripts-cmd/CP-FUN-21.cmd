@echo off
chcp 65001 >nul
title Atlas QA - CP-FUN-21
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-FUN-21 ^| Correo principal unico entre empresas
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/empresas -H "Content-Type: application/json" -d "{\"nombre\":\"Empresa Duplicada\",\"rut\":\"76.000.021-3\",\"correo\":\"admin@atlas.cl\",\"usuario_admin\":\"Dup\",\"password\":\"Password123!\"}"
curl -s -w "\n-> HTTP %%{http_code}\n" -X POST http://localhost:5000/api/empresas -H "Content-Type: application/json" -d "{\"nombre\":\"Empresa Duplicada 2\",\"rut\":\"76.543.210-K\",\"correo\":\"otro@dup.cl\",\"usuario_admin\":\"Dup2\",\"password\":\"Password123!\"}"
docker exec atlas-db psql -U atlas_admin -d atlas_db -c "SELECT id, nombre, rut, correo FROM empresas WHERE nombre LIKE 'Empresa Duplicada%';"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
