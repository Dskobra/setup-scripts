#!/usr/bin/bash

native_kate(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y kate kate-plugins
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n install kate kate-plugins
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y kate
    else
        echo "Unkown error has occurred."
    fi
}

native_kate
