#!/usr/bin/bash

remove_remmina(){
    
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y remmina
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y remmina
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.remmina.Remmina
remove_remmina
