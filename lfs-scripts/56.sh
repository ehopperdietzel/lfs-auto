#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf mpfr-*.tar.* -C tmp --strip-components=1
cd tmp

sed -e 's/+01,234,567/+1,234,567 /' \
    -e 's/13.10Pd/13Pd/'            \
    -i tests/tsprintf.c

./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.2.0


make -j $LFS_CORES
make html
make install
make install-html
