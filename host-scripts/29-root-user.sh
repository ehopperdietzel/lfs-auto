#!/bin/bash

source ../CONFIG

if mount | grep $LFS/dev > /dev/null; then
    echo "LFS already root"
    exit 0
fi

# Changes LFS dirs ownership to the root user

sudo chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) sudo chown -R root:root $LFS/lib64 ;;
esac

echo "LFS dirs ownership set to the root user"

mkdir -pv $LFS/{dev,proc,sys,run}

sudo mount -v --bind /dev $LFS/dev

sudo mount -v --bind /dev/pts $LFS/dev/pts
sudo mount -vt proc proc $LFS/proc
sudo mount -vt sysfs sysfs $LFS/sys
sudo mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
else
  sudo mount -t tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi

exit 0