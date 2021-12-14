#/usr/bin/bash

help(){
    echo "1. Setup DE - Sets up desktop environment specific packages."
    echo "Such as nautilus-dropbox for gnome etc."
    echo "2. Productivity - Sets up office apps like libreoffice and keepassxc flatpaks."
    echo "3. Media Apps - VLC, GIMP, openSHOT"
    echo "4. Gaming - Wine, lutris and steam. Plus extra stuff like mangohud, gamingmode, discord, xbox controller etc."
}
menu(){
    echo "1. Setup DE 2. Productivity"
    echo "3. Media Tools 4. Gaming"
    echo "5.6.7.8."
    echo "99. Help 0. Exit"
    read input
    
    if [ $input -eq 1 ]
    then
        ./shared/de.sh
    elif [ $input -eq 2 ]
    then
        echo "Placeholder"
    elif [ $input -eq 3 ]
    then
        echo "Placeholder"
    elif [ $input -eq 4 ]
    then
        ./35/gaming_apps.sh
    elif [ $input -eq 99 ]
    then
        help()
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
}