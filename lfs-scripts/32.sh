#!/bin/bash

source CONFIG

TEST_FILE=/usr/bin/xgettext
if test -f "$TEST_FILE"; then
      echo "Gettext already compiled."
      exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf gettext-*.tar.* -C tmp --strip-components=1
cd tmp

./configure --disable-shared

make -j $LFS_CORES

cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
