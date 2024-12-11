#!/usr/bin/bash

native_kate(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y kate kate-plugins
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree install kate kate-plugins --allow-inactive
        sudo rpm-ostree apply-live     
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n install kate kate-plugins
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y kate
    else
        echo "Unkown error has occurred."
    fi
}

native_kate
