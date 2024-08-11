#!/usr/bin/bash

package_kde_iso_image_writer(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y isoimagewriter
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install isoimagewriter
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="KDE ISO Image Writer isn't available in Debian so using flatpak version instead."
        $SCRIPTS_FOLDER/modules/flatpak/desktop/kde/kde_iso_image_writer.sh
    else
        echo "Unkown error has occurred."
    fi
}

package_kde_iso_image_writer