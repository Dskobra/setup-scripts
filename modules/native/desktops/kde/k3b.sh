#!/usr/bin/bash

install_k3b(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y k3b
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install k3b
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y k3b
    else
        echo "Unkown error has occurred."
    fi
}

install_k3b