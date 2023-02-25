#!/bin/bash

source CONFIG

TEST_FILE=/bin/texindex
if test -f "$TEST_FILE"; then
      echo "Texindex already compiled."
      exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf texinfo-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr

make -j $LFS_CORES

make install
