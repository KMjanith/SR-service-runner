@echo off

:: Check if Docker Desktop is running
tasklist /FI "IMAGENAME eq Docker Desktop.exe" 2>NUL | find /I "Docker Desktop.exe" >NUL
if %ERRORLEVEL% NEQ 0 (
    echo Starting Docker Desktop...
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    timeout /t 10 > nul
) else (
    echo Docker Desktop is already running...
)

:: Define the paths
SET "FRONTEND_PATH=%CD%\..\frontend"
SET "AUTH_SERVICE_PATH=%CD%\..\auth-service"
SET "API_GATEWAY_PATH=%CD%\..\api-gateway"
SET "SORTING_PATH=%CD%\..\sorting-service"

echo %AUTH_SERVICE_PATH%
echo %API_GATEWAY_PATH%
echo %FRONTEND_PATH%
echo %SORTING_PATH%

:: Check if the argument is "build"
IF "%1"=="build" (
    echo Building the frontend...
    cd /d "%FRONTEND_PATH%"
    npm run build
    echo Frontend build complete.
    cd /d "%CD%"
)

:: Bring up Docker Compose services in development mode
docker compose -f docker-compose.dev.yml up -d --build
