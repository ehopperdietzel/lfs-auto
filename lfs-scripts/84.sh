#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf elfutils-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr                \
            --disable-debuginfod         \
            --enable-libdebuginfod=dummy

make -j $LFS_CORES
make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a