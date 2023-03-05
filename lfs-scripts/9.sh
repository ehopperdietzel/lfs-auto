#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

source ~/.bashrc

# Check if already extracted
TEST_FILE=$LFS/usr/include/asm-generic/ioctls.h
if test -f "$TEST_FILE"; then
  echo "Linux headers already extracted."
	exit 0
fi

# Extract
cd $LFS/sources

mkdir tmp
tar -xf linux*.tar.* -C tmp --strip-components=1

cd tmp

make mrproper

make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr

case $(uname -m) in
  i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
  ;;
  x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
          ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
  ;;
esac
