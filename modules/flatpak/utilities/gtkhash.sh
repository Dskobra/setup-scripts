#!/usr/bin/bash

remove_gtkhash(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y gtkhash
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y gtkhash
    else
        echo "Unkown error has occurred."
    fi
}

remove_gtkhash
flatpak install --user -y flathub org.gtkhash.gtkhash
