#! /usr/bin/bash

help(){
    echo "These are my custom scripts for copying and setting up"
    echo "mangohud for various games and custom menu shortcuts"
    echo "Option 4 will copy my mangohud configs for steam,"
    echo "lutris and bottles."
}

menu(){
    echo "My custom setup scripts"
    echo "1. Setup bash profile 2. WoW Up"
    echo "3. Copy Ossec start script" 
    echo "4. Copy Mangohud configs"
    echo "5. Setup dropbox tray 6. Other"
    echo "99. Help 0. Exit"
    read input
    
    if [ $input -eq 1 ]
    then
        cp /home/$USER/.bashrc /home/$USER/.bashrc.bak
        ./install/setup_paths.sh
    elif [ $input -eq 2 ]
    then
        ./install/setup_permissions.sh
        ./install/setup_wowup.sh
    elif [ $input -eq 3 ]
    then
        sudo cp install/data/ossec.sh /opt/launchers
        sudo chown $USER:$USER /opt/launchers/ossec.sh
    elif [ $input -eq 4 ]
    then
        ./install/setup_permissions.sh
        ./install/setup_mangohud.sh
    elif [ $input -eq 5 ]
        ./install/setup_permissions.sh
        ./install/setup_dropbox.sh
    then
        ./other_options.sh
    elif [ $input -eq 6 ]
    then
        ./other_options.sh
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
