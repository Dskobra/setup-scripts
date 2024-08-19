#!/usr/bin/bash

remove_rpi_imager(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y rpi-imager
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing Raspberry Pi Imager as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

remove_rpi_imager
flatpak install --user -y flathub org.raspberrypi.rpi-imager
