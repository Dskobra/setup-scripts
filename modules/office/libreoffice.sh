#!/usr/bin/bash

install_libreoffice(){
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
        package_libreoffice
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_libreoffice
        flatpak install --user -y flathub org.libreoffice.LibreOffice
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_libreoffice(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y libreoffice
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install libreoffice
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y libreoffice
    else
        echo "Unkown error has occurred."
    fi
}

remove_libreoffice(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y libreoffice*
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree remove libreoffice
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y libreoffice*
    else
        echo "Unkown error has occurred."
    fi
}
install_libreoffice