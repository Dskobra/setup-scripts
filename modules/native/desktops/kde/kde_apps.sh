#!/usr/bin/bash

install_kde_apps(){
    if [ "$PKGMG"R == "dnf" ]
    then
        sudo dnf install -y ark kate krdc kcalc kamoso gwenview\
        kleopatra okular
    elif [ "$PKGMG"R == "apt-get" ]
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
install_kde_apps
