#!/usr/bin/bash

packages_kde(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y ark kate krdc kcalc kamoso gwenview\
        kleopatra okular
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install ark kate krdc kcalc kamoso gwenview\
        kleopatra okular
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y ark kate krdc kcalc kamoso\
        gwenview okular kleopatra
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y  org.kde.kcalc
flatpak remove --user -y  org.kde.gwenview
flatpak remove --user -y  org.kde.kamoso
flatpak remove --user -y  org.kde.kleopatra
flatpak remove --user -y  org.kde.krdc
packages_kde