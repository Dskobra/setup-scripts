#!/usr/bin/bash

remove_kleopatra(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y kleopatra
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall kleopatra
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y kleopatra
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.kde.kleopatra
remove_kleopatra
