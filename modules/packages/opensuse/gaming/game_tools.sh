#!/usr/bin/bash

flatpak install --user -y flathub com.vysp3r.ProtonPlus
flatpak install --user -y flathub com.github.Matoking.protontricks
sudo zypper -n install gamemode steam-devices goverlay

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
elif [ "$1" == "native" ]
then
    "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.sh
    sudo zypper -n install mangohud
else
    echo "error"
fi
