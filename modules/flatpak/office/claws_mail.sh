#!/usr/bin/bash

remove_claws_mail(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y claws-mail
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall claws-mail
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y claws-mail
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.claws_mail.Claws-Mail
remove_claws_mail
