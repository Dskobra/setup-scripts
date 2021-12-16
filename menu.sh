#/usr/bin/bash

help(){
    echo "1. Setup DE - Sets up desktop environment specific packages."
    echo "Such as nautilus-dropbox for gnome etc."
    echo "2. Audio/Video Support - VLC, mppeg and and openh264 codecs."
    echo "3. Office - Sets up office apps like libreoffice and HP printer drivers."
    echo "7. Gaming - Wine, lutris and steam. Plus extra stuff like mangohud, gamingmode, discord, xbox controller etc."
}
menu(){
    echo "1. Setup DE 2. Audio/Video Support"
    echo "3. Office 4. Multimedia Editing Tools"
    echo "5.Coding Tools 6.IDE's 7.Gaming"
    echo "8. Servers 9. Utilities"
    echo "10. Admin Tools"
    echo "99. Help 0. Exit"
    read input
    
    if [ $input -eq 1 ]
    then
        ./shared/de.sh
    elif [ $input -eq 2 ]
    then
        ./shared/av_support.sh
    elif [ $input -eq 3 ]
    then
        ./shared/office.sh
    elif [ $input -eq 4 ]
    then
        ./shared/mm_editing.sh
    elif [ $input -eq 4 ]
    then
        ./shared/coding_tools.sh
    elif [ $input -eq 5 ]
    then
        ./35/gaming_apps.sh
    elif [ $input -eq 6 ]
    then
        ./shared/ides.sh
    elif [ $input -eq 7 ]
    then
        ./shared/gaming_apps.sh
    elif [ $input -eq 8 ]
    then
        ./shared/servers.sh
    elif [ $input -eq 9 ]
    then
        ./shared/utilities.sh
    elif [ $input -eq 10 ]
    then
        ./shared/admin_tools.sh
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