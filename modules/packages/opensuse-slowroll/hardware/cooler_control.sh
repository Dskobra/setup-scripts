#!/usr/bin/bash

install_cooler_control(){
    sudo zypper addrepo https://download.opensuse.org/repositories/home:codifryed/openSUSE_Slowroll/home:codifryed.repo
    sudo zypper ref
    sudo zypper -n install coolercontrol
    sudo systemctl enable --now coolercontrold
}

install_cooler_control
