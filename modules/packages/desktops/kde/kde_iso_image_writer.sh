#!/usr/bin/bash

native_kde_iso_image_writer(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y isoimagewriter
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "==============================================="
        echo "KDE ISO Image Writer isn't available in Debian"
        echo "so using flatpak version instead."
        echo "==============================================="
        flatpak install --user -y flathub org.kde.isoimagewriter
    else
        echo "Unkown error has occurred."
    fi
}

remove_kde_iso_image_writer(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y isoimagewriter
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing isoimagewriter as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}




if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.kde.isoimagewriter
    remove_kde_iso_image_writer
elif [ "$1" == "native" ]
then
    flatpak remove --user -y flathub org.kde.isoimagewriter
    native_kde_iso_image_writer
else
    echo "error"
fi