#!/usr/bin/bash

launch_menu(){
    echo "            ---------------------"
    echo "            |DSK's Setup Scripts|"
    echo "            ---------------------"
    echo "________________________________________________"
    echo "1. Fedora (dnf).              2. Fedora (ostree)"
    echo "________________________________________________"
    echo "100. About                    0. Exit"
    printf "Option: "
    read -r input

    case $input in

        1)
        $SCRIPTS_HOME/modules/fedora_dnf.sh
        ;;

        2)
        $SCRIPTS_HOME/modules/fedora_ostree.sh
        ;;

        100)
        source $SCRIPTS_HOME/modules/shared.sh; "about" 
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


export SCRIPTS_HOME=$(pwd)
mkdir $SCRIPTS_HOME/temp        # make a temp folder for all files to be downloaded to
launch_menu
rm -r -f $SCRIPTS_HOME/temp