@echo off
setlocal

:: Verifica se o Node.js está instalado
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo Node.js não encontrado. Instalando...
    powershell -Command "& {Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi' -OutFile 'node_installer.msi'}"
    msiexec /i node_installer.msi /quiet /norestart
    echo Aguarde a instalação...
    timeout /t 15
    echo Node.js instalado com sucesso!
) else (
    echo Node.js já está instalado.
)

:: Verifica se a pasta app-retrieval/node_modules existe
if not exist "app-retrieval\node_modules" (
    echo Instalando dependências...
    cd app-retrieval
    npm install
    cd ..
) else (
    echo Dependências já instaladas.
)

:: Executa o script Node.js
node script.js
pause
