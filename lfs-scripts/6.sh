#!/bin/bash

source CONFIG

ME=$(whoami)
if [[ "$ME" != "$LFS_USER" ]];
then
	echo "ERROR: Script needs to be run as the $LFS_USER user"
	exit 1
fi

cat > ~/.bash_profile << "EOF"
#HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

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