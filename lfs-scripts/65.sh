#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf sed-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr

make -j $LFS_CORES
make html

make install
install -d -m755           /usr/share/doc/sed-4.9
install -m644 doc/sed.html /usr/share/doc/sed-4.9