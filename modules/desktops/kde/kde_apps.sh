#!/usr/bin/bash

install_kdeapps(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        packages_kde
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_core_kdeapps
        flatpak install --user -y flathub org.kde.ark
        flatpak install --user -y flathub org.kde.kcalc
        flatpak install --user -y flathub org.kde.gwenview
        flatpak install --user -y flathub org.kde.kamoso
        flatpak install --user -y flathub org.kde.kleopatra
        flatpak install --user -y flathub org.kde.krdc
     elif [ "$input" = 3 ]
     then
        package_help_page
    else
        echo "Invalid option"
    fi
}

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
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y ark kate krdc kcalc kamoso\
        gwenview okular kleopatra
    else
        echo "Unkown error has occurred."
    fi
}

install_kdeapps