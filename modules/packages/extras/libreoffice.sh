#!/usr/bin/bash

native_libreoffice(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y libreoffice
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install libreoffice libreoffice-branding-openSUSE
    else
        echo "Unkown error has occurred."
    fi
}

remove_libreoffice(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y libreoffice*
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm libreoffice*
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