#!/usr/bin/bash

install_remmina(){
    
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y remmina
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install remmina
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y remmina
    else
        echo "Unkown error has occurred."
    fi
}

remove_remmina(){

    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y remmina
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm remmina
    elif [ "$DISTRO" == "debian" ]
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