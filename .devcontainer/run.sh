#!/usr/bin/env bash

set -e

DEPOT_PATH="$HOME/.julia-docker"
mkdir -p "$DEPOT_PATH/config"
if [ -d "$DEPOT_PATH/packages/Revise" ]; then
  echo 'println("using Revise"); using Revise' > "$DEPOT_PATH/config/startup.jl"
else
  echo 'println("Revise is not available.")' > "$DEPOT_PATH/config/startup.jl"
fi

docker run -it --rm \
  --env GKSwstype=nul \
  -p 8006:8006 \
  -v "$HOME/.julia-docker":"/root/.julia" \
  -v "$PWD":/app -w /app jds
