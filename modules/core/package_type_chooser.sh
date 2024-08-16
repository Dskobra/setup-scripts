#!/usr/bin/bash

# Basic templates for adding more packages. Simply add the first option
# if you want to choose between flatpak or non flatpak or the 2nd one
# if you only want the distro provided package. Added it to a menu
# in setup.sh and launch "$SCRIPTS_FOLDER"/modules/folder_name/script_name.sh

package_type_chooser(){
    echo "Please input the package type you'd like to use."
    echo "----------------------------------------"
    echo "[1] Flatpak [2] Native [3] Help [0] Exit"
    echo "----------------------------------------"
    echo "(empty) default option which is flatpak"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        PACKAGE_TYPE="flatpak"
        "$SCRIPTS_FOLDER"/modules/core/flatpak_menu.sh
    elif [ "$input" = 2 ] 
    then
        PACKAGE_TYPE="native"
        "$SCRIPTS_FOLDER"/modules/core/native_menu.sh
    elif [ "$input" = 3 ]
    then
        "$SCRIPTS_FOLDER"/modules/core/packages_help_page.sh
        package_type_chooser
    elif [ "$input" = 0 ]
    then
        echo "Will now exit."
        exit
    else
        echo "Invalid option or error has occurred."
    fi
}

package_type_chooser
