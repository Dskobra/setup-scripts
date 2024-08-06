#!/usr/bin/bash

install_bottles(){
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
        flatpak remove --user -y com.usebottles.bottles
        package_bottles
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_bottles
        flatpak install --user -y flathub com.usebottles.bottles
        flatpak override com.usebottles.bottles --user --filesystem=xdg-config/MangoHud:ro
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_bottles(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y bottles
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install bottles
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Bottles isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub com.usebottles.bottles
        flatpak override com.usebottles.bottles --user --filesystem=xdg-config/MangoHud:ro
    else
        echo "Unkown error has occurred."
    fi
}

remove_bottles(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y bottles
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall bottles
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "Not removing bottles as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}
mkdir $HOME/bottles
install_bottles