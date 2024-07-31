#!/usr/bin/bash

# Basic templates for adding more packages. Simply add the first option
# if you want to choose between flatpak or non flatpak or the 2nd one
# if you only want the distro provided package. Added it to a menu
# in setup.sh and launch $SCRIPTS_FOLDER/modules/folder_name/script_name.sh

package_type_template(){
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
        echo "insert package function"
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        echo "insert flatpak(s)"
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/core/packages_help_page.sh
    else
        echo "Unkown error has occurred."
    fi
}

distro_package_template(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install --allow-inactive
        #sudo rpm-ostree apply-live     
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y
        #zenity --info --text="[app name] isn't currently available in [distro]. This will install the flatpak version."
    else
        echo "Unkown error has occurred."
    fi
}

# rpm-ostree apply-live doesn't work with all packages. Packages it doesnt work for are ones that do system changes
# such as kernel modules, ones that also add groups such as libvirt, boot themes. These you will need to reboot once so the overlay is fully applied.