#!/usr/bin/bash

remove_kleopatra(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y kleopatra
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y kleopatra
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.kde.kleopatra
remove_kleopatra
