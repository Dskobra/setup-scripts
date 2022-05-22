#! /usr/bin/bash

help(){
    echo ""
    echo ""
}

menu(){
    echo "Setup launchers/shortcuts"
    echo "1. Steam (gamescope) 2. WoW Apps"
    echo "3. Setup mangohud configs"
    echo "4. Setup Lutris 5. Setup Dropbox Tray"
    echo "99. Help 0. Exit"
    read input
    
    if [ $input -eq 1 ]
    then
        ./install/setup_permissions.sh
        ./install/setup_steam.sh
    elif [ $input -eq 2 ]
    then
        ./install/setup_permissions.sh
        ./install/setup_wow_apps.sh
    elif [ $input -eq 3 ]
    then
        ./install/setup_permissions.sh
        ./install/setup_mangohud.sh
    elif [ $input -eq 4 ]
    then
        ./install/setup_permissions.sh
        ./install/setup_lutris.sh
    elif [ $input -eq 5 ]
    then
        ./install/setup_permissions.sh
        ./install/setup_dropbox.sh
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
