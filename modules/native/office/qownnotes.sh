#!/usr/bin/bash

install_qownnotes(){
    if [ $PKGMGR == "dnf" ]
    then
        flatpak remove --user -y org.qownnotes.QOwnNotes
        sudo dnf install -y qownnotes
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install qownnotes
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="QOwnNotes isn't currently available in Debian. This will install the flatpak version."
        $SCRIPTS_FOLDER/modules/flatpak/office/qownnotes.sh
    else
        echo "Unkown error has occurred."
    fi
}

install_qownnotes