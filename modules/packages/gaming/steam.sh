#!/usr/bin/bash

native_steam(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y steam
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install steam
    else
        echo "Unkown error has occurred."
    fi
}

native_steam_devices(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y steam-devices
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install steam-devices
    else
        echo "Unkown error has occurred."
    fi
}

remove_steam(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y steam
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm steam
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    remove_steam
    flatpak install --user -y flathub com.valvesoftware.Steam
    flatpak override com.valvesoftware.Steam  --user --filesystem=xdg-config/MangoHud:ro
    echo "steam-devices package will also be installed for controller support."
    native_steam_devices
elif [ "$1" == "native" ]
then
    flatpak remove --user -y com.valvesoftware.Steam
    native_steam
    native_steam_devices
else
    echo "error"
fi