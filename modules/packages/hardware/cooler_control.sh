#!/usr/bin/bash

install_cooler_control(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf copr enable -y codifryed/CoolerControl
        sudo dnf install -y coolercontrol
        sudo systemctl enable --now coolercontrold
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:codifryed/openSUSE_Slowroll/home:codifryed.repo
        sudo zypper ref
        sudo zypper -n install coolercontrol
        sudo systemctl enable --now coolercontrold
    else
        echo "Unkown error has occurred."
    fi
}

install_cooler_control
