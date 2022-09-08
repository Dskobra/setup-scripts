#/usr/bin/bash

help(){
    echo "1. HP Printer Drivers - Self Explanatory. :P"
    echo "2. OSSEC Setup - Downloads the latest ossec tarball and compiles."
}

menu(){
    echo "1. HP Printer Drivers 2. OSSEC setup"
    echo "99. Help 0. Back to main menu"
    read input
    
    if [ $input -eq 1 ]
    then
        sudo dnf install -y hplip-gui
    elif [ $input -eq 2 ]
    then
        ./install/ossec.sh
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