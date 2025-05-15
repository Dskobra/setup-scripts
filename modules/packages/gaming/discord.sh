#!/usr/bin/bash

download_discord(){
    DISCORDLINK="https://discord.com/api/download?platform=linux&format=tar.gz"
    if test -d /opt/apps/Discord; then
        echo "Discord already downloaded."
    elif ! test -d /opt/apps/Discord; then
        sudo dnf install -y  libayatana-appindicator-gtk3  libayatana-ido-gtk3\
        libayatana-indicator-gtk3
        cd /opt/apps/temp || exit
        curl -L -o discord.tar.gz "$DISCORDLINK"
        tar -xvf discord.tar.gz
        mv Discord /opt/apps/Discord
        ln -s "/opt/apps/Discord/Discord" "/home/$USER/bin/Discord"
        cp "$SCRIPTS_FOLDER"/modules/packages/gaming/discord.desktop /home/$USER/Desktop
        rm /opt/apps/temp/discord.tar.gz
        echo "Discord is stored in /opt/apps/Discord" >> "$SCRIPTS_FOLDER"/install.txt 
        echo "================================================================"
        echo "Discord is located at /opt/apps/Discord"
        echo "================================================================"
    fi
}

package_chooser(){
    echo "Select the type of package to install."
    echo "Enter an option or leave blank for default"
    echo "(1) Native(default)                               (2) Flatpak"
    echo "(h) Help                                          (0) Cancel"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ] || [ -z "$PACKAGE_TYPE" ]
    then
        flatpak remove --user -y com.discordapp.Discord
        sudo dnf install -y  discord
    elif [ "$PACKAGE_TYPE" == "2" ]
    then
        flatpak install --user -y flathub com.discordapp.Discord
        sudo dnf remove -y discord
    elif [ "$PACKAGE_TYPE" == "h" ]  || [ "$PACKAGE_TYPE" == "H" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/help.sh
    elif [ "$PACKAGE_TYPE" == "0" ]
    then
        echo "User canceled"
    else
        echo "Unkown error has occurred."
    fi
}

package_chooser
