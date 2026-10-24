# Variables
PORT ?= 1313
HOSTNAME ?= localhost

# The SCSS pipeline shells out to `sass`. The asdf shim on PATH is Ruby Sass,
# which Hugo's Dart Sass transpiler cannot drive, so prefer Homebrew's copy.
export PATH := /opt/homebrew/bin:$(PATH)

# Default target
.DEFAULT_GOAL := hugo-serve

# Serve the Hugo site
hugo-serve:
	bash scripts/hugo-serve.sh

# Create a new post bundle: make new SLUG=my-post
new:
	@test -n "$(SLUG)" || { echo "usage: make new SLUG=my-post"; exit 1; }
	hugo new content "posts/$(SLUG)/index.md"

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

.PHONY: hugo-serve new lint clean install build
