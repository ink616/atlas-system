@echo off
chcp 65001 >nul
title Atlas QA - CP-SEG-06-BD
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-SEG-06-BD ^| XSS almacenado: valor guardado en la BD
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
docker exec atlas-db psql -U atlas_admin -d atlas_db -c "SELECT id, razon_social, datos_bancarios FROM clientes WHERE razon_social LIKE '%<%' OR razon_social LIKE '%>%' ORDER BY id;"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
