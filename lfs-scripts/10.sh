#!/bin/bash

./is-lfs-user.sh || exit 1

source CONFIG

# Check if /tools are no longer needed
CHECK_DIR=$LFS/var/lib/hwclock
if [ -d "$CHECK_DIR" ];
then
    echo "/tools no longer needed."
    exit 0
fi

source ~/.bashrc

# Check if already compiled
TEST_FILE=$LFS/usr/bin/ldd
if test -f "$TEST_FILE"; then
      echo "Glibc already compiled."
      exit 0
fi

# Extract
cd $LFS/sources

mkdir tmp
tar -xf glibc-*.tar.* -C tmp --strip-components=1
cd tmp

# Patch
patch -Np1 -i ../glibc-2.37-fhs-1.patch

mkdir -v build
cd       build

echo "rootsbindir=/usr/sbin" > configparms

../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=$LFS/usr/include    \
      libc_cv_slibdir=/usr/lib

# Using 1 core (LFS says using more cores could cause errors)
make
make DESTDIR=$LFS install

sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

echo 'int main(){}' | $LFS_TGT-gcc -xc -
CHECK_OUT=$(readelf -l a.out | grep ld-linux)

if [[ "$CHECK_OUT" != *"Requesting program interpreter"* ]]; then
  echo "Glib test failed"
  exit 1
fi

rm -v a.out

$LFS/tools/libexec/gcc/$LFS_TGT/12.2.0/install-tools/mkheaders