#!/usr/bin/bash

remove_qownnotes(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y qownnotes
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall qownnotes
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing marknote as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.qownnotes.QOwnNotes
remove_qownnotes
