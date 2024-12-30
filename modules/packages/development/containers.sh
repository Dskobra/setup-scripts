#!/usr/bin/bash

native_containers(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y toolbox distrobox
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install patterns-containers-container_runtime toolbox distrobox
    elif [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n install toolbox distrobox podman
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y distrobox podman-toolbox
    else
        echo "Unkown error has occurred."
    fi
}

native_containers
