#!/usr/bin/bash

### All the package install functions are here. packages.conf from the data
### branch includes the links for anything that doesn't have a repository.





### utilities




### Misc
### remove packages
# tempplates
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
        package_help_page
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
        #confirm_reboot
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y
        #zenity --info --text="[app name] isn't currently available in Debian. This will install the flatpak version."
    else
        echo "Unkown error has occurred."
    fi
}
