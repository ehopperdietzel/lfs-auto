#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf gmp-*.tar.* -C tmp --strip-components=1
cd tmp

cp -v configfsf.guess config.guess
cp -v configfsf.sub   config.sub

./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.2.1


make -j $LFS_CORES
make html
make install
make install-html
