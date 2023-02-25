#!/bin/bash

source ../CONFIG

[ ! -e /etc/bash.bashrc ] || sudo mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE > /dev/null 2>&1

sudo rm -r $LFS/sources/tmp > /dev/null 2>&1
su $LFS_USER -c "cd $LFS/scripts && ./19.sh"

 # Check if error
RET_CODE=$?

[ ! -e /etc/bash.bashrc.NOUSE ] || sudo mv -v /etc/bash.bashrc.NOUSE /etc/bash.bashrc > /dev/null 2>&1

exit $RET_CODE