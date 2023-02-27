#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf pkg-config-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr              \
            --with-internal-glib       \
            --disable-host-tool        \
            --docdir=/usr/share/doc/pkg-config-0.29.2

make -j $LFS_CORES

make install
