#!/usr/bin/bash

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

flatpak install --user -y flathub com.obsproject.Studio
remove_obsstudio
