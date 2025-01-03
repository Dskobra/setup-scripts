#!/usr/bin/bash

native_game_runtimes(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y mangohud gamescope gamemode
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n install mangohud gamescope gamemode
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y mangohud gamescope gamemode
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/.config/MangoHud           
if [ "$1" == "flatpak" ]
then
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
    flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
elif [ "$1" == "native" ]
then
    native_game_runtimes
else
    echo "error"
fi