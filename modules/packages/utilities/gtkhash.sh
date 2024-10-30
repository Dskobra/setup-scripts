#!/usr/bin/bash

native_gtkhash(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y gtkhash
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y gtkhash
    else
        echo "Unkown error has occurred."
    fi
}

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


if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.gtkhash.gtkhash
    remove_gtkhash
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.gtkhash.gtkhash
    native_gtkhash
else
    echo "error"
fi