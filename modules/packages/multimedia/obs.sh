#!/usr/bin/bash

remove_obsstudio(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y obs-studio
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y obs-studio
    else
        echo "Invalid option"
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub com.obsproject.Studio
    remove_obsstudio
else
    echo "error"
fi