#!/usr/bin/bash

native_game_runtimes(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y mangohud gamescope gamemode
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n install mangohud gamescope gamemode
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y mangohud gamescope gamemode
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/.config/MangoHud           
if [ "$1" == "flatpak" ]
then
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08
    flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08
elif [ "$1" == "native" ]
then
    native_game_runtimes
else
    echo "error"
fi