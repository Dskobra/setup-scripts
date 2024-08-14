#!/usr/bin/bash

remove_keepassxc(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y keepassxc
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall keepassxc
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y keepassxc
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.keepassxc.KeePassXC
remove_keepassxc
