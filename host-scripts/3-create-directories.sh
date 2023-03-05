#!/bin/bash

source ../CONFIG

sudo umount $LFS/dev/shm
sudo umount $LFS/dev/pts
sudo umount $LFS/dev
sudo umount $LFS/proc
sudo umount $LFS/run
sudo umount $LFS/sys

sudo rm -r $LFS/{dev,proc,sys,run}

#if mount | grep $LFS/dev > /dev/null; then
#    echo "LFS already root"
#    mkdir $LFS/scripts
#    cp ../lfs-scripts/* $LFS/scripts
#    cp ../CONFIG $LFS/scripts
#    exit 0
#fi

sudo mkdir -pv $LFS
sudo chmod 777 $LFS

mkdir $LFS/scripts
cp ../lfs-scripts/* $LFS/scripts
cp ../CONFIG $LFS/scripts

mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

# Check if /tools are no longer needed
CHECK_DIR=$LFS/var/lib/hwclock
if [ -d "$CHECK_DIR" ];
then
    echo "/tools no longer needed."
    exit 0
fi

mkdir -pv $LFS/tools
