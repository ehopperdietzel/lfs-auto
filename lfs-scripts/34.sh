#!/bin/bash

source CONFIG

TEST_FILE=/bin/perl
if test -f "$TEST_FILE"; then
      echo "Perl already compiled."
      exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf perl-*.tar.* -C tmp --strip-components=1
cd tmp

sh Configure -des                                        \
             -Dprefix=/usr                               \
             -Dvendorprefix=/usr                         \
             -Dprivlib=/usr/lib/perl5/5.36/core_perl     \
             -Darchlib=/usr/lib/perl5/5.36/core_perl     \
             -Dsitelib=/usr/lib/perl5/5.36/site_perl     \
             -Dsitearch=/usr/lib/perl5/5.36/site_perl    \
             -Dvendorlib=/usr/lib/perl5/5.36/vendor_perl \
             -Dvendorarch=/usr/lib/perl5/5.36/vendor_perl

make -j $LFS_CORES

make install
