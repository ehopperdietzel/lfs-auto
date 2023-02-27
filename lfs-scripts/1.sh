#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf libcap-*.tar.* -C tmp --strip-components=1
cd tmp

sed -i '/install -m.*STA/d' libcap/Makefile


make prefix=/usr lib=lib -j $LFS_CORES
make prefix=/usr lib=lib install