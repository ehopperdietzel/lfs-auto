#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

source ~/.bashrc

# Check if already compiled
TEST_FILE=$LFS/usr/lib/libncurses.so
if test -f "$TEST_FILE"; then
      echo "Ncourses already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf ncurses-*.tar.* -C tmp --strip-components=1
cd tmp

sed -i s/mawk// configure

# Check if error
RET_CODE=$?
if [ $RET_CODE -ne 0 ]; then
      echo "gawk not found"
      exit 1
fi

mkdir build
pushd build
  ../configure
  make -C include
  make -C progs tic
popd

./configure --prefix=/usr                \
            --host=$LFS_TGT              \
            --build=$(./config.guess)    \
            --mandir=/usr/share/man      \
            --with-manpage-format=normal \
            --with-shared                \
            --without-normal             \
            --with-cxx-shared            \
            --without-debug              \
            --without-ada                \
            --disable-stripping          \
            --enable-widec

make -j $LFS_CORES
make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so