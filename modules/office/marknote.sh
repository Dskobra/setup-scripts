#!/usr/bin/bash

install_marknote(){
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
        package_marknote
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub org.kde.marknote
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

package_marknote(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y marknote
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install marknote
        sudo rpm-ostree apply-live
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Marknote isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub org.kde.marknote
    else
        echo "Unkown error has occurred."
    fi
}

install_marknote