#!/usr/bin/bash

native_dolphin_emu(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y dolphin-emu
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install dolphin-emu
    else
        echo "Unkown error has occurred."
    fi
}

remove_dolphin_emu(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y dolphin-emu
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm dolphin-emu
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
    remove_dolphin_emu
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.DolphinEmu.dolphin-emu
    native_dolphin_emu
else
    echo "error"
fi