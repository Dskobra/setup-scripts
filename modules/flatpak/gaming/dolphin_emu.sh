#!/usr/bin/bash

remove_dolphin_emu(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y dolphin-emu
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall dolphin-emu
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y dolphin-emu
    else
        echo "Unkown error has occurred."
    fi
}


flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
remove_dolphin_emu