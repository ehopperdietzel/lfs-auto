#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

source ~/.bashrc

# Check if already compiled
TEST_FILE=$LFS/bin/bash
if test -f "$TEST_FILE"; then
      echo "Bash already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf bash-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr                      \
            --build=$(sh support/config.guess) \
            --host=$LFS_TGT                    \
            --without-bash-malloc


make -j $LFS_CORES
make DESTDIR=$LFS install
ln -sv bash $LFS/bin/sh