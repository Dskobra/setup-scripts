#! /usr/bin/bash

native_dconf_editor(){
    flatpak remove --user -y ca.desrt.dconf-editor
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y dconf-editor
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install dconf-editor
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y dconf-editor
    else
        echo "Unkown error has occurred."
    fi 
}

remove_dconf_editor(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y dconf-editor
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm dconf-editor
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y dconf-editor
    else
        echo "Unkown error has occurred."
    fi
}


if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub ca.desrt.dconf-editor
    remove_dconf_editor
elif [ "$1" == "native" ]
then
    native_dconf_editor
else
    echo "error"
fi
