#!/usr/bin/bash

install_qownnotes(){
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
        package_qownnotes
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
       flatpak install --user -y flathub org.qownnotes.QOwnNotes
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Invalid option"
    fi
}

package_qownnotes(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y qownnotes
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install qownnotes
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="QOwnNotes isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub org.qownnotes.QOwnNotes
    else
        echo "Unkown error has occurred."
    fi
}

install_qownnotes