#!/bin/bash

source CONFIG

TEST_FILE=/bin/bison
if test -f "$TEST_FILE"; then
      echo "Bison already compiled."
      exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf bison-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.8.2

make -j $LFS_CORES

make install
