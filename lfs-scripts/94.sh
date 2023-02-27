#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf findutils-*.tar.* -C tmp --strip-components=1
cd tmp

case $(uname -m) in
    i?86)   TIME_T_32_BIT_OK=yes ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
    x86_64) ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
esac

make -j $LFS_CORES
make install