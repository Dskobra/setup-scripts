#!/usr/bin/bash

package_codeblocks(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y codeblocks codeblocks-contrib-devel
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install codeblocks codeblocks-contrib-devel
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y codeblocks-dev
    else
        echo "Unkown error has occurred."
    fi
}

 flatpak remove --user -y org.codeblocks.codeblocks
 package_codeblocks