#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf bash-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr             \
            --without-bash-malloc     \
            --with-installed-readline \
            --docdir=/usr/share/doc/bash-5.2.15


make -j $LFS_CORES
make install
