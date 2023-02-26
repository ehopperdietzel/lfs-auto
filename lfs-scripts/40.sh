#!/bin/bash

source CONFIG

CHECK_FILE=/etc/protocols
if [ -f "$CHECK_FILE" ];
then
    echo "Iana-etc already installed."
    exit 0
fi

# Extract
cd /sources
mkdir tmp
tar -xf iana-etc-*.tar.* -C tmp --strip-components=1
cd tmp

cp services protocols /etc

echo "Iana-etc installed"