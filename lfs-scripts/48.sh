#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf m4-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr

make -j $LFS_CORES
make install