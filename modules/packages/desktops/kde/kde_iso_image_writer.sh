#!/usr/bin/bash

install_kde_iso_image_writer(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y isoimagewriter
    elif [ "$PKGMGR" == "apt-get" ]
    then
        #zenity --info --text="KDE ISO Image Writer isn't available in Debian so using flatpak version instead."
        echo "KDE ISO Image Writer isn't available in Debian so using flatpak version instead."
        "$SCRIPTS_FOLDER"/modules/flatpak/desktops/kde/kde_iso_image_writer.sh
    else
        echo "Unkown error has occurred."
    fi
}

install_kde_iso_image_writer
