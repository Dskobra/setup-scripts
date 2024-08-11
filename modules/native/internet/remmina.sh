#!/usr/bin/bash

install_remmina(){
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
        package_remmina
        flatpak remove --user -y org.remmina.Remmina
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_remmina
        flatpak install --user -y flathub org.remmina.Remmina
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_remmina(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y remmina
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install remmina
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y remmina
    else
        echo "Unkown error has occurred."
    fi
}

remove_remmina(){
    
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y remmina
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall remmina
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y remmina
    else
        echo "Unkown error has occurred."
    fi
}

install_remmina