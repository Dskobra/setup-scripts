#!/usr/bin/bash

remove_libreoffice(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y libreoffice*
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree remove libreoffice
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y libreoffice*
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.libreoffice.LibreOffice
remove_libreoffice