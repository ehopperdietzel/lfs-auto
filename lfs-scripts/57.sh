#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf mpc-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.3.1


make -j $LFS_CORES
make html
make install
make install-html
