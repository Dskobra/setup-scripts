#!/usr/bin/bash

native_marknote(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y marknote
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install marknote
    elif [ "$DISTRO" == "debian" ]
    then
        echo "============================================="
        echo "Marknote isn't currently available in Debian."
        echo "Please select the flatpak version."
        echo "============================================="
    else
        echo "Unkown error has occurred."
    fi
}

remove_marknote(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y marknote
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm marknote
    elif [ "$DISTRO" == "debian" ]
    then
        echo "Not removing marknote as it's not present in Debian repos."
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