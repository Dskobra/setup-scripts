#!/usr/bin/bash

remove_steam(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y steam
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall steam
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
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
zenity --info --text="steam-devices package will also be installed for controller support."
"$SCRIPTS_FOLDER"/modules/native/gaming/steam_devices.sh
