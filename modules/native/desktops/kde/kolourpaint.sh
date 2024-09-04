#!/usr/bin/bash

install_kolourpaint(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y kolourpaint
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y kolourpaint
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.kde.kolourpaint
install_kolourpaint
