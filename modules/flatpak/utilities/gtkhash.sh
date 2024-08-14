#!/usr/bin/bash

remove_gtkhash(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y gtkhash
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall gtkhash
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y gtkhash
    else
        echo "Unkown error has occurred."
    fi
}

remove_gtkhash
flatpak install --user -y flathub org.gtkhash.gtkhash
