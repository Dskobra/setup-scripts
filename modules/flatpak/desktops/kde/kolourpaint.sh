#!/usr/bin/bash

remove_kolourpaint(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y kolourpaint
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall kolourpaint
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y kolourpaint
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.kde.kolourpaint
remove_kolourpaint
