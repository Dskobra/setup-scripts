#!/usr/bin/bash

native_kolourpaint(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y kolourpaint
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install kolourpaint
    else
        echo "Unkown error has occurred."
    fi
}

remove_kolourpaint(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y kolourpaint
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm kolourpaint
    else
        echo "Unkown error has occurred."
    fi
}


if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.kde.kolourpaint
    remove_kolourpaint
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.kde.kolourpaint
    native_kolourpaint
else
    echo "error"
fi