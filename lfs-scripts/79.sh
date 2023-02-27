#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf intltool-*.tar.* -C tmp --strip-components=1
cd tmp

sed -i 's:\\\${:\\\$\\{:' intltool-update.in
./configure --prefix=/usr

make -j $LFS_CORES

make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO