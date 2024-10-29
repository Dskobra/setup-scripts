#!/usr/bin/bash

install_transmission(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y transmission-gtk
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y transmission-gtk
    else
        echo "Unkown error has occurred."
    fi
}

remove_transmission(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y transmission-gtk
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y transmission-gtk
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y  flathub com.transmissionbt.Transmission
    remove_transmission
elif [ "$1" == "native" ]
then
    flatpak remove --user -y com.transmissionbt.Transmission
    install_transmission
else
    echo "error"
fi