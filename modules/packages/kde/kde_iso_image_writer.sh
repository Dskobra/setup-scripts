#!/usr/bin/bash

native_kde_iso_image_writer(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y isoimagewriter
    else
        echo "Unkown error has occurred."
    fi
}

remove_kde_iso_image_writer(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y isoimagewriter
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