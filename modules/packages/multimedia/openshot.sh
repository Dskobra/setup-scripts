#!/usr/bin/bash
package_chooser(){
    echo "Select the type of package to install."
    echo "Enter an option or leave blank for default"
    echo "(1) Native                                        (2) Flatpak(default)"
    echo "(3) Help                                          (3) Cancel"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ]
    then
        flatpak uninstall --user -y org.openshot.OpenShot
        "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
        sudo dnf install -y openshot
    elif [ "$PACKAGE_TYPE" == "2" ] || [ -z "$PACKAGE_TYPE" ]
    then
        flatpak install --user -y flathub org.openshot.OpenShot
        sudo dnf remove -y openshot
    elif [ "$PACKAGE_TYPE" == "3" ]
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
