#!/usr/bin/bash

remove_dropbox(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y dropbox
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y caja-dropbox nautilus-dropbox
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub com.dropbox.Client
remove_dropbox
