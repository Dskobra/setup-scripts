#!/usr/bin/bash

install_cooler_control(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf copr enable -y codifryed/CoolerControl
        sudo dnf install -y coolercontrol
        sudo systemctl enable --now coolercontrold
    else
        echo "Unkown error has occurred."
    fi
}

install_cooler_control
