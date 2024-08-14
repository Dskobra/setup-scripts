#!/usr/bin/bash

remove_kpat(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y kpat
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall kpat
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y kpat
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.kde.kpat
remove_kpat
