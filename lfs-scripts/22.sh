#!/bin/bash

source CONFIG

ME=$(whoami)
if [[ "$ME" != "$LFS_USER" ]];
then
      echo "ERROR: Script needs to be run as the $LFS_USER user"
      exit 1
fi

source ~/.bashrc

TEST_FILE=$LFS/bin/make
if test -f "$TEST_FILE"; then
      echo "Make already compiled."
      exit 0
fi

# Extract
cd $LFS/sources
mkdir tmp
tar -xf make-*.tar.* -C tmp --strip-components=1
cd tmp

sed -e '/ifdef SIGPIPE/,+2 d' \
    -e '/undef  FATAL_SIG/i FATAL_SIG (SIGPIPE);' \
    -i src/main.c

./configure --prefix=/usr   \
            --without-guile \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make -j $LFS_CORES
make DESTDIR=$LFS install