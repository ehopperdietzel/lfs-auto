#!/bin/bash

source ../CONFIG



[ ! -e /etc/bash.bashrc ] || sudo mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE

sudo rm -r $LFS/sources/tmp
su $LFS_USER -c "cd $LFS/scripts && ./$1.sh"

 # Check if error
RET_CODE=$?

[ ! -e /etc/bash.bashrc.NOUSE ] || sudo mv -v /etc/bash.bashrc.NOUSE /etc/bash.bashrc

exit $RET_CODE