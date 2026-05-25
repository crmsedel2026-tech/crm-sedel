@echo off
title Publicar CRM SEDEL en GitHub Pages
color 0A

echo.
echo  ================================================
echo   SEDEL CRM - Publicar actualizacion en web
echo  ================================================
echo.

set CRM_SRC=G:\Mi unidad\CRM SEDEL\CRM SEDEL 2026\SEDEL_CRM.html
set REPO_DIR=C:\crm-sedel

:: Verificar que existe el archivo fuente
if not exist "%CRM_SRC%" (
  echo  ERROR: No se encontro SEDEL_CRM.html
  pause & exit /b 1
)

:: Copiar ultima version al repo
echo  [1/3] Copiando ultima version del CRM...
copy /Y "%CRM_SRC%" "%REPO_DIR%\index.html" >nul
echo         OK

:: Commit con fecha y hora
echo  [2/3] Guardando cambios...
cd /d "%REPO_DIR%"
for /f "tokens=2 delims==" %%a in ('wmic os get LocalDateTime /value') do set DT=%%a
set FECHA=%DT:~6,2%/%DT:~4,2%/%DT:~0,4% %DT:~8,2%:%DT:~10,2%
git add index.html
git commit -m "Actualizacion CRM - %FECHA%"
echo         OK

:: Push a GitHub
echo  [3/3] Publicando en GitHub Pages...
git push origin main
echo.

if %errorlevel% equ 0 (
  echo  ================================================
  echo   Publicado exitosamente!
  echo.
  echo   URL: https://crmsedel2026-tech.github.io/crm-sedel/
  echo.
  echo   Los cambios se ven en 1-2 minutos.
  echo  ================================================
) else (
  echo  ERROR al publicar. Revisa tu conexion a internet.
)

echo.
pause
