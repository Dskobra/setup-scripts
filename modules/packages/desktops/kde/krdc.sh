#!/usr/bin/bash

native_krdc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y krdc
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install krdc
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y krdc
    else
        echo "Unkown error has occurred."
    fi
}



remove_krdc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y krdc
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm krdc
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y krdc
    else
        echo "Unkown error has occurred."
    fi
}
