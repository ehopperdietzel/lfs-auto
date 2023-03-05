#!/bin/bash

source CONFIG

rm -rf /tmp/*

find /usr/lib /usr/libexec -name \*.la -delete
find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

id tester

if [ $? == '0' ]; then
   userdel -r tester
fi



