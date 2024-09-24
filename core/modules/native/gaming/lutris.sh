#!/usr/bin/bash

install_lutris(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y lutris
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y lutris
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/Games
flatpak remove --user -y net.lutris.Lutris
install_lutris
