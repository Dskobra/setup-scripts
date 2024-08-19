#!/usr/bin/bash

remove_kde_iso_image_writer(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y isoimagewriter
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing isoimagewriter as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.kde.isoimagewriter
remove_kde_iso_image_writer
