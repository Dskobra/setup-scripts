#!/usr/bin/bash

package_discord(){
    if [ $PKGMGR == "dnf" ]
    then
        flatpak remove --user -y com.discordapp.Discord
        sudo dnf install -y discord
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install discord
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Discord isn't currently available in Debian. This will install the flatpak version."
        $SCRIPTS_FOLDER/modules/flatpak/gaming/discord.sh
    else
        echo "Unkown error has occurred."
    fi
}

package_discord