#!/usr/bin/bash

native_keepassxc(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y keepassxc
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y keepassxc
    else
        echo "Unkown error has occurred."
    fi
}

remove_keepassxc(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y keepassxc
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y keepassxc
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.keepassxc.KeePassXC
    remove_keepassxc
elif [ "$1" == "distro" ]
then
    flatpak remove --user -y org.keepassxc.KeePassXC
    native_keepassxc
else
    echo "error"
fi