#!/usr/bin/bash

install_proton_plus(){
    if [ $PKGMGR == "dnf" ]
    then
        flatpak remove --user -y com.vysp3r.ProtonPlus
        sudo dnf copr enable -y wehagy/protonplus
        sudo dnf install -y protonplus
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Proton Plus isn't currently available in Debian. This will install the flatpak version."
        $SCRIPTS_FOLDER/modules/flatpak/gaming/proton_plus.sh
    else
        echo "Unkown error has occurred."
    fi
}

install_proton_plus