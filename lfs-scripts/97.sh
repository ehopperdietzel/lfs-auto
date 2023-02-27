#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf iproute2-*.tar.* -C tmp --strip-components=1
cd tmp

sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8

make NETNS_RUN_DIR=/run/netns -j $LFS_CORES
make SBINDIR=/usr/sbin install

mkdir -pv             /usr/share/doc/iproute2-6.1.0
cp -v COPYING README* /usr/share/doc/iproute2-6.1.0