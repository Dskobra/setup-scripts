#!/usr/bin/bash

extra_games(){
    cd "$HOME"/Downloads
    wget https://launcher.mojang.com/download/Minecraft.tar.gz
    tar -xvf Minecraft.tar.gz
    cd minecraft-launcher
    chmod +x minecraft-launcher
    mv minecraft-launcher "$HOME"/Desktop
    cd "$HOME"/Downloads
    rm -r minecraft-launcher
    rm Minecraft.tar.gz

    WOWUPLINK=https://github.com/WowUp/WowUp.CF/releases/download/v2.9.4/WowUp-CF-2.9.4.AppImage
    WOWUPBINARY=v2.9.4/WowUp-CF-2.9.4.AppImage
    cd "$HOME"/Desktop
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
}

about(){
    VERSION="6.9.2023"
    echo "================================================"
    echo "Copyright (c) 2021-2023 Jordan Bottoms"
    echo "Released under the MIT license"
    echo "Version: $VERSION"
    echo "================================================"
}