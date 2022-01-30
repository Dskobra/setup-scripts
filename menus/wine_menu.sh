#!/usr/bin/bash

menu(){
    echo "Wine-7.1-GE-1 2. Wine-7.0rc3-GE-1"
    echo "3. Wine-7.0rc2-GE-1" 
    echo "0. Exit"
    read input
    if [ $input -eq 1 ]
    then
        WINEGELINK=https://github.com/GloriousEggroll/wine-ge-custom/releases/download/7.1-GE-1/wine-lutris-ge-7.1-1-x86_64.tar.xz
        WINEGETARBALL=wine-lutris-ge-7.1-1-x86_64.tar.xz
    elif [ $input -eq 2 ]
    then
        WINEGELINK=https://github.com/GloriousEggroll/wine-ge-custom/releases/download/7.0rc3-GE-1/wine-lutris-ge-7.0rc3-1-x86_64.tar.xz
        WINEGETARBALL=wine-lutris-ge-7.0rc3-1-x86_64.tar.xz
    elif [ $input -eq 2 ]
    then
        WINEGELINK=https://github.com/GloriousEggroll/wine-ge-custom/releases/download/7.0rc2-GE-1/wine-lutris-ge-7.0rc2-1-x86_64.tar.xz
        WINEGETARBALL=wine-lutris-ge-7.0rc2-1-x86_64.tar.xz
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    menu
}

menu
