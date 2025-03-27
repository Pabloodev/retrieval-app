@echo off
setlocal

:: Define o caminho do Node.js portátil
set NODE_DIR=%~dp0nodejs
set PATH=%NODE_DIR%;%PATH%

:: Executa o script do Playwright
cd /d "%~dp0projeto"
%NODE_DIR%\node.exe script.js

pause
