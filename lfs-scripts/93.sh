#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf gawk-*.tar.* -C tmp --strip-components=1
cd tmp

sed -i 's/extras//' Makefile.in
./configure --prefix=/usr

make -j $LFS_CORES
make LN='ln -f' install

mkdir -pv                                   /usr/share/doc/gawk-5.2.1
cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-5.2.1