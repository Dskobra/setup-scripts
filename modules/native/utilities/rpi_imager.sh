#!/usr/bin/bash

package_rpi_imager(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y rpi-imager
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Raspberry Pi Imager isn't currently available in Debian. This will install the flatpak version."
        $SCRIPTS_FOLDER/modules/flatpak/utilities/rpi_imager.sh
    else
        echo "Unkown error has occurred."
    fi
}

package_rpi_imager