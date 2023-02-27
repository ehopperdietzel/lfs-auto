#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf flex-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr \
            --docdir=/usr/share/doc/flex-2.6.4 \
            --disable-static

make -j $LFS_CORES
make install
ln -sv flex /usr/bin/lex