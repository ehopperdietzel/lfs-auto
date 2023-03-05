#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf grub-*.tar.* -C tmp --strip-components=1
cd tmp

unset {C,CPP,CXX,LD}FLAGS

patch -Np1 -i ../grub-2.06-upstream_fixes-1.patch

./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --disable-efiemu       \
            --disable-werror

make -j $LFS_CORES

make install
mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions