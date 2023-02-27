#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf kbd-*.tar.* -C tmp --strip-components=1
cd tmp

patch -Np1 -i ../kbd-2.5.1-backspace-1.patch

sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

./configure --prefix=/usr --disable-vlock

make -j $LFS_CORES
make install

mkdir -pv           /usr/share/doc/kbd-2.5.1
cp -R -v docs/doc/* /usr/share/doc/kbd-2.5.1