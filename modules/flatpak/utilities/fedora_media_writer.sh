#!/usr/bin/bash

remove_fmedia_writer(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y mediawriter
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall mediawriter
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "Not removing Fedora media writer as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

remove_fmedia_writer
flatpak install --user -y flathub org.fedoraproject.MediaWriter