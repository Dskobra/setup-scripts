#!/usr/bin/bash


remove_openshot(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y openshot
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y openshot-qt
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.openshot.OpenShot
remove_openshot
