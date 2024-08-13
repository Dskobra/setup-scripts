#!/usr/bin/bash

install_keepassxc(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y keepassxc
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y keepassxc
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.keepassxc.KeePassXC
install_keepassxc