#!/usr/bin/bash

native_git(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y git git-gui gh git-cola
    else
        echo "Unkown error has occurred."
    fi
}

native_git
