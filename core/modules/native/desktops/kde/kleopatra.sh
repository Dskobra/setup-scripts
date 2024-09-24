#!/usr/bin/bash

install_kleopatra(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y kleopatra
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y kleopatra
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y  org.kde.kleopatra
install_kleopatra
