#!/usr/bin/bash

native_kate(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y kate kate-plugins
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install kate kate-plugins
    else
        echo "Unkown error has occurred."
    fi
}

native_kate
