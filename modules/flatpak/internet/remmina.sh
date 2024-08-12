#!/usr/bin/bash

remove_remmina(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y remmina
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall remmina
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y remmina
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.remmina.Remmina
remove_remmina