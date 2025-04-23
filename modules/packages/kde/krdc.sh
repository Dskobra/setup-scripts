#!/usr/bin/bash

native_krdc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y krdc
    else
        echo "Unkown error has occurred."
    fi
}

native_krdc