#!/usr/bin/bash

remove_marknote(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y marknote
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing marknote as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.kde.marknote
remove_marknote
