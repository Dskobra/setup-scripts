#!/usr/bin/bash

install_geany(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is distro built."
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        flatpak remove --user -y org.geany.Geany
        package_geany
    elif [ "$input" = 2 ]
    then
        flatpak install --user -y flathub org.geany.Geany
        remove_geany
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Unkown error has occurred."
    fi
}

package_geany(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y geany geany-plugin-markdown geany-plugin-spellcheck geany-plugin-treebrowser
    else
        echo "Invalid option"
    fi
}

remove_geany(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y geany geany-plugin-markdown geany-plugin-spellcheck geany-plugin-treebrowser
    else
        echo "Invalid option"
    fi
}

install_geany