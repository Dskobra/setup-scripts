#!/usr/bin/bash
#  This determines the distro and sets PKGMGR
# to related package manager

distro_check(){
    if [ "$DISTRO" == "fedora" ]
    then
        fedora_release_check
    elif [ "$DISTRO" == "debian" ]
    then
        debian_release_check
    else
        echo "Unsupported distro"
    fi

}

fedora_release_check(){
    if [ "$VERSION_ID" == "39" ] || [ "$VERSION_ID" == "40" ] || [ "$VERSION_ID" == "41" ]
    then
        fedora_variant_check
    else
        echo "These scripts only support Fedora 39/40/41 beta(experimental)"
    fi

}

fedora_variant_check(){
# Fedora Workstation/Server and Desktop Spins
# use dnf as their package manager while
# Atomic Desktop Editions use rpm-ostree
# which is very different. Atomic editions
# highly encourage flatpak so it is the default
# and limited native packages are provided.

    test -f /run/ostree-booted && VARIANT=ostree
    if [ -z "$VARIANT" ]
    then
        PKGMGR="dnf"
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/package_type_chooser.sh
    elif [ "$VARIANT" == "ostree" ]
    then
        PKGMGR="rpm-ostree"
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/flatpak_menu.sh
    fi
}

debian_release_check(){
    if [ "$VERSION_ID" == "12" ]
    then
        PKGMGR="apt-get"
        "$SCRIPTS_FOLDER"/modules/core/prereq.sh
        "$SCRIPTS_FOLDER"/modules/core/package_type_chooser.sh
    else
        echo "These scripts only support Debian 12"
    fi

}



OS_NAME=$(source /etc/os-release ; echo "$NAME")
export VERSION_ID=$(source /etc/os-release ; echo "$VERSION_ID")
DISTRO=$(source /etc/os-release ; echo $ID)
VARIANT=""      
distro_check
