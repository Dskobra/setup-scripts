#!/usr/bin/bash

native_dropbox(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y dropbox
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install dropbox
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y nautilus-dropbox
    else
        echo "Unkown error has occurred."
    fi
}


remove_dropbox(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y dropbox
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n rm dropbox
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y caja-dropbox nautilus-dropbox
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub com.dropbox.Client
    remove_dropbox
elif [ "$1" == "native" ]
then
    flatpak remove --user -y com.dropbox.Client
    native_dropbox
else
    echo "error"
fi