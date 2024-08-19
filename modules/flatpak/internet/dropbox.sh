#!/usr/bin/bash

remove_dropbox(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y dropbox
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y caja-dropbox nautilus-dropbox
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub com.dropbox.Client
remove_dropbox
