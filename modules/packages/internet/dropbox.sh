#!/usr/bin/bash

native_dropbox(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y dropbox
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree install dropbox
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        install_dropbox_debian
    else
        echo "Unkown error has occurred."
    fi
}

native_dropbox_debian(){
    DESKTOP=$(echo $XDG_CURRENT_DESKTOP)
    if [ $DESKTOP == "GNOME" ]
    then
        sudo apt-get install -y nautilus-dropbox
    elif [ $DESKTOP == "MATE" ]
    then
        sudo apt-get install caja-dropbox
    else
        sudo apt-get install -y nautilus-dropbox
    fi
}

remove_dropbox(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y dropbox
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree remove dropbox
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y caja-dropbox nautilus-dropbox
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub com.dropbox.Client
    remove_dropbox
elif [ "$1" == "native" ]
then
    flatpak remove --user -y com.dropbox.Client
    native_dropbox
else
    echo "error"
fi