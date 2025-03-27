@echo off
setlocal

:: Define o caminho do Node.js portátil
set NODE_DIR=%~dp0nodejs
set PATH=%NODE_DIR%;%PATH%

:: Verifica se Node.js está disponível
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ERRO: Node.js não encontrado na pasta nodejs. Verifique a instalação!
    pause
    exit /b
)

echo Instalando dependências do projeto...
cd /d "%~dp0projeto"
%NODE_DIR%\node.exe %NODE_DIR%\npm install
%NODE_DIR%\node.exe %NODE_DIR%\npx playwright install

echo Instalacao concluída!
pause
