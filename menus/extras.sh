#/usr/bin/bash

help(){
    echo "1. OSSEC Setup - Downloads the ossec tarball and compiles."
}

menu(){
    echo "1. OSSEC setup"
    echo "99. Help 0. Back to main menu"
    read input
    
    if [ $input -eq 1 ]
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