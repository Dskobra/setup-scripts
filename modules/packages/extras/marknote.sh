#!/usr/bin/bash

native_marknote(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y marknote
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install marknote
    else
        echo "Unkown error has occurred."
    fi
}

remove_marknote(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y marknote
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm marknote
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.kde.marknote
    remove_marknote
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.kde.marknote
    native_marknote
else
    echo "error"
fi