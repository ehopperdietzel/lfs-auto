#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf man-db-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr                         \
            --docdir=/usr/share/doc/man-db-2.11.2 \
            --sysconfdir=/etc                     \
            --disable-setuid                      \
            --enable-cache-owner=bin              \
            --with-browser=/usr/bin/lynx          \
            --with-vgrind=/usr/bin/vgrind         \
            --with-grap=/usr/bin/grap

make -j $LFS_CORES
make install

