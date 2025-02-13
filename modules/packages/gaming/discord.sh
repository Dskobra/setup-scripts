#!/usr/bin/bash

native_discord(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y  libayatana-appindicator-gtk3  libayatana-ido-gtk3\
        libayatana-indicator-gtk3 
        sudo dnf install -y discord
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install discord
    else
        echo "Unkown error has occurred."
    fi
}

remove_discord(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y discord
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm discord
    else
        echo "Unkown error has occurred."
    fi
}

download_discord(){
    DISCORDLINK="https://discord.com/api/download?platform=linux&format=tar.gz"
    if test -d /opt/apps/Discord; then
        echo "Discord already downloaded."
    elif ! test -d /opt/apps/Discord; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o discord.tar.gz "$DISCORDLINK"
        tar -xvf discord.tar.gz
        rm discord.tar.gz
        mv discord /opt/apps/Discord
        cd $SCRIPTS_FOLDER
        echo "Discord is stored in /opt/apps/Discord" >> "$SCRIPTS_FOLDER"/logs/discord.txt 
        echo "================================================================"
        echo "Discord is located at /opt/apps/Discord"
        echo "================================================================"
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub com.discordapp.Discord
    flatpak override --user com.discordapp.Discord --env=XDG_SESSION_TYPE=x11
    remove_discord
elif [ "$1" == "native" ]
then
    flatpak remove --user -y com.discordapp.Discord
    native_discord
else
    echo "error"
fi
