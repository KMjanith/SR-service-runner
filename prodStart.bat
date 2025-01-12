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

:: Wait for Docker to be ready
:wait_for_docker
docker info >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Waiting for Docker to be ready...
    timeout /t 5 > nul
    goto wait_for_docker
)

:: Run the Python script
python3 ./runner.py

:: Bring up Docker Compose services
docker compose -f docker-compose.prod.yml up -d --build
