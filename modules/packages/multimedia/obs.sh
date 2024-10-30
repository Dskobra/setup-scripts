#!/usr/bin/bash

native_obsstudio(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y obs-studio
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y obs-studio
    else
        echo "Invalid option"
    fi
}

remove_obsstudio(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y obs-studio
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y obs-studio
    else
        echo "Invalid option"
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub com.obsproject.Studio
    remove_obsstudio
elif [ "$1" == "native" ]
then
    flatpak uninstall --user -y com.obsproject.Studio
    native_obsstudio
else
    echo "error"
fi