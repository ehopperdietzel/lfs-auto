#!/bin/bash

source CONFIG

ME=$(whoami)
if [[ "$ME" != "$LFS_USER" ]];
then
      echo "ERROR: Script needs to be run as the $LFS_USER user"
      exit 1
fi

source ~/.bashrc

# Check if already compiled
TEST_FILE=$LFS/bin/diff
if test -f "$TEST_FILE"; then
      echo "Diffutils already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf diffutils-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr --host=$LFS_TGT

make -j $LFS_CORES
make DESTDIR=$LFS install
