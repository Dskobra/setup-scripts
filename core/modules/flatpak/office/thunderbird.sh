#!/usr/bin/bash

remove_thunderbird(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y thunderbird
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y thunderbird
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.mozilla.Thunderbird
remove_thunderbird
