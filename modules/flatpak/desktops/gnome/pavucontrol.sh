#! /usr/bin/bash

remove_pavucontrol(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y pavucontrol
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y pavucontrol
    else
        echo "Unkown error has occurred."
    fi
}

remove_pavucontrol
flatpak install --user -y flathub org.pulseaudio.pavucontrol
