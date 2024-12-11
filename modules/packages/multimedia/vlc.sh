#!/usr/bin/bash

native_vlc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y vlc
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install vlc-qt
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y vlc
    else
        echo "Unkown error has occurred."
    fi
}

remove_vlc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y vlc
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm vlc-qt
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y vlc
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