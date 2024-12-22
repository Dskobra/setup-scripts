#!/usr/bin/bash

native_rpi_imager(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y rpi-imager
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install rpi-imager
    elif [ "$DISTRO" == "debian" ]
    then
        echo "========================================================"
        echo "Raspberry Pi Imager isn't currently available in Debian."
        echo "Please select the flatpak version."
        echo "========================================================"
    else
        echo "Unkown error has occurred."
    fi
}

remove_rpi_imager(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y rpi-imager
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm rpi-imager
    elif [ "$DISTRO" == "debian" ]
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