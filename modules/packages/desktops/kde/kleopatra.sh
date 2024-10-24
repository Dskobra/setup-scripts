#!/usr/bin/bash

native_kleopatra(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y kleopatra
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y kleopatra
    else
        echo "Unkown error has occurred."
    fi
}



remove_kleopatra(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y kleopatra
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y kleopatra
    else
        echo "Unkown error has occurred."
    fi
}


if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.kde.kleopatra
    remove_kleopatra
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.kde.kleopatra
    native_kleopatra
else
    echo "error"
fi