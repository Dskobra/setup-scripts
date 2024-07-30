#!/usr/bin/bash

install_proton_plus(){
    ## template function for aasking to do distro package or flatpak
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
        package_proton_plus
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        flatpak install --user -y flathub com.vysp3r.ProtonPlus
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Unkown error has occurred."
    fi
}

package_proton_plus(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf copr enable -y wehagy/protonplus
        sudo dnf install -y protonplus
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo dnf copr enable -y wehagy/protonplus
        sudo rpm-ostree install protonplus
        sudo rpm-ostree apply-live
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Proton Plus isn't currently available in Debian. This will install the flatpak version."
        flatpak install --user -y flathub com.vysp3r.ProtonPlus
    else
        echo "Unkown error has occurred."
    fi
}

install_proton_plus