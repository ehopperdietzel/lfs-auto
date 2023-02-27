#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf wheel-*.tar.* -C tmp --strip-components=1
cd tmp

PYTHONPATH=src pip3 wheel -w dist --no-build-isolation --no-deps $PWD
pip3 install --no-index --find-links=dist wheel
