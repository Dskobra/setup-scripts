#!/usr/bin/bash

remove_discord(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y discord
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall discord
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "Not removing discord as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub com.discordapp.Discord
flatpak override --user com.discordapp.Discord --env=XDG_SESSION_TYPE=x11
remove_discord