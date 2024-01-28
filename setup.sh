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
    DISTRO=$(source /etc/os-release ; echo $ID)
    if [ $DISTRO == "fedora" ]
    then
        $SCRIPTS_HOME/modules/fedora/fedora.sh

    elif [ $DISTRO == "opensuse-tumbleweed" ]
    then
        $SCRIPTS_HOME/modules/opensuse/opensuse.sh
    elif [ $DISTRO == "debian" ]
    then
        echo "Not yet supported."
    else
        echo "Unsupported distro"
    fi

}

VERSION="dev branch"
export SCRIPTS_HOME=$(pwd)
mkdir $SCRIPTS_HOME/temp        # make a temp folder for all files to be downloaded to
launch_menu