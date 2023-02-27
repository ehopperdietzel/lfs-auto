#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf attr-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr     \
            --disable-static  \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/attr-2.5.1


make -j $LFS_CORES
make install