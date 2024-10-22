# Makefile for building the Liquid Node package

S9PK_NAME = liquid-node
VERSION = 1.0.0

# Default target to run both preparation and build
all: prepare build

# Preparation step, calling prepare.sh
prepare:
	./prepare.sh

# Build step using start-sdk
build:
	start-sdk pack

# Clean up old build files
clean:
	rm -rf $(S9PK_NAME).s9pk
	rm -rf docker-images  # <--- Use tabs here, not spaces

# Verify the package
verify:
	start-sdk verify $(S9PK_NAME).s9pk
