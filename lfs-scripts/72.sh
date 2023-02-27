#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf gdbm-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr    \
            --disable-static \
            --enable-libgdbm-compat

make -j $LFS_CORES
make install
