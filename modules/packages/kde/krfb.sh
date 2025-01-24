#!/usr/bin/bash

native_krfb(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y krfb
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n install krfb
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y krfb
    else
        echo "Unkown error has occurred."
    fi
}

native_krfb