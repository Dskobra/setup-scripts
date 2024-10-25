#!/usr/bin/bash

native_discord(){
    if [ "$PKGMGR" == "dnf" ]
    then
        flatpak remove --user -y com.discordapp.Discord
        sudo dnf install -y discord
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "========================================================"
        echo "Discord isn't currently available in Debian."
        echo "This will install the flatpak version."
        echo "========================================================"
        flatpak install --user -y flathub com.discordapp.Discord
        flatpak override --user com.discordapp.Discord --env=XDG_SESSION_TYPE=x11
    else
        echo "Unkown error has occurred."
    fi
}

remove_discord(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y discord
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing discord as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}




if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub com.discordapp.Discord
    flatpak override --user com.discordapp.Discord --env=XDG_SESSION_TYPE=x11
elif [ "$1" == "native" ]
then
    flatpak remove --user -y com.discordapp.Discord
    native_discord
else
    echo "error"
fi
