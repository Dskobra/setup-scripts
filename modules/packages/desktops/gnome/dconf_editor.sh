#! /usr/bin/bash

native_dconf_editor(){
    flatpak remove --user -y ca.desrt.dconf-editor
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y dconf-editor

    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n install dconf-editor
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y dconf-editor
    else
        echo "Unkown error has occurred."
    fi 
}

remove_dconf_editor(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y dconf-editor
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n rm dconf-editor
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y dconf-editor
    else
        echo "Unkown error has occurred."
    fi
}


if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub ca.desrt.dconf-editor
    remove_dconf_editor
elif [ "$1" == "native" ]
then
    native_dconf_editor
else
    echo "error"
fi
