#!/usr/bin/bash

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

remove_steam
flatpak install --user -y flathub com.valvesoftware.Steam
flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
flatpak override com.valvesoftware.Steam  --user --filesystem=xdg-config/MangoHud:ro
echo "steam-devices package will also be installed for controller support."
#zenity --info --text="steam-devices package will also be installed for controller support."
"$SCRIPTS_FOLDER"/modules/native/gaming/steam_devices.sh
