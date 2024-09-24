#!/usr/bin/bash

install_obsstudio(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y obs-studio
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y obs-studio
    else
        echo "Invalid option"
    fi
}

flatpak uninstall --user -y com.obsproject.Studio
install_obsstudio
