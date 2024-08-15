#!/usr/bin/bash

install_vlc(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y vlc
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y vlc
    else
        echo "Unkown error has occurred."
    fi
}

flatpak uninstall --user -y org.videolan.VLC
install_vlc
