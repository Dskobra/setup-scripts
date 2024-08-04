#!/usr/bin/bash

install_kpat(){
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
        package_kpat
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_kpat
        flatpak install --user -y flathub org.kde.kpat
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_kpat(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kpat
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install kpat
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kpat
    else
        echo "Unkown error has occurred."
    fi
}

remove_kpat(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y kpat
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall kpat
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y kpat
    else
        echo "Unkown error has occurred."
    fi
}

install_kpat