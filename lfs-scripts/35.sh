#!/bin/bash

source CONFIG

TEST_FILE=/bin/python3
if test -f "$TEST_FILE"; then
      echo "Python 3 already compiled."
      exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf Python-3*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr   \
            --enable-shared \
            --without-ensurepip

make -j $LFS_CORES

make install
