#!/usr/bin/bash

install_steam_devices(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y steam-devices
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam-devices
    else
        echo "Unkown error has occurred."
    fi
}

install_steam_devices
