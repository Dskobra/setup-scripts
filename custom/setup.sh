#! /usr/bin/bash

setup_paths(){
    cp install/data/custom_paths /home/$USER
    cd /home/$USER/
    cat custom_paths >> .bashrc
    rm custom_paths
}

setup_permissions(){
    cd install/data
    sudo chown $USER:$USER *.sh

    cd mangohud
    sudo chown $USER:$USER *.conf

    cd ../shortcuts
    sudo chown $USER:$USER *.desktop
}

main_help(){
    echo "These are my custom scripts for copying and setting up"
    echo "mangohud for various games and custom menu shortcuts"
    echo "Option 4 will copy my mangohud configs for steam,"
    echo "lutris and bottles."
}

other_options_help(){
    echo ""
    echo ""
}

other_options_menu(){
    echo "Other options"
    echo "1. Steam (gamescope)"
    echo "99. Help 0. Exit"
    printf "Option: "
    read input
    
    if [ $input -eq 2 ]
    then
        setup_permissions
        ./install/setup_steam.sh
    elif [ $input -eq 99 ]
    then
        other_options_help
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    menu
}

main_menu(){
    echo "My custom setup scripts"
    echo "1. Setup bash profile 2. WoW Up"
    echo "3. Copy Ossec start script" 
    echo "4. Copy Mangohud configs"
    echo "5. Setup dropbox tray 6. Other"
    echo "99. Help 0. Exit"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        cp /home/$USER/.bashrc /home/$USER/.bashrc.bak
        setup_paths
    elif [ $input -eq 2 ]
    then
        setup_permissions
        ./install/setup_wowup.sh
    elif [ $input -eq 3 ]
    then
        sudo cp install/data/ossec.sh /opt/launchers
        sudo chown $USER:$USER /opt/launchers/ossec.sh
    elif [ $input -eq 4 ]
    then
        setup_permissions
        ./install/setup_mangohud.sh
    elif [ $input -eq 5 ]
    then
        setup_permissions
        ./install/setup_dropbox.sh
    elif [ $input -eq 6 ]
    then
        other_options_menu
    elif [ $input -eq 99 ]
    then
        main_help
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    menu
}
USER=$(whoami)
main_menu
