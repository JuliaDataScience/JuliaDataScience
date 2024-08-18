#!/usr/bin/env bash

set -e

if sysctl -n machdep.cpu.brand_string | grep -q "Apple M"; then
  echo "Apple Silicon detected; forcing linux/amd64 due to pandoc_crossref."
  export DOCKER_DEFAULT_PLATFORM=linux/amd64
fi

docker build -t jds .devcontainer/
