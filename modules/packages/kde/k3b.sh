#!/usr/bin/bash

native_k3b(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y k3b
    else
        echo "Unkown error has occurred."
    fi
}

native_k3b
