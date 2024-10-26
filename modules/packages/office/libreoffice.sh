#!/usr/bin/bash

native_libreoffice(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y libreoffice
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y libreoffice
    else
        echo "Unkown error has occurred."
    fi
}

remove_libreoffice(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y libreoffice*
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
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
elif [ "$1" == "distro" ]
then
    flatpak remove --user -y org.libreoffice.LibreOffice
    native_libreoffice
else
    echo "error"
fi