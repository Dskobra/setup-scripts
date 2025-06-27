#!/usr/bin/bash

install_openrgb(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y openrgb
    else
        echo "Unkown error has occurred."
    fi
}

install_openrgb
