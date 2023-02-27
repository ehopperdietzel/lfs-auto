#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf dbus-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr                        \
            --sysconfdir=/etc                    \
            --localstatedir=/var                 \
            --runstatedir=/run                   \
            --disable-static                     \
            --disable-doxygen-docs               \
            --disable-xml-docs                   \
            --docdir=/usr/share/doc/dbus-1.14.6  \
            --with-system-socket=/run/dbus/system_bus_socket

make -j $LFS_CORES
make install
ln -sfv /etc/machine-id /var/lib/dbus

