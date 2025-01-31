#!/usr/bin/bash

native_unetbootin(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y unetbootin
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypepr -n install unetbootin
    else
        echo "Unkown error has occurred."
    fi
}

native_unetbootin