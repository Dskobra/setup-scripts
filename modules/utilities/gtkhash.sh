
#!/usr/bin/bash

install_gtkhash(){
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
        package_gtkhash
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.gtkhash.gtkhash
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_gtkhash(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y gtkhash
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install gtkhash
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y gtkhash
    else
        echo "Unkown error has occurred."
    fi
}

install_gtkhash