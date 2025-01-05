#!/usr/bin/bash

native_gtkhash(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y gtkhash
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        echo "============================================="
        echo "gtkhash isn't available in openSUSE."
        echo "Please select the flatpak version."
        echo "============================================="
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y gtkhash
    else
        echo "Unkown error has occurred."
    fi
}

remove_gtkhash(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y gtkhash
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        echo "Not removing gtkhash as it's not present in openSUSE repos."
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y gtkhash
    else
        echo "Unkown error has occurred."
    fi
}


if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.gtkhash.gtkhash
    remove_gtkhash
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.gtkhash.gtkhash
    native_gtkhash
else
    echo "error"
fi