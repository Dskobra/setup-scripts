#!/usr/bin/bash

native_gtkhash(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y gtkhash
    else
        echo "Unkown error has occurred."
    fi
}

remove_gtkhash(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y gtkhash
    else
        echo "Unkown error has occurred."
    fi
}


package_chooser(){
    echo "Choose package type:"
    echo ""
    echo "1: flatpak 2: native"
    read -r input
    read input
    if [ "$input" == "1" ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub org.gtkhash.gtkhash
        remove_gtkhash
    elif [ "$input" == "2" ]
    then
        flatpak remove --user -y org.gtkhash.gtkhash
        native_gtkhash
    else
        echo ""
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
