#!/usr/bin/bash

install_xfburn(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y xfburn
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install xfburn
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y xfburn
    else
        echo "Unkown error has occurred."
    fi
}

install_xfburn