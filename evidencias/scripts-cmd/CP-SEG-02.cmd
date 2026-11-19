@echo off
chcp 65001 >nul
title Atlas QA - CP-SEG-02
cd /d D:\descargas\atlas-system
cls
echo ==========================================================================================
echo  CP-SEG-02 ^| Contrasenas almacenadas con bcrypt
echo  Entorno local de laboratorio - API http://localhost:5000 - Frontend http://localhost:3000
echo  Fecha y hora de inicio: %date% %time%
echo ==========================================================================================
prompt [$D $T]$S$P$G
@echo on
docker exec atlas-db psql -U atlas_admin -d atlas_db -c "SELECT id, email, left(password_hash, 7) AS prefijo, length(password_hash) AS largo, password_hash FROM usuarios ORDER BY id;"
@echo off
echo.
echo  Fecha y hora de termino: %date% %time%
@type nul > "%TEMP%\atlas_cap_done"
