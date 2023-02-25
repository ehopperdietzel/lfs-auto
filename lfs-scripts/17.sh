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
TEST_FILE=$LFS/bin/file
if test -f "$TEST_FILE"; then
      echo "File already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf file-*.tar.* -C tmp --strip-components=1
cd tmp

mkdir build
pushd build
  ../configure --disable-bzlib      \
               --disable-libseccomp \
               --disable-xzlib      \
               --disable-zlib
  make
popd

./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)

make FILE_COMPILE=$(pwd)/build/src/file -j $LFS_CORES
make DESTDIR=$LFS install

rm -v $LFS/usr/lib/libmagic.la