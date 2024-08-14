#!/usr/bin/bash

remove_dropbox(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y dropbox
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall dropbox
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y caja-dropbox nautilus-dropbox
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub com.dropbox.Client
remove_dropbox
