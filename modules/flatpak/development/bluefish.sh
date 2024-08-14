#!/usr/bin/bash

remove_bluefish(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y bluefish
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall bluefish
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y bluefish
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub nl.openoffice.bluefish
remove_bluefish
