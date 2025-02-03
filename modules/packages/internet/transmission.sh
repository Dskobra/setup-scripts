#!/usr/bin/bash

install_transmission(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y transmission-gtk
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install transmission-gtk
    else
        echo "Unkown error has occurred."
    fi
}

remove_transmission(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y transmission-gtk
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm transmission-gtk
    elif [ "$DISTRO" == "debian" ]
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