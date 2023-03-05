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
TEST_FILE=$LFS/tools/bin/x86_64-lfs-linux-gnu-cpp
if test -f "$TEST_FILE"; then
    echo "GCC already compiled."
	exit 0
fi

# Extract
cd $LFS/sources

mkdir tmp
tar -xf gcc*.tar.* -C tmp --strip-components=1

mkdir tmp/mpfr
tar -xf mpfr*.tar.* -C tmp/mpfr --strip-components=1

mkdir tmp/gmp
tar -xf gmp*.tar.* -C tmp/gmp --strip-components=1

mkdir tmp/mpc
tar -xf mpc*.tar.* -C tmp/mpc --strip-components=1

cd tmp

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac

# Build
mkdir -v build
cd       build

../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.37 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-default-pie      \
    --enable-default-ssp      \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++

make -j $LFS_CORES
make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h

