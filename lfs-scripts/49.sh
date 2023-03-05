#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf bc-*.tar.* -C tmp --strip-components=1
cd tmp

CC=gcc ./configure --prefix=/usr -G -O3 -r

make -j $LFS_CORES
make install