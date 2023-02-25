#!/bin/bash

source CONFIG

ME=$(whoami)
if [[ "$ME" != "$LFS_USER" ]];
then
	echo "ERROR: Script needs to be run as the $LFS_USER user"
	exit 1
fi

source ~/.bashrc

# Check if already extracted
#TEST_FILE=$LFS/usr/include/asm-generic/ioctls.h
#if test -f "$TEST_FILE"; then
#  echo "Linux headers already extracted."
#	exit 0
#fi

# Extract
cd $LFS/sources

mkdir tmp
tar -xf glibc*.tar.* -C tmp --strip-components=1
cd tmp

# Patch
patch -Np1 -i ../glibc-2.37-fhs-1.patch

mkdir -v build
cd       build

echo "rootsbindir=/usr/sbin" > configparms

../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=$LFS/usr/include    \
      libc_cv_slibdir=/usr/lib

make
make DESTDIR=$LFS install

sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

echo 'int main(){}' | $LFS_TGT-gcc -xc -
readelf -l a.out | grep ld-linux