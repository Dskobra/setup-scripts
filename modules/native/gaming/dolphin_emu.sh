#!/usr/bin/bash

install_dolphin_emu(){
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
        flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
        package_dolphin_emu
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_dolphin_emu
        flatpak install --user -y flathub org.DolphinEmu.dolphin-emu
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

package_dolphin_emu(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y dolphin-emu
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install dolphin-emu
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y dolphin-emu
    else
        echo "Unkown error has occurred."
    fi
}

remove_dolphin_emu(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y dolphin-emu
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall dolphin-emu
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y dolphin-emu
    else
        echo "Unkown error has occurred."
    fi
}

install_dolphin_emu