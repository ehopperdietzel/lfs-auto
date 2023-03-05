#!/bin/bash

source CONFIG

# Net

echo "$LFS_HOSTNAME" > /etc/hostname

cat > /etc/hosts << "EOF"
127.0.0.1 localhost.localdomain localhost

# 127.0.1.1 <FQDN> <HOSTNAME>
# <192.168.0.2> <FQDN> <HOSTNAME> [alias1] [alias2] ...

::1       localhost ip6-localhost ip6-loopback
ff02::1   ip6-allnodes
ff02::2   ip6-allrouters
EOF

# Console

cat > /etc/vconsole.conf << "EOF"
KEYMAP=la-latin1
FONT=Lat2-Terminus16
EOF

# Locale

cat > /etc/locale.conf << "EOF"
LC_ALL=C
LANG=es_ES.UTF-8
LC_COLLATE=es_ES.UTF-8
EOF

# inputrc

cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8-bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF

# Shells

cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF


# Systemd

mkdir -pv /etc/systemd/system/getty@tty1.service.d

cat > /etc/systemd/system/getty@tty1.service.d/noclear.conf << EOF
[Service]
TTYVTDisallocate=no
EOF


