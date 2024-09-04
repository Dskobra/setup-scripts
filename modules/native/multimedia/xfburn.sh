#!/usr/bin/bash

install_xfburn(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y xfburn
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y xfburn
    else
        echo "Unkown error has occurred."
    fi
}

install_xfburn
