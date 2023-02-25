#!/bin/bash

source CONFIG

sudo mkdir -pv $LFS
sudo chmod -R 777 $LFS

mkdir $LFS/scripts
cp lfs-scripts/* $LFS/scripts
cp CONFIG $LFS/scripts
cp STEP $LFS/scripts

mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools
