#!/usr/bin/env bash

set -o errexit

if [ "$GHCJS" = "true" ]; then
  # fixme: provide more specific image tag
  IMAGE=soenkehahn/ghcjs-for-travis:latest
  IMAGE=soenkehahn/docker-test:latest
  # docker pull $IMAGE
  # docker run --rm -v $(pwd):/root/servant $IMAGE ls -la /root
  # docker run --rm -v $(pwd):/root/servant $IMAGE ls -la /root
  ./servant-client/test/ghcjs/run-tests.sh
else
  for package in $(cat sources.txt) doc/tutorial ; do
    echo testing $package
    pushd $package
    tinc
    cabal configure --enable-tests --disable-optimization
    cabal build
    cabal test
    popd
  done
fi
