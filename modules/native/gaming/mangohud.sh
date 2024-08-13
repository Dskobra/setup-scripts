#!/usr/bin/bash

install_mangohud(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y mangohud
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y mangohud
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/.config/MangoHud
install_mangohud