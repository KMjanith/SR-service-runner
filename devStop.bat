@echo off

:: Define the paths (if necessary)
SET "FRONTEND_PATH=%CD%\..\SR-frontend"
SET "AUTH_SERVICE_PATH=%CD%\..\SR-auth-service"
SET "API_GATEWAY_PATH=%CD%\..\SR-ai-gateway"
SET "SORTING_PATH=%CD%\..\SR-sorting-service"



:: Define the docker-compose file
SET "COMPOSE_FILE=docker-compose.dev.yml"

:: Check if the docker-compose file exists
IF NOT EXIST "%COMPOSE_FILE%" (
    ECHO Error: %COMPOSE_FILE% not found in the current directory.
    EXIT /B 1
)

:: Stop and remove containers, networks, and volumes created by Docker Compose
docker compose -f "%COMPOSE_FILE%" down --volumes
IF ERRORLEVEL 1 (
    ECHO Failed to stop Docker Compose containers.
    EXIT /B 1
)

:: Confirm that containers are stopped
ECHO Docker Compose containers stopped successfully.
