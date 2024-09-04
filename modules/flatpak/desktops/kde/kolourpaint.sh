#!/usr/bin/bash

remove_kolourpaint(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y kolourpaint
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y kolourpaint
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.kde.kolourpaint
remove_kolourpaint
