#!/usr/bin/bash

install_openshot(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y openshot
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install openshot
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y openshot-qt
    else
        echo "Unkown error has occurred."
    fi
}

flatpak uninstall --user -y org.openshot.OpenShot
install_openshot