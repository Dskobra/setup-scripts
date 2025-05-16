#!/usr/bin/bash

native_containers(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y toolbox distrobox docker-compose-switch
        flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
    else
        echo "Unkown error has occurred."
    fi
}

native_containers
