#!/usr/bin/bash

install_discord_deps(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y  libayatana-appindicator-gtk3  libayatana-ido-gtk3\
        libayatana-indicator-gtk3 
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install libatomic1 libayatana-appindicator3-1
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
        mv Discord /opt/apps/Discord
        ln -s "/opt/apps/Discord/Discord" "/home/$USER/bin/Discord"
        cp "$SCRIPTS_FOLDER"/modules/data/discord.desktop /home/$USER/Desktop
        echo "Discord is stored in /opt/apps/Discord" >> "$SCRIPTS_FOLDER"/install.txt 
        echo "================================================================"
        echo "Discord is located at /opt/apps/Discord"
        echo "================================================================"
    fi
}

install_discord_deps
download_discord