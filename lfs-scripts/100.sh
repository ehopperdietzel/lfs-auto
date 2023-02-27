#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf make-*.tar.* -C tmp --strip-components=1
cd tmp

sed -e '/ifdef SIGPIPE/,+2 d' \
    -e '/undef  FATAL_SIG/i FATAL_SIG (SIGPIPE);' \
    -i src/main.c

./configure --prefix=/usr

make -j $LFS_CORES
make install

