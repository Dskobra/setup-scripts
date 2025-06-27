#!/usr/bin/bash

mkdir $HOME/.config/MangoHud
flatpak install --user -y flathub com.vysp3r.ProtonPlus
flatpak install --user -y flathub com.github.Matoking.protontricks
sudo dnf install -y steam-devices
sudo dnf install -y gamemode.x86_64 gamemode.i686
sudo dnf install -y goverlay
sudo dnf mark user -y gamemode.x86_64
sudo dnf mark user -y gamemode.i686
sudo dnf mark user -y steam-devices

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
elif [ "$1" == "native" ]
then
    "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
    sudo dnf install -y mangohud
else
    echo "error"
fi
