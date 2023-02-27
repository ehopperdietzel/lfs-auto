#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf autoconf-*.tar.* -C tmp --strip-components=1
cd tmp

sed -e 's/SECONDS|/&SHLVL|/'               \
    -e '/BASH_ARGV=/a\        /^SHLVL=/ d' \
    -i.orig tests/local.at

./configure --prefix=/usr

make -j $LFS_CORES

make install
