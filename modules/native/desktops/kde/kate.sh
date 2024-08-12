#!/usr/bin/bash

# Basic templates for adding more packages. Simply add the first option
# if you want to choose between flatpak or non flatpak or the 2nd one
# if you only want the distro provided package. Added it to a menu
# in setup.sh and launch $SCRIPTS_FOLDER/modules/folder_name/script_name.sh

install_kate(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kate kate-plugins
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install kate kate-plugins --allow-inactive
        sudo rpm-ostree apply-live     
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kate
    else
        echo "Unkown error has occurred."
    fi
}

install_kate