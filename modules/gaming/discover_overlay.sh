#!/usr/bin/bash

install_discover_overlay(){
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
        flatpak remove --user -y flathub io.github.trigg.discover_overlay
        package_discover_overlay
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_discover_overlay
        flatpak install --user -y flathub io.github.trigg.discover_overlay
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Unkown error has occurred."
    fi
}

package_discover_overlay(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf copr enable -y mavit/discover-overlay
        sudo dnf install -y discover-overlay
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo dnf copr enable -y mavit/discover-overlay
        sudo rpm-ostree install -y discover-overlay
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="discover-overlay isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y io.github.trigg.discover_overlay
    else
        echo "Unkown error has occurred."
    fi
}

remove_discover_overlay(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y discover-overlay
        sudo rm /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:mavit:discover-overlay.repo
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall -y discover-overlay
        sudo rm /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:mavit:discover-overlay.repo
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "Not removing discover-overlay as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

install_discover_overlay