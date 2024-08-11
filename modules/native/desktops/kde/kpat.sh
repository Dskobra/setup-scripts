#!/usr/bin/bash

install_kpat(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kpat
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install kpat
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kpat
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.kde.kpat
install_kpat