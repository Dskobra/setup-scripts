#!/usr/bin/bash

native_mangohud(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y mangohud
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n install mangohud
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y mangohud
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/.config/MangoHud           
if [ "$1" == "flatpak" ]
then
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
elif [ "$1" == "native" ]
then
    native_mangohud
else
    echo "error"
fi