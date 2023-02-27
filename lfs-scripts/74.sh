#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf expat-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/expat-2.5.0

make -j $LFS_CORES

make install

install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.5.0