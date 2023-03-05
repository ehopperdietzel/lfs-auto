#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

source ~/.bashrc

TEST_FILE=$LFS/bin/tar
if test -f "$TEST_FILE"; then
      echo "Tar already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf tar-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess)

make -j $LFS_CORES
make DESTDIR=$LFS install