#!/bin/bash

source CONFIG

CHECK_FILE=/bin/zstd
if [ -f "$CHECK_FILE" ];
then
    echo "Zstd already compiled."
    exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf zstd-*.tar.* -C tmp --strip-components=1
cd tmp

make prefix=/usr -j $LFS_CORES

make prefix=/usr install
rm -v /usr/lib/libzstd.a