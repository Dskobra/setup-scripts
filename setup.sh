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
        bash -c "source $SCRIPTS_HOME/modules/misc.sh; about" 
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
launch_menu
