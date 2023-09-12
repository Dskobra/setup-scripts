#!/usr/bin/bash

launch_menu(){
    echo "================================================"
    echo "Choose Distro"
    echo "1. Fedora (dnf). 2. Other"
    echo "100. About 0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        $SCRIPTS_HOME/modules/fedora_dnf.sh
    elif [ "$input" -eq 2 ]
    then
        other_menu
    elif [ "$input" -eq 100 ]
    then
        bash -c "source $SCRIPTS_HOME/modules/misc.sh; about"  
    elif [ "$input" -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    echo $input
    unset input
    launch_menu
}

other_menu(){
    echo "================================================"
    echo "Extras"
    echo "1. Fedora (ostree) 2. openSUSE"
    echo "3. Dev Tools"
    echo "100. About 0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        $SCRIPTS_HOME/modules/fedora_ostree.sh
    elif [ "$input" -eq 2 ]
    then
        $SCRIPTS_HOME/modules/suse.sh
    elif [ "$input" -eq 3 ]
    then
        $SCRIPTS_HOME/modules/dev_tools.sh
    elif [ "$input" -eq 100 ]
    then
        bash -c "source $SCRIPTS_HOME/modules/misc.sh; about"  
    elif [ "$input" -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    echo $input
    unset input
    other_menu
}

export SCRIPTS_HOME=$(pwd)
launch_menu
