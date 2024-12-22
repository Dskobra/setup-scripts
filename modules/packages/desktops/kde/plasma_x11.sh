#!/usr/bin/bash

native_plasma_x11(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y plasma-workspace-x11
    else
        echo "This only supports Fedora Linux 40+"
    fi
}

native_plasma_x11
