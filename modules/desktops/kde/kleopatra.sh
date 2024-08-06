#!/usr/bin/bash

install_kleopatra(){
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
        flatpak remove --user -y org.kde.kleopatra
        package_kleopatra
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_kleopatra
        flatpak install --user -y flathub org.kde.kleopatra
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_kleopatra(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kleopatra
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install kleopatra
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kleopatra
    else
        echo "Unkown error has occurred."
    fi
}

remove_kleopatra(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y kleopatra
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall kleopatra
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y kleopatra
    else
        echo "Unkown error has occurred."
    fi
}

install_kleopatra