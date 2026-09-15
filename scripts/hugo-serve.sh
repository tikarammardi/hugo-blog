#!/usr/bin/env bash

# Exit build script on first failure.
set -e

# Echo commands to stdout.
set -x

# Exit on unset variable.
set -u

# The SCSS pipeline shells out to `sass`; prefer Homebrew's Dart Sass over
# the asdf shim (Ruby Sass), which the transpiler cannot drive.
export PATH="/opt/homebrew/bin:${PATH}"

PORT="${PORT:-1313}"
HOSTNAME="${HOSTNAME:-localhost}"

hugo server \
  --bind "0.0.0.0" \
  --port "${PORT}" \
  --baseURL "http://${HOSTNAME}:${PORT}"
