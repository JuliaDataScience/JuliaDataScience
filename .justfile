alias b := build

# List all actions
default:
  just --list

build:
  julia --color=yes --project -e 'using JDS; JDS.build()'
