#!/usr/bin/bash

install_dropbox(){
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
        flatpak remove --user -y com.dropbox.Client
        package_dropbox
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_dropbox
        flatpak install --user -y flathub com.dropbox.Client
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_dropbox(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y dropbox
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install dropbox
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        package_dropbox_debian
    else
        echo "Unkown error has occurred."
    fi
}

package_dropbox_debian(){
    DESKTOP=$(echo $XDG_CURRENT_DESKTOP)
    if [ $DESKTOP == "GNOME" ]
    then
        sudo apt-get install -y nautilus-dropbox
    elif [ $DESKTOP == "MATE" ]
    then
        sudo apt-get install caja-dropbox
    else
        sudo apt-get install -y nautilus-dropbox
    fi
}

remove_dropbox(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y dropbox
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall dropbox
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y caja-dropbox nautilus-dropbox
    else
        echo "Unkown error has occurred."
    fi
}
install_dropbox