#!/bin/bash

source CONFIG

CHECK_DIR=/tools
if [ ! -d "$CHECK_DIR" ];
then
    echo "LFS already cleaned up"
    exit 0
fi

rm -rf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete
rm -rf /tools

echo "LFS cleaned up"