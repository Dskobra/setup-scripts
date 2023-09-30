#!/usr/bin/bash

launch_menu(){
    echo "================================================"
    echo "Choose Distro"
    echo "1. Fedora (dnf). 2. Fedora (ostree)"
    echo "3. Dev Tools (fedora) 4. openSUSE"
    echo "100. About 0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input

    case $input in

        1)
        $SCRIPTS_HOME/modules/fedora_dnf.sh
        ;;

        2)
        $SCRIPTS_HOME/modules/fedora_ostree.sh
        ;;

        3)
        $SCRIPTS_HOME/modules/dev_tools.sh
        ;;

        4)
        $SCRIPTS_HOME/modules/suse.sh
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
