#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf XML-Parser-*.tar.* -C tmp --strip-components=1
cd tmp

perl Makefile.PL

make -j $LFS_CORES

make install