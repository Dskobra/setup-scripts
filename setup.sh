#/usr/bin/bash



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
    echo "12. Extras - Some extra stuff like ossec."
}

menu(){
    echo "1. Repos 2. Amd Drivers"
    echo "3. Setup DE 4. Audio/Video Support" 
    echo "5. Office 6. Multimedia Editing Tools"
    echo "7.Coding Tools 8. Gaming"
    echo "9. Servers 10. Utilities"
    echo "11. Virtualization"
    echo "12. Extras"
    echo "99. Help 0. Exit"
    read input
    
    if [ $input -eq 1 ]
    then
        ./install/repos.sh
    elif [ $input -eq 2 ]
    then
        ./install/amdgpu.sh
    elif [ $input -eq 3 ]
    then
        ./install/basic_apps.sh
        ./install/de.sh
    elif [ $input -eq 4 ]
    then
        ./install/av_support.sh
    elif [ $input -eq 5 ]
    then
        ./install/office.sh
    elif [ $input -eq 6 ]
    then
        ./install/mm_editing.sh
    elif [ $input -eq 7 ]
    then
        ./install/coding_tools.sh
    elif [ $input -eq 8 ]
    then
        ./menus/games.sh
    elif [ $input -eq 9 ]
    then
        ./menus/servers.sh
    elif [ $input -eq 10 ]
    then
        ./install/utilities.sh
    elif [ $input -eq 11 ]
    then
        ./install/virtualization.sh
    elif [ $input -eq 12 ]
    then
        ./menus/extras.sh
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
USER=$(whoami)
menu
