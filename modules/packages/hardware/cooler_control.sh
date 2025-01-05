#!/usr/bin/bash

install_cooler_control(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf copr enable -y codifryed/CoolerControl
        sudo dnf install -y coolercontrol
        sudo systemctl enable --now coolercontrold
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:codifryed/openSUSE_Tumbleweed/home:codifryed.repo
        sudo zypper ref
        sudo zypper -n install coolercontrol
        sudo systemctl enable --now coolercontrold
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:codifryed/openSUSE_Slowroll/home:codifryed.repo
        sudo zypper ref
        sudo zypper -n install coolercontrol
        sudo systemctl enable --now coolercontrold
    elif [ "$DISTRO" == "opensuse-leap" ]
    then
        echo "============================================="
        echo "Coolercontrol unfortunately has no official"
        echo " or community package in leap."
        echo "============================================="
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
