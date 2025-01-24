#!/usr/bin/bash

native_krdc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y krdc
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n install krdc
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y krdc
    else
        echo "Unkown error has occurred."
    fi
}

native_krdc