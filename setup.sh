#/usr/bin/bash

USER=$(whoami)

help(){
    echo "1. Repos - rpmfusion, flatpak and brave browser."
    echo "2. Amd Drivers - x11 driver arnd radeon-profile package for fan control. Doesnt work on laptops or cards without fans."
    echo "3. Setup DE - Sets up desktop environment specific packages. Also installs brave and few other basic packages."
    echo "Such as nautilus-dropbox for gnome etc."
    echo "4. Audio/Video Support - VLC, mppeg and and openh264 codecs."
    echo "5. Office - Sets up office apps like libreoffice and HP printer drivers."
    echo "6. Multimedia Editing Tools - OBS Studio, GIMP and OpenShot."
    echo "7. Coding Tools - Compilers, nodejs and other development packages."
    echo "8. Gaming - Wine, lutris and steam. Plus extra stuff like mangohud, gamingmode, discord, xbox controller etc."
    echo "9. Servers - Apache Web Server, samba and mysql."
    echo "10. Utilities - Clamav, dnfdragora and some other useful packages."
    echo "11. Virtualization - libvirt and related tools."
}

menu(){
    echo "1. Repos 2. Amd Drivers"
    echo "3. Setup DE 4. Audio/Video Support" 
    echo "5. Office 6. Multimedia Editing Tools"
    echo "7.Coding Tools 8. Gaming"
    echo "9. Servers 10. Utilities"
    echo "11. Virtualization"
    echo "99. Help 0. Exit"
    read input
    
    if [ $input -eq 1 ]
    then
        ./sources/repos.sh
    elif [ $input -eq 2 ]
    then
        ./sources/amdgpu.sh
    elif [ $input -eq 3 ]
    then
        ./sources/basic_apps.sh
        ./sources/de.sh
    elif [ $input -eq 4 ]
    then
        ./sources/av_support.sh
    elif [ $input -eq 5 ]
    then
        ./sources/office.sh
    elif [ $input -eq 6 ]
    then
        ./sources/mm_editing.sh
    elif [ $input -eq 7 ]
    then
        ./sources/coding_tools.sh
    elif [ $input -eq 8 ]
    then
        ./sources/gaming_apps.sh
    elif [ $input -eq 9 ]
    then
        ./sources/servers.sh
    elif [ $input -eq 10 ]
    then
        ./sources/utilities.sh
    elif [ $input -eq 11 ]
    then
        ./sources/virtualization.sh
    elif [ $input -eq 99 ]
    then
        help
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
}
menu
