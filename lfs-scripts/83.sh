#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf kmod-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --with-openssl         \
            --with-xz              \
            --with-zstd            \
            --with-zlib

make -j $LFS_CORES
make install