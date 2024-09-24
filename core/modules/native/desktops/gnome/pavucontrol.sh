#! /usr/bin/bash

install_pavucontrol(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y pavucontrol
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y pavucontrol
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.pulseaudio.pavucontrol
install_pavucontrol
