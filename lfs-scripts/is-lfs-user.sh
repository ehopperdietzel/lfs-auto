#!/bin/bash

source CONFIG

ME=$(whoami)
if [[ "$ME" != "$LFS_USER" ]];
then
	echo "ERROR: Script needs to be run as the $LFS_USER user"
	exit 1
fi