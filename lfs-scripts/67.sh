#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf gettext-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.21.1

make -j $LFS_CORES

make install
chmod -v 0755 /usr/lib/preloadable_libintl.so