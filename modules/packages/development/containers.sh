#!/usr/bin/bash

native_containers(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y toolbox distrobox
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        sudo rpm-ostree install distrobox
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
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
