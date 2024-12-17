#!/usr/bin/bash

native_kleopatra(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y kleopatra
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install kleopatra
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y kleopatra
    else
        echo "Unkown error has occurred."
    fi
}



remove_kleopatra(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y kleopatra
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm kleopatra
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y kleopatra
    else
        echo "Unkown error has occurred."
    fi
}


if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.kde.kleopatra
    remove_kleopatra
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.kde.kleopatra
    native_kleopatra
else
    echo "error"
fi