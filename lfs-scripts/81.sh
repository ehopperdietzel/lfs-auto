#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf automake-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.5

make -j $LFS_CORES

make install
