#! /usr/bin/bash

remove_dconf_editor(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y dconf-editor
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        remove_silverblue_flatpaks
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y dconf-editor
    else
        echo "Unkown error has occurred."
    fi
}

remove_dconf_editor
flatpak install --user -y flathub ca.desrt.dconf-editor
