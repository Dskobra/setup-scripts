#!/usr/bin/bash

native_qownnotes(){
    if [ "$DISTRO" == "fedora" ]
    then
        
        sudo dnf install -y qownnotes
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        echo "==============================================="
        echo "QOwnNotes isn't currently available in openSUSE."
        echo "This will install the flatpak version."
        echo "==============================================="
        flatpak install --user -y flathub org.qownnotes.QOwnNotes
    elif [ "$DISTRO" == "debian" ]
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
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y qownnotes
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        echo "Not removing QOwnNotes as it's not present in openSUSE repos."
    elif [ "$DISTRO" == "debian" ]
    then
        echo "Not removing QOwnNotes as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}



if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.qownnotes.QOwnNotes
    remove_qownnotes
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.qownnotes.QOwnNotes
    native_qownnotes
else
    echo "error"
fi