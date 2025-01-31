#!/usr/bin/bash

native_lutris(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y lutris
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install lutris
    else
        echo "Unkown error has occurred."
    fi
}

remove_lutris(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y lutris
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm lutris
    else
        echo "Unkown error has occurred."
    fi
}


mkdir $HOME/Games
if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub net.lutris.Lutris
    flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
    remove_lutris
elif [ "$1" == "native" ]
then
    flatpak remove --user -y net.lutris.Lutris
    native_lutris
else
    echo "error"
fi