#!/usr/bin/bash

native_xfburn(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y xfburn
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install xfburn
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y xfburn
    else
        echo "Unkown error has occurred."
    fi
}

native_xfburn
