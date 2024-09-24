#!/usr/bin/bash

remove_bottles(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y bottles
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing bottles as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/bottles
flatpak install --user -y flathub com.usebottles.bottles
flatpak override com.usebottles.bottles --user --filesystem=xdg-config/MangoHud:ro
remove_bottles
