#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf less-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr --sysconfdir=/etc

make -j $LFS_CORES

make install
