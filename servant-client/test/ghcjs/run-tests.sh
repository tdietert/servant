#/usr/bin/env bash

set -o errexit

loc=$(pwd)/$(dirname $0)
cd $loc

npm install xhr2

export STACK_YAML=../../stack-ghcjs.yaml
stack setup
stack test --fast
