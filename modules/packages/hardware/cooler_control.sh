#!/usr/bin/bash

install_cooler_control(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf copr enable -y codifryed/CoolerControl
        sudo dnf install -y coolercontrol
        sudo systemctl enable --now coolercontrold
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        sudo dnf copr enable -y codifryed/CoolerControl
        sudo rpm-ostree install coolercontrol
        sudo rpm-ostree apply-live
        sudo systemctl enable --now coolercontrold
        #sudo rpm-ostree apply-live
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        opi coolercontrol
        sudo systemctl enable --now coolercontrold
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt install -y curl apt-transport-https
        curl -1sLf \
        'https://dl.cloudsmith.io/public/coolercontrol/coolercontrol/setup.deb.sh' \
        | sudo -E bash
        sudo apt-get -y update
        sudo apt-get install -y coolercontrol
        sudo systemctl enable --now coolercontrold
    else
        echo "Unkown error has occurred."
    fi
}

install_cooler_control
