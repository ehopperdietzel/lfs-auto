#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf bison-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.8.2


make -j $LFS_CORES
make install
