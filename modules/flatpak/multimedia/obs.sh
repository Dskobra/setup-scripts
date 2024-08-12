#!/usr/bin/bash

remove_obsstudio(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y obs-studio
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall obs-studio
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y obs-studio
    else
        echo "Invalid option"
    fi
}

flatpak install --user -y flathub com.obsproject.Studio
remove_obsstudio