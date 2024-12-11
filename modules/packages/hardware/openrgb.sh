#!/usr/bin/bash

install_openrgb(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y openrgb
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        sudo rpm-ostree install openrgb
        #sudo rpm-ostree apply-live
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install openrgb
    elif [ "$DISTRO" == "debian" ]
    then
        OPENRGB_LINK="https://openrgb.org/releases/release_0.9/openrgb_0.9_amd64_bookworm_b5f46e3.deb"
        OPENRGB_DEB="openrgb_0.9_amd64_bookworm_b5f46e3.deb"
        curl -L -o "$OPENRGB_DEB" "$OPENRGB_LINK"
        sudo dpkg -i "$OPENRGB_DEB"
        sudo apt-get -f -y install   
    else
        echo "Unkown error has occurred."
    fi
}

install_openrgb
