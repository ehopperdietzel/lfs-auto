#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf inetutils-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr        \
            --bindir=/usr/bin    \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers

make -j $LFS_CORES

make install

mv -v /usr/{,s}bin/ifconfig