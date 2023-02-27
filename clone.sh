#!/bin/bash

# ./clone name
PREV=$(cat COUNT)

N=$(($PREV+1))

cp host-scripts/$PREV-*.sh host-scripts/$N-$1.sh
cp lfs-scripts/$PREV.sh lfs-scripts/$N.sh

MTCH="s/${PREV}.sh/${N}.sh/"
sed -i $MTCH host-scripts/$N-$1.sh
echo $N > COUNT