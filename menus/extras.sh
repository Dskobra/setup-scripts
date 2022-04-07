#/usr/bin/bash

help(){
    echo "1. OSSEC Repos - Repos."
    echo "2. OSSEC - Normal agent install."
    echo "3. OSSEC Server - Managment server install."
}

menu(){
    echo "1. OSSEC Repos 2. OSSEC Agent"
    echo "3. OSSEC Server"
    echo "99. Help 0. Back to main menu"
    read input
    
    if [ $input -eq 1 ]
    then
        ./install/ossec.sh
    elif [ $input -eq 2 ]
    then
        sudo dnf install -y ossec-hids-agent
    elif [ $input -eq 3 ]
    then
        sudo dnf install -y ossec-hids-server
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
menu