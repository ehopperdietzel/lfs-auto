#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf groff-*.tar.* -C tmp --strip-components=1
cd tmp

PAGE=$LFS_PAPER_SIZE ./configure --prefix=/usr

make -j $LFS_CORES
make install