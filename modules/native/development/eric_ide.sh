#!/usr/bin/bash

install_eric_ide(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y eric
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install eric
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y eric
    else
        echo "Unkown error has occurred."
    fi
}

install_eric_ide