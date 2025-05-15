#!/usr/bin/bash

package_chooser(){
    echo "Select the type of package to install."
    echo "Enter an option or leave blank for default"
    echo "(1) Native(default)                               (2) Flatpak"
    echo "(h) Help                                          (3) Cancel"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ] || [ -z "$PACKAGE_TYPE" ]
    then
        flatpak remove --user -y com.valvesoftware.Steam
        "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
        "$SCRIPTS_FOLDER"/modules/packages/gaming/game_tools.sh "native"
        sudo dnf install -y steam
        sudo dnf install -y steam-devices
        sudo dnf mark user -y steam-devices
    elif [ "$PACKAGE_TYPE" == "2" ]
    then
        "$SCRIPTS_FOLDER"/modules/packages/gaming/game_tools.sh "flatpak"
        flatpak install --user -y flathub com.valvesoftware.Steam
        flatpak override com.valvesoftware.Steam  --user --filesystem=xdg-config/MangoHud:ro
        echo "steam-devices package will also be installed for controller support."
        sudo dnf remove -y steam
        sudo dnf install -y steam-devices
        sudo dnf mark user -y steam-devices
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
mkdir $HOME/Games
package_chooser
