#!/usr/bin/bash

launch_menu(){
    echo "================================================"
    echo "Choose Distro"
    echo "1. Fedora (dnf). 2. Fedora (ostree)"
    echo "3. openSUSE      4. Dev Tools"
    echo "100. About" 
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        $SCRIPTS_HOME/modules/fedora_dnf.sh
    elif [ "$input" -eq 2 ]
    then
        $SCRIPTS_HOME/modules/fedora_ostree.sh
    elif [ "$input" -eq 3 ]
    then
        $SCRIPTS_HOME/modules/suse.sh
    elif [ "$input" -eq 4 ]
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
    launch_menu
}

export SCRIPTS_HOME=$(pwd)
DESKTOP=$XDG_CURRENT_DESKTOP
launch_menu
