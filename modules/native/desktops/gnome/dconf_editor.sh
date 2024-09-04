#! /usr/bin/bash

install_dconf_editor(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y dconf-editor
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y dconf-editor
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y ca.desrt.dconf-editor
install_dconf_editor

