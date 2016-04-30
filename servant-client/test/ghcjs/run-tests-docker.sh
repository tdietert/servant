#!/usr/bin/env bash

set -o errexit
loc=$(dirname $0)
cd $loc

cd ../../../

docker build -f ./servant-client/test/ghcjs/Dockerfile -t servant-ci ./
docker run --rm servant-ci
