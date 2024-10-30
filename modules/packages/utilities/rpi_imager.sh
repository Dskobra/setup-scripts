#!/usr/bin/bash

native_rpi_imager(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y rpi-imager
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "========================================================"
        echo "Raspberry Pi Imager isn't currently available in Debian."
        echo "This will install the flatpak version."
        echo "========================================================"
    else
        echo "Unkown error has occurred."
    fi
}

remove_rpi_imager(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y rpi-imager
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing Raspberry Pi Imager as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.raspberrypi.rpi-imager
    remove_rpi_imager
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.raspberrypi.rpi-imager
    native_rpi_imager
else
    echo "error"
fi