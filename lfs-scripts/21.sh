#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

source ~/.bashrc

TEST_FILE=$LFS/bin/gzip
if test -f "$TEST_FILE"; then
      echo "Gzip already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf gzip-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr --host=$LFS_TGT

make -j $LFS_CORES
make DESTDIR=$LFS install