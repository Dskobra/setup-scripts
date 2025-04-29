#!/usr/bin/bash

native_vlc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y rpmfusion-free-release-tainted
        sudo dnf install -y libdvdcss
        sudo dnf install -y vlc
    else
        echo "Unkown error has occurred."
    fi
}

remove_vlc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y rpmfusion-free-release-tainted
        sudo dnf remove -y libdvdcss
        sudo dnf remove -y vlc
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.videolan.VLC
    remove_vlc
elif [ "$1" == "native" ]
then
    flatpak uninstall --user -y org.videolan.VLC
    native_vlc
else
    echo "error"
fi