#!/usr/bin/bash

native_marknote(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y marknote
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "============================================="
        echo "Marknote isn't currently available in Debian."
        echo "This will install the flatpak version."
        echo "============================================="
        flatpak install --user -y flathub org.kde.marknote
    else
        echo "Unkown error has occurred."
    fi
}

remove_marknote(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y marknote
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing marknote as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.kde.marknote
    remove_marknote
elif [ "$1" == "distro" ]
then
    flatpak remove --user -y org.kde.marknote
    native_marknote
else
    echo "error"
fi