#!/bin/bash

source CONFIG

CHECK_DIR=/usr/share/man/man3
if [ -d "$CHECK_DIR" ];
then
    echo "Man-pages already installed."
    exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf man-pages-*.tar.* -C tmp --strip-components=1
cd tmp

make prefix=/usr install
