#! /usr/bin/bash

native_pavucontrol(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y pavucontrol
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n install pavucontrol
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y pavucontrol
    else
        echo "Unkown error has occurred."
    fi
}
remove_pavucontrol(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y pavucontrol
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n rm pavucontrol
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y pavucontrol
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.pulseaudio.pavucontrol
    remove_pavucontrol
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.pulseaudio.pavucontrol
    native_pavucontrol
else
    echo "error"
fi
