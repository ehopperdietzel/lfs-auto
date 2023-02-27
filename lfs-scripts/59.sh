#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf acl-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr         \
            --disable-static      \
            --docdir=/usr/share/doc/acl-2.3.1

make -j $LFS_CORES
make install