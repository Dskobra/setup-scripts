#!/usr/bin/bash

remove_lutris(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y lutris
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y lutris
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/Games
remove_lutris
flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
flatpak install --user -y flathub net.lutris.Lutris
flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
