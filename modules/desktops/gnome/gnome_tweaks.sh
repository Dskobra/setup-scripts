#!/usr/bin/bash

install_gnome_tweaks(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y gnome-tweaks
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install gnome-tweaks
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y gnome-tweaks
    else
        echo "Unkown error has occurred."
    fi
}

install_gnome_tweaks