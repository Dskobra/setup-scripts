#!/usr/bin/bash

native_keepassxc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y keepassxc
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install keepassxc
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y keepassxc
    else
        echo "Unkown error has occurred."
    fi
}

remove_keepassxc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y keepassxc
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm keepassxc
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y keepassxc
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.keepassxc.KeePassXC
    remove_keepassxc
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.keepassxc.KeePassXC
    native_keepassxc
else
    echo "error"
fi