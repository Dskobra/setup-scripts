#!/usr/bin/bash

install_openshot(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y openshot
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y openshot-qt
    else
        echo "Unkown error has occurred."
    fi
}

flatpak uninstall --user -y org.openshot.OpenShot
install_openshot
