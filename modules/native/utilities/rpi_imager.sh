#!/usr/bin/bash

install_rpi_imager(){
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
        flatpak remove --user -y org.raspberrypi.rpi-imager
        package_rpi_imager
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.raspberrypi.rpi-imager
       remove_rpi_imager
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_rpi_imager(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y rpi-imager
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install rpi-imager
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Raspberry Pi Imager isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub org.raspberrypi.rpi-imager
    else
        echo "Unkown error has occurred."
    fi
}

remove_rpi_imager(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y rpi-imager
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall rpi-imager
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "Not removing Raspberry Pi Imager as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

install_rpi_imager