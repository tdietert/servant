#!/usr/bin/env bash

set -o errexit

if [ "$GHCJS" = "true" ]; then
  ./servant-client/test/ghcjs/run-tests-docker.sh
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
