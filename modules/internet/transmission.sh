#!/usr/bin/bash

install_transmission(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        package_transmission
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y  flathub com.transmissionbt.Transmission
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_transmission(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y transmission-gtk
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install transmission-gtk
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y transmission-gtk
    else
        echo "Unkown error has occurred."
    fi
}

install_transmission