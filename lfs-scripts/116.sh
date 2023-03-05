#!/bin/bash

source CONFIG

# Extract
cd /sources
mkdir tmp
tar -xf linux-*.tar.* -C tmp --strip-components=1
cd tmp

mkdir /etc/modprobe.d
cp ../modprobe.d/* /etc/modprobe.d

make mrproper

#make defconfig

cp ../linux-config .config

make -j $LFS_CORES

# make modules_install

cp -iv arch/x86/boot/bzImage /boot/vmlinuz-6.1.11-lfs-r11.2-332-systemd
cp -iv System.map /boot/System.map-6.1.11
cp -iv .config /boot/config-6.1.11

install -d /usr/share/doc/linux-6.1.11
cp -r Documentation/* /usr/share/doc/linux-6.1.11

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF