#/usr/bin/bash

help(){
    echo "1. OSSEC Setup - Downloads the latest ossec tarball and compiles."
    echo "2. HP Printer Drivers - Self Explanatory. :P"
}

menu(){
    echo "1. OSSEC setup 2. HP Printer Drivers"
    echo "99. Help 0. Back to main menu"
    read input
    
    if [ $input -eq 1 ]
    then
        ./install/ossec.sh
    elif [ $input -eq 2 ]
    then
        sudo dnf install -y hplip-gui 
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