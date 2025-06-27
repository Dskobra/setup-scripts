#!/usr/bin/bash

native_krfb(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y krfb
    else
        echo "Unkown error has occurred."
    fi
}

native_krfb