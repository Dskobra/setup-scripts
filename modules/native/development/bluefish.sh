#!/usr/bin/bash

install_bluefish(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y bluefish
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y bluefish
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y nl.openoffice.bluefish
install_bluefish