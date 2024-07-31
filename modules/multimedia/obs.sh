#!/usr/bin/bash

install_obsstudio(){
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
        package_obsstudio
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub com.obsproject.Studio
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_obsstudio(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y obs-studio
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install obs-studio
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y obs-studio
    else
        echo "Invalid option"
    fi
}

install_obsstudio