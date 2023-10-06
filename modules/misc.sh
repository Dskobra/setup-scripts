#!/usr/bin/bash

wowup(){
    WOWUPLINK=https://github.com/WowUp/WowUp.CF/releases/download/v2.10.0/WowUp-CF-2.10.0.AppImage
    WOWUPBINARY=WowUp-CF-2.10.0.AppImage

    if test -f /home/$USER/Desktop/$WOWUPBINARY; then
        echo "WoWUp already downloaded."
    elif ! test -f /home/$USER/Desktop/$WOWUPBINARY; then
        cd "$HOME"/Desktop
        wget $WOWUPLINK
        chmod +x $WOWUPBINARY
    fi
}

minecraft(){
    if test -f /home/$USER/Desktop/minecraft-launcher; then
        echo "WoWUp already downloaded."
    elif ! test -f /home/$USER/Desktop/minecraft-launcher; then
        cd "$HOME"/Downloads
        wget https://launcher.mojang.com/download/Minecraft.tar.gz
        tar -xvf Minecraft.tar.gz
        cd minecraft-launcher
        chmod +x minecraft-launcher
        mv minecraft-launcher "$HOME"/Desktop
        cd "$HOME"/Downloads
        rm -r minecraft-launcher
        rm Minecraft.tar.gz
    fi
}


about(){
    VERSION="6.14.2023"
    echo "================================================"
    echo "Copyright (c) 2021-2023 Jordan Bottoms"
    echo "Released under the MIT license"
    echo "Version: $VERSION"
    echo "================================================"
}