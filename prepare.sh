#!/bin/bash 

set -e

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
	echo "Docker is not installed. Please install Docker."
	exit 1
fi

# Ensure the docker-images directory exists
mkdir -p docker-images

# Check if the x86_64 Docker image exists, if not, build it
if [ ! -f docker-images/x86_64.tar ]; then
	echo "Building Docker image for x86_64..."
	docker buildx build --platform=linux/amd64 -t start9/liquid-node:1.0.0 --load .
	docker save -o docker-images/x86_64.tar start9/liquid-node:1.0.0
fi

echo "Preparation complete. All necessary Docker images are built and saved."
