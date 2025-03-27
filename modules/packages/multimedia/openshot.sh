#!/usr/bin/bash

native_openshot(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y openshot
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install openshot-qt
    else
        echo "Unkown error has occurred."
    fi
}

remove_openshot(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y openshot
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm openshot-qt
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.openshot.OpenShot
    remove_openshot
elif [ "$1" == "native" ]
then
    flatpak uninstall --user -y org.openshot.OpenShot
    native_openshot
else
    echo "error"
fi