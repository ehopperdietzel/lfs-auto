#!/bin/bash

source CONFIG

ME=$(whoami)
if [[ "$ME" != "$LFS_USER" ]];
then
      echo "ERROR: Script needs to be run as the $LFS_USER user"
      exit 1
fi

source ~/.bashrc

TEST_FILE=$LFS/bin/gcc
if test -f "$TEST_FILE"; then
      echo "GCC pass 2 already compiled."
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
    sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
  ;;
esac

sed '/thread_header =/s/@.*@/gthr-posix.h/' \
    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

mkdir -v build
cd       build

../configure                                       \
    --build=$(../config.guess)                     \
    --host=$LFS_TGT                                \
    --target=$LFS_TGT                              \
    LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc      \
    --prefix=/usr                                  \
    --with-build-sysroot=$LFS                      \
    --enable-default-pie                           \
    --enable-default-ssp                           \
    --disable-nls                                  \
    --disable-multilib                             \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --enable-languages=c,c++

make -j $LFS_CORES
make DESTDIR=$LFS install

ln -sv gcc $LFS/usr/bin/cc