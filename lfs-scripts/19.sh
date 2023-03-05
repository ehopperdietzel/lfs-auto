#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

source ~/.bashrc

TEST_FILE=$LFS/bin/gawk
if test -f "$TEST_FILE"; then
      echo "Gawk already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf gawk-*.tar.* -C tmp --strip-components=1
cd tmp

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make -j $LFS_CORES
make DESTDIR=$LFS install