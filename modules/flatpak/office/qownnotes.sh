#!/usr/bin/bash

remove_qownnotes(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y qownnotes
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing marknote as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.qownnotes.QOwnNotes
remove_qownnotes
