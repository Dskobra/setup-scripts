#!/usr/bin/bash
########################################
# These functions determine things like
# distro and if using Fedora atomic
# variants.
########################################
distro_check(){
# Read $DISTRO then figure out if it's supported
# version
    if [ "$DISTRO" == "fedora" ]
    then
        fedora_release_check

    elif [ $DISTRO == "opensuse-tumbleweed" ]
    then
        opensuse_release_check
    elif [ "$DISTRO" == "debian" ]
    then
        debian_release_check
    else
        echo "Unsupported distro"
    fi

}

fedora_release_check(){
    # checks if Fedora version is among supported versions.
    if [ "$VERSION_ID" == "40" ] || [ "$VERSION_ID" == "41" ]
    then
        fedora_variant_check                # run an extra check to see if it's an atomic variant
    else
        echo "These scripts only support Fedora 40/41"
    fi

}

fedora_variant_check(){
# Fedora Workstation/Server and Desktop Spins
# use dnf as their package manager while
# Atomic Desktop Editions use rpm-ostree
# which is very different. Atomic editions
# highly encourage flatpak so it is the default
# and limited native packages are provided.
    VARIANT="" 
    test -f /run/ostree-booted && VARIANT=ostree
    if [ -z "$VARIANT" ]
    then
        PKGMGR="dnf"
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    elif [ "$VARIANT" == "ostree" ]
    then
        PKGMGR="rpm-ostree"
        PACKAGE_TYPE="flatpak"
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/ostree_menu.sh
    fi
}

opensuse_release_check(){
    if [ "$VERSION_ID" == "12" ]
    then
        PKGMGR="zypper"
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    else
        echo "Unkown error occured."
    fi

}

debian_release_check(){
    if [ "$VERSION_ID" == "12" ]
    then
        PKGMGR="apt-get"
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    else
        echo "These scripts only support Debian 12"
    fi

}

########################################
# End of grouped functions
########################################

# This asks user to choose between native or flatpak apps and
# runs the appropriate menu

package_type_chooser(){
    echo "Please input the package type you'd like to use."
    echo "----------------------------------------"
    echo "[1] Flatpak [2] Native [3] Help [0] Exit"
    echo "----------------------------------------"
    echo "(empty) default option which is flatpak"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        PACKAGE_TYPE="flatpak"
        "$SCRIPTS_FOLDER"/modules/core/flatpak_menu.sh
    elif [ "$input" = 2 ] 
    then
        PACKAGE_TYPE="native"
        "$SCRIPTS_FOLDER"/modules/core/native_menu.sh
    elif [ "$input" = 3 ]
    then
        "$SCRIPTS_FOLDER"/modules/core/packages_help_page.sh
        package_type_chooser
    elif [ "$input" = 0 ]
    then
        echo "Will now exit."
        exit
    else
        echo "Invalid option or error has occurred."
    fi
}

DISTRO=$(source /etc/os-release ; echo $ID)                      # store basic distro name
VERSION_ID=$(source /etc/os-release ; echo "$VERSION_ID")        # store distro version number
distro_check                                                     # determine distro