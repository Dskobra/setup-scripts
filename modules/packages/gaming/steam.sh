#!/usr/bin/bash

native_steam(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y steam
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree install steam
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    else
        echo "Unkown error has occurred."
    fi
}

native_steam_devices(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y steam-devices
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree install steam-devices
        #sudo rpm-ostree apply-live
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam-devices
    else
        echo "Unkown error has occurred."
    fi
}

remove_steam(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y steam
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y steam
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    remove_steam
    flatpak install --user -y flathub com.valvesoftware.Steam
    flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
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