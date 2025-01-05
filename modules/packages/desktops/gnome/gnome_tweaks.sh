#!/usr/bin/bash

native_gnome_tweaks(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y gnome-tweaks
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n install gnome-tweaks
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y gnome-tweaks
    else
        echo "Unkown error has occurred."
    fi
}

native_gnome_tweaks