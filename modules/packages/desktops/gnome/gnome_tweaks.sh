#!/usr/bin/bash

native_gnome_tweaks(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y gnome-tweaks
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install gnome-tweaks
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y gnome-tweaks
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    echo "========================================================"
    echo "This installs native version of Gnome Tweaks as it isn't"
    echo "available as a flatpak"
    echo "========================================================"
    native_gnome_tweaks
elif [ "$1" == "native" ]
then
    native_gnome_tweaks
else
    echo "error"
fi
