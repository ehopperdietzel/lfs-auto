#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf libffi-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr          \
            --disable-static       \
            --with-gcc-arch=$LFS_ARCH

make -j $LFS_CORES
make install
