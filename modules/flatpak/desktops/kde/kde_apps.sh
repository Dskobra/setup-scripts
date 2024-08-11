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

remove_core_kdeapps(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y ark kate krdc kcalc kamoso gwenview\
        kleopatra okular
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        remove_kinoite_flatpaks
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y ark kate krdc kcalc kamoso\
        gwenview okular kleopatra
        #zenity --info --text="[app name] isn't currently available in Debian. This will install the flatpak version."
    else
        echo "Unkown error has occurred."
    fi
}

remove_core_kdeapps
flatpak install --user -y flathub org.kde.kcalc
flatpak install --user -y flathub org.kde.gwenview
flatpak install --user -y flathub org.kde.kamoso
flatpak install --user -y flathub org.kde.kleopatra
flatpak install --user -y flathub org.kde.krdc