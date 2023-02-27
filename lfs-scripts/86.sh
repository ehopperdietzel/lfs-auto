#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf Python-3*.tar.* -C tmp --strip-components=1
cd tmp

./configure --prefix=/usr        \
            --enable-shared      \
            --with-system-expat  \
            --with-system-ffi    \
            --enable-optimizations

make -j $LFS_CORES
make install

cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF

install -v -dm755 /usr/share/doc/python-3.11.2/html

tar --strip-components=1  \
    --no-same-owner       \
    --no-same-permissions \
    -C /usr/share/doc/python-3.11.2/html \
    -xvf ../python-3.11.2-docs-html.tar.bz2