#!/usr/bin/bash

menu(){
    echo "1. Proton-7.1-GE-2 2. Proton-7.1-GE-1"
    echo "3. Proton-7.0rc6-GE-1"
    echo "0. Exit"
    read input
    if [ $input -eq 1 ]
    then
        PROTONGELINK=https://github.com/GloriousEggroll/proton-ge-custom/releases/download/7.1-GE-1/Proton-7.1-GE-1.tar.gz
        PROTONGETARBALL=Proton-7.1-GE-1.tar.gz
    elif [ $input -eq 2 ]
    then
        PROTONGELINK=https://github.com/GloriousEggroll/proton-ge-custom/releases/download/7.1-GE-1/Proton-7.1-GE-1.tar.gz
        PROTONGETARBALL=Proton-7.1-GE-1.tar.gz
    elif [ $input -eq 2 ]
    then
        PROTONGELINK=https://github.com/GloriousEggroll/proton-ge-custom/releases/download/7.0rc6-GE-1/Proton-7.0rc6-GE-1.tar.gz
        PROTONGETARBALL=Proton-7.0rc6-GE-1.tar.gz
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    menu
}

menu
