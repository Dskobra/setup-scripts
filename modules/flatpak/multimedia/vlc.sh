#!/usr/bin/bash

remove_vlc(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y vlc
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y vlc
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.videolan.VLC
remove_vlc
