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
        opensuse_tumbleweed_release_check
    elif [ $DISTRO == "opensuse-slowroll" ]
    then
        opensuse_slowroll_release_check
    elif [ $DISTRO == "opensuse-leap" ]
    then
        opensuse_leap_release_check
    elif [ "$DISTRO" == "debian" ]
    then
        debian_release_check
    else
        echo "Unfortunately, '$DISTRO $VERSION_ID' is not a supported distro."
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
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    elif [ "$VARIANT" == "ostree" ]
    then
        echo "Atomic editions are not supported."
    fi
}

opensuse_tumbleweed_release_check(){
    if [ "$VERSION_ID" -gt "20240101" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    else
        echo "These scripts only support Tumbleweed released on or after 01/01/2024"
    fi

}

opensuse_slowroll_release_check(){
    if [ "$VERSION_ID" -gt "20240101" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    else
        echo "These scripts only support Slowroll released on or after 01/01/2024"
    fi

}

opensuse_leap_release_check(){
    if [ "$VERSION_ID" -gt "15.6" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    else
        echo "These scripts only support Leap 15.6+"
    fi

}

debian_release_check(){
    if [ "$VERSION_ID" == "12" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/menu.sh
    else
        echo "These scripts only support Debian 12"
    fi

}

########################################
# End of grouped functions
########################################

DISTRO=$(source /etc/os-release ; echo $ID)                      # store basic distro name
VERSION_ID=$(source /etc/os-release ; echo "$VERSION_ID")        # store distro version number
distro_check                                                     # determine distro