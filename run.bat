@echo off
setlocal

:: Eleva permissões automaticamente caso não tenha privilégios de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando permissões de administrador...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit
)

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

:: Verifica se há um package.json na pasta atual
if not exist package.json (
    echo Nenhum package.json encontrado! Certifique-se de estar no diretório correto.
    pause
    exit /b
)

:: Verifica se os pacotes estão instalados
echo Verificando pacotes do Node.js...
npm ls --depth=0 >nul 2>nul
if %errorlevel% neq 0 (
    echo Dependências não encontradas. Instalando...
    npm install
) else (
    echo Todos os pacotes já estão instalados.
)

:: Executa o script Node.js
echo Iniciando script.js...
node script.js

pause
