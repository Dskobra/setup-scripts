#!/usr/bin/bash

native_libreoffice(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y libreoffice
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install libreoffice
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y libreoffice libreoffice-branding-openSUSE
    else
        echo "Unkown error has occurred."
    fi
}

remove_libreoffice(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y libreoffice*
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm libreoffice*
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y libreoffice*
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.libreoffice.LibreOffice
    remove_libreoffice
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.libreoffice.LibreOffice
    native_libreoffice
else
    echo "error"
fi