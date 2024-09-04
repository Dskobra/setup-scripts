#!/usr/bin/bash

install_thunderbird(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y thunderbird
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y thunderbird
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.mozilla.Thunderbird
install_thunderbird
