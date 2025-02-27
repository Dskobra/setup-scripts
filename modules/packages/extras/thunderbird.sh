#!/usr/bin/bash

native_thunderbird(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y thunderbird
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install MozillaThunderbird
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y thunderbird
    else
        echo "Unkown error has occurred."
    fi
}

remove_thunderbird(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y thunderbird
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm MozillaThunderbird
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