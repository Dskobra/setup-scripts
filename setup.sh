#!/usr/bin/bash

launch_menu(){
    echo "================================================"
    echo "Choose Distro"
    echo "1. Fedora (dnf). 2. Other"
    echo "100. About 0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input

    case $input in

        1)
        $SCRIPTS_HOME/modules/fedora_dnf.sh
        ;;

        2)
        other_menu 
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

other_menu(){
    echo "================================================"
    echo "Extras"
    echo "1. Dev Tools 2. Fedora (ostree)"
    echo "3. openSUSE"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input

    case $input in

        1)
        $SCRIPTS_HOME/modules/dev_tools.sh
        ;;

        2)
        $SCRIPTS_HOME/modules/fedora_ostree.sh
        ;;

        3)
        $SCRIPTS_HOME/modules/suse.sh
        ;;

        0)
        exit
        ;;

    *)
        echo -n "Unknown entry"
        echo ""
        other_menu
        ;;
    esac
    unset input
    other_menu
}

export SCRIPTS_HOME=$(pwd)
launch_menu


#$SCRIPTS_HOME/modules/fedora_dnf.sh
#bash -c "source $SCRIPTS_HOME/modules/misc.sh; about"  