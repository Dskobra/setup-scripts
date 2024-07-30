#!/usr/bin/bash

install_lutris(){
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
        lutris_package
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
            flatpak install --user -y flathub org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
            flatpak install --user -y flathub net.lutris.Lutris
            flatpak override net.lutris.Lutris --user --filesystem=xdg-config/MangoHud:ro
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

lutris_package(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y lutris
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install lutris
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y lutris
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/Games
install_lutris