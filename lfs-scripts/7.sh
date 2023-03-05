#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

# Check if /tools are no longer needed
CHECK_DIR=$LFS/var/lib/hwclock
if [ -d "$CHECK_DIR" ];
then
    echo "/tools no longer needed."
    exit 0
fi

source ~/.bashrc

# Check if already compiled
TEST_FILE=$LFS/tools/bin/x86_64-lfs-linux-gnu-addr2line
if test -f "$TEST_FILE"; then
    echo "Binutils already compiled."
	exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf binutils*.tar.* -C tmp --strip-components=1
cd tmp

# Build
mkdir -v build
cd       build

../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT   \
             --disable-nls       \
             --enable-gprofng=no \
             --disable-werror

make -j $LFS_CORES
make install