#!/usr/bin/bash

remove_kde_iso_image_writer(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y isoimagewriter
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall isoimagewriter
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "Not removing isoimagewriter as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.kde.isoimagewriter
remove_kde_iso_image_writer