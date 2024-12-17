#!/usr/bin/bash

native_krfb(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y krfb
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install krfb
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y krfb
    else
        echo "Unkown error has occurred."
    fi
}



remove_krfb(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y krfb
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm krfb
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y krfb
    else
        echo "Unkown error has occurred."
    fi
}
