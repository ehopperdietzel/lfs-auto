#!/bin/bash

source CONFIG

ME=$(whoami)
if [[ "$ME" != "$LFS_USER" ]];
then
      echo "ERROR: Script needs to be run as the $LFS_USER user"
      exit 1
fi

source ~/.bashrc

TEST_FILE=$LFS/bin/patch
if test -f "$TEST_FILE"; then
      echo "Patch already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf patch-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make -j $LFS_CORES
make DESTDIR=$LFS install