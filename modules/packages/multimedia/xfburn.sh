#!/usr/bin/bash

native_xfburn(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y xfburn
    else
        echo "Unkown error has occurred."
    fi
}

native_xfburn
