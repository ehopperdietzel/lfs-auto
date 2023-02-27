#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf MarkupSafe-*.tar.* -C tmp --strip-components=1
cd tmp

pip3 wheel -w dist --no-build-isolation --no-deps $PWD
pip3 install --no-index --no-user --find-links dist Markupsafe
