#!/usr/bin/bash

package_chooser(){
    echo "                      |-----Package type-----|"
    echo "(1) Native(default)                               (2) Flatpak"
    echo "(h) Help                                          (0) Cancel"
    echo "Enter an option or leave blank for default"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ] || [ -z "$PACKAGE_TYPE" ]
    then
        flatpak remove --user -y com.transmissionbt.Transmission
        sudo dnf install -y transmission-gtk
    elif [ "$PACKAGE_TYPE" == "2" ]
    then
        flatpak install --user -y  flathub com.transmissionbt.Transmission
        sudo dnf remove -y transmission-gtk
    elif [ "$PACKAGE_TYPE" == "h" ]  || [ "$PACKAGE_TYPE" == "H" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/help.sh
    elif [ "$PACKAGE_TYPE" == "0" ]
    then
        echo "User canceled"
    else
        echo "Unkown error has occurred."
    fi
}

package_chooser
