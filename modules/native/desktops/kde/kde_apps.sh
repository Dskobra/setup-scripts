#!/usr/bin/bash

packages_kde(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y ark kate krdc kcalc kamoso gwenview\
        kleopatra okular
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        remove_kinoite_flatpaks
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

packages_kde