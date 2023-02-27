#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf procps-ng-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr                           \
            --docdir=/usr/share/doc/procps-ng-4.0.2 \
            --disable-static                        \
            --disable-kill                          \
            --with-systemd

make -j $LFS_CORES
make install

