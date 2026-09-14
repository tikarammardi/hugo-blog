# Variables
PORT ?= 1313
HOSTNAME ?= localhost

# Default target
.DEFAULT_GOAL := hugo-serve

# Serve the Hugo site
hugo-serve:
	bash scripts/hugo-serve.sh

# Run Prettier to check formatting
lint:
	yarn run lint

# Clean up generated files (if applicable)
clean:
	rm -rf public/

# Install dependencies
install:
	yarn install

# Build the Hugo site
build:
	hugo --baseURL "http://${HOSTNAME}:${PORT}"

.PHONY: hugo-serve lint clean install build
