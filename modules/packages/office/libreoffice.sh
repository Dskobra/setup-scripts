#!/usr/bin/bash

install_libreoffice(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y libreoffice
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y libreoffice
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.libreoffice.LibreOffice
install_libreoffice
