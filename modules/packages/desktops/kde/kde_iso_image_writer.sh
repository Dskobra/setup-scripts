#!/usr/bin/bash

native_kde_iso_image_writer(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y isoimagewriter
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        echo "==============================================="
        echo "KDE ISO Image Writer isn't available in openSUSE"
        echo "so using flatpak version instead."
        echo "==============================================="
        flatpak install --user -y flathub org.kde.isoimagewriter
    elif [ "$DISTRO" == "debian" ]
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
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y isoimagewriter
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        echo "Not removing isoimagewriter as it's not present in openSUSE repos."
    elif [ "$DISTRO" == "debian" ]
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