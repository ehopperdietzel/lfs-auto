#!/bin/bash

source CONFIG

echo "$LFS_HOSTNAME" > /etc/hostname

cat > /etc/hosts << "EOF"
127.0.0.1 localhost.localdomain localhost

# 127.0.1.1 <FQDN> <HOSTNAME>
# <192.168.0.2> <FQDN> <HOSTNAME> [alias1] [alias2] ...

::1       localhost ip6-localhost ip6-loopback
ff02::1   ip6-allnodes
ff02::2   ip6-allrouters
EOF