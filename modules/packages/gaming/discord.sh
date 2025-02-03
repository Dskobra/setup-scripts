#!/usr/bin/bash

native_discord(){
    if [ "$DISTRO" == "fedora" ]
    then
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
