#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf gperf-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1
make -j $LFS_CORES
make install
