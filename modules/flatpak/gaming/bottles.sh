#!/usr/bin/bash

remove_bottles(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y bottles
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall bottles
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing bottles as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/bottles
flatpak install --user -y flathub com.usebottles.bottles
flatpak override com.usebottles.bottles --user --filesystem=xdg-config/MangoHud:ro
remove_bottles
