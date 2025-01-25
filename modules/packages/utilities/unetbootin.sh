#!/usr/bin/bash

native_unetbootin(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y unetbootin
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypepr -n install unetbootin
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y unetbootin
    else
        echo "Unkown error has occurred."
    fi
}

native_unetbootin