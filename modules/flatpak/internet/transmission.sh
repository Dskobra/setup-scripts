#!/usr/bin/bash

remove_transmission(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y transmission-gtk
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y transmission-gtk
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y  flathub com.transmissionbt.Transmission
remove_transmission
