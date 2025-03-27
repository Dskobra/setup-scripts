#!/usr/bin/bash

install_remmina(){
    
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y remmina
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install remmina
    else
        echo "Unkown error has occurred."
    fi
}

remove_remmina(){

    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y remmina
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm remmina
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