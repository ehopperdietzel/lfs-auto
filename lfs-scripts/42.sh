#!/bin/bash

source CONFIG

CHECK_FILE=/usr/lib/libz.so
if [ -f "$CHECK_FILE" ];
then
    echo "Zlib already compiled."
    exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf zlib-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr

make -j $LFS_CORES

make install

rm -fv /usr/lib/libz.a