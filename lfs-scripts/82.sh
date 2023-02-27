#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf openssl-*.tar.* -C tmp --strip-components=1
cd tmp

./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic

make -j $LFS_CORES

sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install

mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.0.8
cp -vfr doc/* /usr/share/doc/openssl-3.0.8

