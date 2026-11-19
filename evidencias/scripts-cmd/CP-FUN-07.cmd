@echo off
chcp 65001 >nul
title Atlas QA - CP-FUN-07
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-FUN-07 ^| Primer usuario de la empresa obtiene rol administrador
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
docker exec atlas-db psql -U atlas_admin -d atlas_db -c "SELECT u.id, u.email, u.rol, e.nombre AS empresa FROM usuarios u JOIN empresas e ON e.id = u.empresa_id WHERE u.email = 'admin@capturas.cl';"
curl -s http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@capturas.cl\",\"password\":\"1\"}" | node -p "JSON.stringify(JSON.parse(require('fs').readFileSync(0)).usuario)"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
