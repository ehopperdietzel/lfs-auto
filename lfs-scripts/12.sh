#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

source ~/.bashrc

# Check if already compiled
TEST_FILE=$LFS/bin/m4
if test -f "$TEST_FILE"; then
      echo "M4 already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf m4-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)


make -j $LFS_CORES
make DESTDIR=$LFS install