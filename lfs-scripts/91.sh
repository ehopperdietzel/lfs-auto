#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf check-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr --disable-static

make -j $LFS_CORES
make docdir=/usr/share/doc/check-0.15.2 install