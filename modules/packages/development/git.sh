#!/usr/bin/bash

native_git(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y git git-gui gh
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install git git-gui gh
    else
        echo "Unkown error has occurred."
    fi
}

native_git
