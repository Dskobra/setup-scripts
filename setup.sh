#!/usr/bin/bash

launch_menu(){
    echo "          ---------------------------"   
    echo "          |   DSK's Setup Scripts   |"
    echo "          ---------------------------" 
    echo ""
    echo "            Version: $VERSION"
    echo "     Copyright (c) 2021-2023 Jordan Bottoms"
    echo "         Released under the MIT license"
    echo ""
    distro_check
}

distro_check(){
    rm PKGMGR.txt
    DISTRO=$(source /etc/os-release ; echo $ID)
    if [ $DISTRO == "fedora" ]
    then
        $SCRIPTS_HOME/modules/menu.sh
        fedora_variant_check
    elif [ $DISTRO == "opensuse-tumbleweed" ]
    then
        $PKGMGR="zypper"
        echo $PKGMGR >> PKGMGR.txt
        $SCRIPTS_HOME/modules/menu.sh
    elif [ $DISTRO == "debian" ]
    then
        echo "Not yet supported."
    else
        echo "Unsupported distro"
    fi

}

fedora_variant_check(){
    test -f /run/ostree-booted && VARIANT=ostree
    if [ ! -n "$VARIANT" ]
    then
        PKGMGR="dnf"
        echo "Fedora spin not detected as immutable."
        echo "Setting package manager to $PKGMGR."
    elif [ $VARIANT == "ostree" ]
    then
        PKGMGR="rpm-ostree"
        echo "Fedora spin detected as immutable"
        echo "Setting package manager to $PKGMGR."
        echo "Please note this is experimental atm"
    fi
}

VERSION="menu-test branch"
DISTRO=""
PKGMGR=""
VARIANT=""
export SCRIPTS_HOME=$(pwd)
mkdir $SCRIPTS_HOME/temp        # make a temp folder for all files to be downloaded to
launch_menu
