#!/usr/bin/bash

native_k3b(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y k3b
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then 
        sudo zypper -n install k3b
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y k3b
    else
        echo "Unkown error has occurred."
    fi
}

native_k3b
