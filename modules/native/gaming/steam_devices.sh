#!/usr/bin/bash

package_steam_devices(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y steam-devices
    elif [ $PKGMGR == "rpm-ostree" ]
    then
       sudo rpm-ostree install steam-devices
       $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam-devices
    else
        echo "Unkown error has occurred."
    fi
}

package_steam_devices