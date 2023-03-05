#!/bin/bash

source ../CONFIG

sudo groupadd $LFS_USER
sudo useradd -s /bin/bash -g $LFS_USER -m -k /dev/null $LFS_USER

sudo chown -v $LFS_USER $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) sudo chown -v $LFS_USER $LFS/lib64 ;;
esac

#if mount | grep $LFS/dev > /dev/null; then
#    echo "LFS already root"
#    exit 0
#fi

sudo chown -v $LFS_USER $LFS/*