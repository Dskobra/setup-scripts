#!/usr/bin/bash

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

remove_rpi_imager
flatpak install --user -y flathub org.raspberrypi.rpi-imager