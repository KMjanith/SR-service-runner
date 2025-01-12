#!/bin/bash

# Define the paths (if necessary)
export FRONTEND_PATH="${pwd}/../frontend"
export AUTH_SERVICE_PATH="$(pwd)/../auth-service"
export API_GATEWAY_PATH="$(pwd)/../api-gateway"
export SORTING_PATH="$(pwd)/../soritng-service"


# Navigate to the directory containing docker-compose.dev.yml if not in the same directory
COMPOSE_FILE="docker-compose.dev.yml"
if [ ! -f "$COMPOSE_FILE" ]; then
    echo "Error: $COMPOSE_FILE not found in the current directory."
    exit 1
fi

# Stop and remove containers, networks, and volumes created by Docker Compose
docker compose -f "$COMPOSE_FILE" down --volumes

# Optional: Confirm that containers are stopped
if [ $? -eq 0 ]; then
    echo "Docker Compose containers stopped successfully."
else
    echo "Failed to stop Docker Compose containers."
    exit 1
fi
