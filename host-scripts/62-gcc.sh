#!/bin/bash

source ../CONFIG

[ ! -e /etc/bash.bashrc ] || sudo mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE > /dev/null 2>&1

sudo rm -r $LFS/sources/tmp > /dev/null 2>&1

sudo chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    /bin/bash --login << "EOT"
cd /scripts && ./62.sh
EOT

 # Check if error
RET_CODE=$?

[ ! -e /etc/bash.bashrc.NOUSE ] || sudo mv -v /etc/bash.bashrc.NOUSE /etc/bash.bashrc > /dev/null 2>&1

exit $RET_CODE