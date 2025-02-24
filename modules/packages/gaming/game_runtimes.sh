#!/usr/bin/bash

native_game_runtimes(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y mangohud gamemode
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install mangohud gamemode
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/.config/MangoHud           
if [ "$1" == "flatpak" ]
then
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
    flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08

    flatpak install --user -y flathub com.vysp3r.ProtonPlus
    flatpak install --user -y flathub com.github.Matoking.protontricks
elif [ "$1" == "native" ]
then
    native_game_runtimes
else
    echo "error"
fi