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
TEST_FILE=$LFS/usr/lib/libstdc++fs.a
if test -f "$TEST_FILE"; then
      echo "libstdc++ already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf gcc-*.tar.* -C tmp --strip-components=1
cd tmp

mkdir -v build
cd       build

../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --build=$(../config.guess)      \
    --prefix=/usr                   \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/12.2.0

make -j $LFS_CORES
make DESTDIR=$LFS install

rm -v $LFS/usr/lib/lib{stdc++,stdc++fs,supc++}.la