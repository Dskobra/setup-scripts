#!/usr/bin/bash

install_openrgb(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y openrgb
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install OpenRGB
    else
        echo "Unkown error has occurred."
    fi
}

install_openrgb
