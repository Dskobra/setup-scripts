#!/usr/bin/bash

native_kpat(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y kpat
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n install kpat
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y kpat
    else
        echo "Unkown error has occurred."
    fi
}

remove_kpat(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y kpat
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm kpat
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y kpat
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.kde.kpat
    remove_kpat
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.kde.kpat
    native_kpat
else
    echo "error"
fi