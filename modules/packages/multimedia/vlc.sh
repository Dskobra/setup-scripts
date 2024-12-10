#!/usr/bin/bash

native_vlc(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y vlc
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n install vlc-qt
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y vlc
    else
        echo "Unkown error has occurred."
    fi
}

remove_vlc(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y vlc
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n rm vlc-qt
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y vlc
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.videolan.VLC
    remove_vlc
elif [ "$1" == "native" ]
then
    flatpak uninstall --user -y org.videolan.VLC
    native_vlc
else
    echo "error"
fi