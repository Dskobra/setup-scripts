#!/usr/bin/bash

package_marknote(){
    if [ $PKGMGR == "dnf" ]
    then
        flatpak remove --user -y org.kde.marknote
        sudo dnf install -y marknote
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install marknote
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Marknote isn't currently available in Debian. This will install the flatpak version."
        $SCRIPTS_FOLDER/modules/flatpak/office/marknote.sh
    else
        echo "Unkown error has occurred."
    fi
}

package_marknote
