#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf grep-*.tar.* -C tmp --strip-components=1
cd tmp

sed -i "s/echo/#echo/" src/egrep.sh
./configure --prefix=/usr


make -j $LFS_CORES
make install
