#!/usr/bin/bash

install_discord(){
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
        package_discord
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub com.discordapp.Discord
        flatpak override --user com.discordapp.Discord --env=XDG_SESSION_TYPE=x11
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_discord(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y discord
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install discord
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Discord isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub com.discordapp.Discord
        flatpak override --user com.discordapp.Discord --env=XDG_SESSION_TYPE=x11
    else
        echo "Unkown error has occurred."
    fi
}

install_discord