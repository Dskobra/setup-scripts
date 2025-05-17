#!/usr/bin/bash
package_chooser(){
    echo "Select the type of package to install."
    echo "Enter an option or leave blank for default"
    echo "(1) Native(default)                               (2) Flatpak"
    echo "(h) Help                                          (0) Cancel"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ] || [ -z "$PACKAGE_TYPE" ]
    then
        flatpak uninstall --user -y flathub org.kde.kdenlive
        "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
        sudo dnf install -y kdenlive
    elif [ "$PACKAGE_TYPE" == "2" ]
    then
        flatpak install --user -y flathub org.kde.kdenlive
        sudo dnf remove -y kdenlive
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
