#!/usr/bin/bash

native_openshot(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y openshot
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install openshot-qt
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y openshot-qt
    else
        echo "Unkown error has occurred."
    fi
}

remove_openshot(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y openshot
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm openshot-qt
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y openshot-qt
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.openshot.OpenShot
    remove_openshot
elif [ "$1" == "native" ]
then
    flatpak uninstall --user -y org.openshot.OpenShot
    native_openshot
else
    echo "error"
fi