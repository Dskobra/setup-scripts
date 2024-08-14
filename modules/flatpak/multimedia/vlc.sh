#!/usr/bin/bash

remove_vlc(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y vlc
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall vlc
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y vlc
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.videolan.VLC
remove_vlc
