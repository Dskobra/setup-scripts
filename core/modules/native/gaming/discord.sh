#!/usr/bin/bash

install_discord(){
    if [ "$PKGMGR" == "dnf" ]
    then
        flatpak remove --user -y com.discordapp.Discord
        sudo dnf install -y discord
    elif [ "$PKGMGR" == "apt-get" ]
    then
        zenity --info --text="Discord isn't currently available in Debian. This will install the flatpak version."
        "$SCRIPTS_FOLDER"/modules/flatpak/gaming/discord.sh
    else
        echo "Unkown error has occurred."
    fi
}

install_discord
