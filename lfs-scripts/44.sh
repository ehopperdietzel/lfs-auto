#!/bin/bash

source CONFIG

CHECK_DIR=/usr/share/doc/xz-5.4.1
if [ -d "$CHECK_DIR" ];
then
    echo "Xz already compiled."
    exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf xz-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.4.1

make -j $LFS_CORES

make install