#!/usr/bin/bash

install_marknote(){
    if [ "$PKGMGR" == "dnf" ]
    then
        flatpak remove --user -y org.kde.marknote
        sudo dnf install -y marknote
    elif [ "$PKGMGR" == "apt-get" ]
    then
        zenity --info --text="Marknote isn't currently available in Debian. This will install the flatpak version."
        "$SCRIPTS_FOLDER"/modules/flatpak/office/marknote.sh
    else
        echo "Unkown error has occurred."
    fi
}

install_marknote
