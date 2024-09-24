#!/usr/bin/bash

install_dropbox(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y dropbox
    elif [ "$PKGMGR" == "apt-get" ]
    then
        install_dropbox_debian
    else
        echo "Unkown error has occurred."
    fi
}

install_dropbox_debian(){
    DESKTOP=$(echo $XDG_CURRENT_DESKTOP)
    if [ $DESKTOP == "GNOME" ]
    then
        sudo apt-get install -y nautilus-dropbox
    elif [ $DESKTOP == "MATE" ]
    then
        sudo apt-get install caja-dropbox
    else
        sudo apt-get install -y nautilus-dropbox
    fi
}

flatpak remove --user -y com.dropbox.Client
install_dropbox
