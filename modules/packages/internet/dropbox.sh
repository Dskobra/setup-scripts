#!/usr/bin/bash

native_dropbox(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y dropbox
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        sudo rpm-ostree install dropbox
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install dropbox
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y nautilus-dropbox
    else
        echo "Unkown error has occurred."
    fi
}


remove_dropbox(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y dropbox
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        sudo rpm-ostree remove dropbox
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm dropbox
    elif [ "$DISTRO" == "debian" ]
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