alias b := build

# List all actions
default:
  just --list

# Build JDS
build:
  julia --color=yes --project -e 'using JDS; JDS.build()'

# Clean build artifacts
clean:
  rm -rf _build _gen
