#!/usr/bin/bash

install_bottles(){
    if [ $PKGMGR == "dnf" ]
    then
        flatpak remove --user -y com.usebottles.bottles
        sudo dnf install -y bottles
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Bottles isn't currently available in Debian. This will install the flatpak version."
        $SCRIPTS_FOLDER/modules/flatpak/gaming/bottles.sh
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/bottles
install_bottles