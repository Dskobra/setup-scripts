#!/usr/bin/bash

install_steam(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y steam
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam
    else
        echo "Unkown error has occurred."
    fi
}

install_steam
$SCRIPTS_FOLDER/modules/native/gaming/steam_devices.sh