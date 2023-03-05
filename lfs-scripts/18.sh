#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

source ~/.bashrc

# Check if already compiled
TEST_FILE=$LFS/bin/find
if test -f "$TEST_FILE"; then
      echo "Findutils already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf findutils-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr                   \
            --localstatedir=/var/lib/locate \
            --host=$LFS_TGT                 \
            --build=$(build-aux/config.guess)

make FILE_COMPILE=$(pwd)/build/src/file -j $LFS_CORES
make DESTDIR=$LFS install