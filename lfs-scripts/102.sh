#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf tar-*.tar.* -C tmp --strip-components=1
cd tmp

FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr

make -j $LFS_CORES
make install
make -C doc install-html docdir=/usr/share/doc/tar-1.34

