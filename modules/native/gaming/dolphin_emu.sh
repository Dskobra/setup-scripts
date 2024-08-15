#!/usr/bin/bash

install_dolphin_emu(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y dolphin-emu
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y dolphin-emu
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
install_dolphin_emu
