#!/usr/bin/bash

install_kde_iso_image_writer(){
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
        package_kde_iso_image_writer
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub org.kde.isoimagewriter
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_kde_iso_image_writer(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y isoimagewriter
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install isoimagewriter
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="KDE ISO Image Writer isn't available in Debian so using flatpak version instead."
        flatpak install --user -y flathub org.kde.isoimagewriter
    else
        echo "Unkown error has occurred."
    fi
}

install_kde_iso_image_writer