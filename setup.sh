#!/usr/bin/bash

launch_menu(){
    echo "            ---------------------"
    echo "            |DSK's Setup Scripts|"
    echo "            ---------------------"
    echo "                 Main Options"
    echo "________________________________________________"
    echo "1. Fedora (dnf).              2. Fedora (ostree)"
    echo "________________________________________________"
    echo "                 Extra Options"
    echo "3. Virtual Machine            4. Containers"
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

        3)
        bash -c "source $SCRIPTS_HOME/modules/fedora_dnf.sh; install_dev_basic_apps"
        bash -c "source $SCRIPTS_HOME/modules/fedora_dnf.sh; install_full_dev_tools"
        bash -c "source $SCRIPTS_HOME/modules/fedora_dnf.sh; install_mugshot"   install_container_dev_tools 
        ;;

        4)
        bash -c "source $SCRIPTS_HOME/modules/fedora_dnf.sh; install_container_dev_tools" 
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
