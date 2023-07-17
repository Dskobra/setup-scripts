#!/usr/bin/bash

distro_check(){
    ID=$(grep 'ID' -w /etc/os-release)
    if [ "$ID" == 'ID=fedora' ]
    then
        fedora_variant_check
    elif [ "$ID" == 'ID="opensuse-tumbleweed"' ]
    then
        $SCRIPTS_HOME/modules/suse.sh
    else
	    echo "error."
    fi
}

fedora_variant_check(){
    PNAME=$(grep 'PRETTY_NAME' -w /etc/os-release)
    if [[ "$PNAME" == *"(Kinoite)"* ]]
    then
        $SCRIPTS_HOME/modules/fedora_ostree.sh
    else
        $SCRIPTS_HOME/modules/fedora.sh
    fi
}

launch_menu(){
    echo "================================================"
    echo "Choose Distro"
    echo "1. Fedora (dnf). 2. Fedora (ostree)"
    echo "3. openSUSE"
    echo "100. About" 
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        $SCRIPTS_HOME/modules/fedora.sh
    elif [ "$input" -eq 2 ]
    then
        $SCRIPTS_HOME/modules/fedora_ostree.sh
    elif [ "$input" -eq 3 ]
    then
        $SCRIPTS_HOME/modules/suse.sh
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
