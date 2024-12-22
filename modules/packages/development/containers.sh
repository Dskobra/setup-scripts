#!/usr/bin/bash

native_containers(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y toolbox distrobox
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install toolbox distrobox
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y distrobox podman-toolbox
    else
        echo "Unkown error has occurred."
    fi
}

native_containers
