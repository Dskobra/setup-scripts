#!/usr/bin/bash

native_qownnotes(){
    if [ "$PKGMGR" == "dnf" ]
    then
        
        sudo dnf install -y qownnotes
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "==============================================="
        echo "QOwnNotes isn't currently available in Debian."
        echo "This will install the flatpak version."
        echo "==============================================="
        flatpak install --user -y flathub org.qownnotes.QOwnNotes
    else
        echo "Unkown error has occurred."
    fi
}

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



if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.qownnotes.QOwnNotes
    remove_qownnotes
elif [ "$1" == "distro" ]
then
    flatpak remove --user -y org.qownnotes.QOwnNotes
    native_qownnotes
else
    echo "error"
fi