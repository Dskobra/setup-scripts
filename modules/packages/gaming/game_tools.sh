#!/usr/bin/bash

mkdir $HOME/.config/MangoHud
flatpak install --user -y flathub com.vysp3r.ProtonPlus
flatpak install --user -y flathub com.github.Matoking.protontricks           
if [ "$1" == "flatpak" ]
then
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
elif [ "$1" == "native" ]
then
    sudo dnf install -y mangohud
else
    echo "error"
fi
