#!/usr/bin/bash

native_kolourpaint(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y kolourpaint
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y kolourpaint
    else
        echo "Unkown error has occurred."
    fi
}

remove_kolourpaint(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y kolourpaint
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y kolourpaint
    else
        echo "Unkown error has occurred."
    fi
}


if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.kde.kolourpaint
    remove_kolourpaint
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.kde.kolourpaint
    native_kolourpaint
else
    echo "error"
fi