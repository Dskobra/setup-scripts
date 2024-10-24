#!/usr/bin/bash

remove_kinoite_flatpaks(){
    flatpak remove -y org.kde.elisa  
    flatpak remove -y org.kde.gwenview
    flatpak remove -y org.kde.kcalc
    flatpak remove -y org.kde.kmahjongg  
    flatpak remove -y org.kde.kmines 
    flatpak remove -y org.kde.kolourpaint  
    flatpak remove -y org.kde.krdc  
    flatpak remove -y org.kde.okular   
    flatpak remove -y org.fedoraproject.KDE5Platform
    flatpak remove -y org.fedoraproject.KDE6Platform 
}

remove_core_kde_apps(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y krdc kcalc kamoso gwenview\
        kleopatra okular
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        remove_kinoite_flatpaks
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y krdc kcalc kamoso\
        gwenview okular kleopatra
    else
        echo "Unkown error has occurred."
    fi
}

remove_core_kde_apps
flatpak install --user -y flathub org.kde.kcalc
flatpak install --user -y flathub org.kde.gwenview
flatpak install --user -y flathub org.kde.kamoso
flatpak install --user -y flathub org.kde.kleopatra
flatpak install --user -y flathub org.kde.krdc
