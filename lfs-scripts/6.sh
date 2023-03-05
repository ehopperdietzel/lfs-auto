#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

cat > ~/.bashrc << "EOF"
HOME=$HOME 
TERM=$TERM 
PS1='\u:\w\$ '
set +h
umask 022
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LC_ALL LFS_TGT PATH CONFIG_SITE
EOF