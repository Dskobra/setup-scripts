#!/usr/bin/bash

install_remmina(){
    
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y remmina
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y remmina
    else
        echo "Unkown error has occurred."
    fi
}

remove_remmina(){
    
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y remmina
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y remmina
    else
        echo "Unkown error has occurred."
    fi
}


if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.remmina.Remmina
    remove_remmina
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.remmina.Remmina
    install_remmina
else
    echo "error"
fi