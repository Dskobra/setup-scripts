#!/usr/bin/bash


remove_openshot(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y openshot
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall openshot
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y openshot-qt
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.openshot.OpenShot
remove_openshot