#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf expect5*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include

make -j $LFS_CORES
make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib
