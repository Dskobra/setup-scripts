#!/usr/bin/bash

native_xfburn(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y xfburn
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install xfburn
    else
        echo "Unkown error has occurred."
    fi
}

native_xfburn
