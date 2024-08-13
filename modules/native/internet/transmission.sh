#!/usr/bin/bash

install_transmission(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y transmission-gtk
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y transmission-gtk
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y com.transmissionbt.Transmission
install_transmission