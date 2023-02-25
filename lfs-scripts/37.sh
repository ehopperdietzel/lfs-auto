#!/bin/bash

source CONFIG

CHECK_DIR=/var/lib/hwclock
if [ -d "$CHECK_DIR" ];
then
    echo "Util-Linux already compiled."
    exit 0
fi

mkdir -pv /var/lib/hwclock

# Extract
cd /sources
mkdir tmp
tar -xf util-linux-*.tar.* -C tmp --strip-components=1
cd tmp

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime    \
            --libdir=/usr/lib    \
            --docdir=/usr/share/doc/util-linux-2.38.1 \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            runstatedir=/run

make -j $LFS_CORES

make install
