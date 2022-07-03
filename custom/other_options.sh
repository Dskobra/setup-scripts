#! /usr/bin/bash

help(){
    echo ""
    echo ""
}

menu(){
    echo "Older options"
    echo "1. Setup Dropbox Tray 2. Steam (gamescope)"
    echo "99. Help 0. Exit"
    read input
    
    if [ $input -eq 1 ]
    then
        ./install/setup_permissions.sh
        ./install/setup_dropbox.sh
    elif [ $input -eq 2 ]
    then
        ./install/setup_permissions.sh
        ./install/setup_steam.sh
    elif [ $input -eq 99 ]
    then
        help
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    menu
}
USER=$(whoami)
menu
