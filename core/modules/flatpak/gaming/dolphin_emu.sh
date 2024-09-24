#!/usr/bin/bash

remove_dolphin_emu(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y dolphin-emu
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y dolphin-emu
    else
        echo "Unkown error has occurred."
    fi
}


flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
remove_dolphin_emu
