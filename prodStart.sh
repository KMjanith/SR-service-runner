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


# Run the Python script
python3 ./runner.py

# Bring up Docker Compose services
docker compose -f docker-compose.prod.yml up -d --build
