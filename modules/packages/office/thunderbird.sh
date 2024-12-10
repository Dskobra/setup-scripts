#!/usr/bin/bash

native_thunderbird(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y thunderbird
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n rm MozillaThunderbird
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y thunderbird
    else
        echo "Unkown error has occurred."
    fi
}

remove_thunderbird(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y thunderbird
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo zypper -n rm MozillaThunderbird
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y thunderbird
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.mozilla.Thunderbird
    remove_thunderbird
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.mozilla.Thunderbird
    native_thunderbird
else
    echo "error"
fi