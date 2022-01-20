#/usr/bin/bash

help(){
    echo "1. Lamp Stack - Apache web server, mariadb etc."
    echo "2. Samba Share - Installs samba server and creates folders."
    echo "3. Remote Tools - Setups fedora cockpit for remote management."
    echo "3. OSSEC Management Server - Setups ossec managment server on centos."
}

menu(){
    echo "1. Lamp Stack 2. Samba Share"
    echo "3. Remote Tools"
    echo "4. OSSEC Management Server"
    echo "99. Help 0. Back to main menu"
    read input
    
    if [ $input -eq 1 ]
    then
        ./install/lamp.sh
    elif [ $input -eq 2 ]
    then
        ./install/samba_share.sh
    elif [ $input -eq 3]
    then
        ./install/remote_tools.sh
    elif [ $input -eq 4 ]
    then
        ./install/ossec_server.sh
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