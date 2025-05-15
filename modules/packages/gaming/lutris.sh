#!/usr/bin/bash

package_chooser(){
    echo "Select the type of package to install."
    echo "Enter an option or leave blank for default"
    echo "(1) Native                                        (2) Flatpak(default)"
    echo "(h) Help                                          (3) Cancel"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ]
    then
        flatpak remove --user -y net.lutris.Lutris
        "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
        "$SCRIPTS_FOLDER"/modules/packages/gaming/game_tools.sh "native"
        sudo dnf install -y lutris
    elif [ "$PACKAGE_TYPE" == "2" ] || [ -z "$PACKAGE_TYPE" ]
    then
        "$SCRIPTS_FOLDER"/modules/packages/gaming/game_tools.sh "flatpak"
        flatpak install --user -y flathub net.lutris.Lutris
        flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
        sudo dnf remove -y lutris
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
