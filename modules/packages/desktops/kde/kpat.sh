#!/usr/bin/bash

native_kpat(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y kpat
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y kpat
    else
        echo "Unkown error has occurred."
    fi
}

remove_kpat(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y kpat
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y kpat
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.kde.kpat
    remove_kpat
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.kde.kpat
    native_kpat
else
    echo "error"
fi