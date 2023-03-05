#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

source ~/.bashrc

TEST_FILE=$LFS/lib/libbfd.so
if test -f "$TEST_FILE"; then
      echo "Binutils pass 2 already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf binutils-*.tar.* -C tmp --strip-components=1
cd tmp

sed '6009s/$add_dir//' -i ltmain.sh

mkdir -v build
cd       build

../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --enable-gprofng=no        \
    --disable-werror           \
    --enable-64-bit-bfd

make -j $LFS_CORES
make DESTDIR=$LFS install

rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.{a,la}