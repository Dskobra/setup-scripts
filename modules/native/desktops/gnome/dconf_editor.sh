#! /usr/bin/bash

distro_dconf_editor(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y dconf-editor
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y dconf-editor
    else
        echo "Unkown error has occurred."
    fi
    flatpak remove --user -y ca.desrt.dconf-editor
}

test(){
    # rename later
    
}

if [ "$1" == "flatpak" ]
then
    echo "flatpak test"
elif [ "$1" == "distro" ]
then
    distro_dconf_editor
else
    echo "error"
fi
