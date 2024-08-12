#!/usr/bin/bash

install_remmina(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y remmina
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install remmina
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y remmina
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.remmina.Remmina
install_remmina