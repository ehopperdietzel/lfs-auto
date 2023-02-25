#!/bin/bash

source CONFIG

SUM_CHECK=$(pushd sources 
md5sum -c SOURCES-MD5 
popd)

if [[ "$SUM_CHECK" != *FAILED* ]]; then
  echo "Sources already downloaded"
  mkdir -v $LFS/sources
  sudo chmod -v a+wt $LFS/sources
  echo "Copying sources to LFS"
  cp sources/* $LFS/sources
  mkdir -v $LFS/scripts

  sudo chown root:root $LFS/sources/*
  exit 0
fi

mkdir -v sources

wget --input-file=SOURCES --continue --directory-prefix=sources

cp SOURCES-MD5 sources

SUM_CHECK=$(pushd sources 
md5sum -c SOURCES-MD5 
popd)

if [[ "$SUM_CHECK" == *FAILED* ]]; then
  echo "$SUM_CHECK"
  exit 1
fi

mkdir -v $LFS/sources
sudo chmod -v a+wt $LFS/sources
echo "Copying sources to LFS"
cp sources/* $LFS/sources
mkdir -v $LFS/scripts

sudo chown root:root $LFS/sources/*

