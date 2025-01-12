#!/bin/bash

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Starting docker..."
    sudo systemctl start docker
fi

# Wait for Docker to be ready
echo "Waiting for Docker to be ready..."
while ! docker info > /dev/null 2>&1; do
    sleep 5
done

# Define the paths
export FRONTEND_PATH="$(pwd)/../SR-frontend"
export AUTH_SERVICE_PATH="$(pwd)/../SR-auth-service"
export API_GATEWAY_PATH="$(pwd)/../SR-ai-gateway"
export SORTING_PATH="$(pwd)/../SR-sorting-service"

echo $FRONTEND_PATH
echo $AUTH_SERVICE_PATH
echo $API_GATEWAY_PATH
echo $SORTING_PATH

# Check if 'build' argument is provided
if [ "$1" == "build" ]; then
    # Navigate to frontend directory and run build
    echo "Building frontend..."
    cd "$FRONTEND_PATH" || exit 1
    npm run build

    # Go back to the original directory
    cd - || exit 1
fi

# Bring up Docker Compose services
echo "Starting Docker Compose services..."
docker compose -f docker-compose.dev.yml up -d --build
