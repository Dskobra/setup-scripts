#!/usr/bin/bash

launch_menu(){
    echo "          ---------------------"   
    echo "          |DSK's Setup Scripts|"
    echo "          ---------------------" 
    echo ""
    echo "            Version: $VERSION"
    echo "     Copyright (c) 2021-2023 Jordan Bottoms"
    echo "         Released under the MIT license"
    echo ""
    echo "                  Menu"
    echo "1. Fedora (dnf)              2. Fedora (ostree)"
    echo "0. Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
        $SCRIPTS_HOME/modules/fedora_dnf.sh
        ;;

        2)
        $SCRIPTS_HOME/modules/fedora_ostree.sh
        sudo rm -r -f $SCRIPTS_HOME/temp
        ;;

        0)
        exit
        ;;

    *)
        echo -n "Unknown entry"
        echo ""
        launch_menu
        ;;
    esac
    unset input
}

VERSION="dev branch"
export SCRIPTS_HOME=$(pwd)
mkdir $SCRIPTS_HOME/temp        # make a temp folder for all files to be downloaded to
launch_menu