#!/bin/bash

source CONFIG

CHECK_FILE=/usr/lib/libbz2.so
if [ -f "$CHECK_FILE" ];
then
    echo "Bzip2 already compiled."
    exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf bzip2-*.tar.* -C tmp --strip-components=1
cd tmp

patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

make -f Makefile-libbz2_so
make clean

make -j $LFS_CORES
make PREFIX=/usr install

cp -av libbz2.so.* /usr/lib
ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so

cp -v bzip2-shared /usr/bin/bzip2
for i in /usr/bin/{bzcat,bunzip2}; do
  ln -sfv bzip2 $i
done

rm -fv /usr/lib/libbz2.a