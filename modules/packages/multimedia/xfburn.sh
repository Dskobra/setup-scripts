#!/usr/bin/bash

native_xfburn(){
    if [ "$DISTRO" == "dnf" ]
    then
        sudo dnf install -y xfburn
    elif [ "$DISTRO" == "zypper" ]
    then
        sudo zypper -n install xfburn
    elif [ "$DISTRO" == "apt-get" ]
    then
        sudo apt-get install -y xfburn
    else
        echo "Unkown error has occurred."
    fi
}

native_xfburn
