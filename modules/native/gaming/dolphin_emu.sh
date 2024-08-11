#!/usr/bin/bash

package_dolphin_emu(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y dolphin-emu
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install dolphin-emu
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y dolphin-emu
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
package_dolphin_emu