#!/usr/bin/bash

remove_thunderbird(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y thunderbird
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall thunderbird
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y thunderbird
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.mozilla.Thunderbird
remove_thunderbird