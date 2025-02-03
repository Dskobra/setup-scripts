#!/usr/bin/bash

native_krdc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y krdc
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install krdc
    else
        echo "Unkown error has occurred."
    fi
}

native_krdc