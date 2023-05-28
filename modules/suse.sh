#!/usr/bin/bash

main_menu(){
    echo "================================================"
    echo "openSUSE Menu"
    echo "1. Setup DE 2. Gaming"
    echo "3. Coding/Servers 4. Extras"
    echo "100. About" 
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        install_basic_apps
    elif [ "$input" -eq 2 ]
    then
        install_game_clients
        mango
    elif [ "$input" -eq 3 ]
    then
        #coding_servers_menu
        echo "disabled"
    elif [ "$input" -eq 4 ]
    then
        #extras_menu
        echo "disabled"
    elif [ "$input" -eq 100 ]
    then
        echo "disabled"
    elif [ "$input" -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    echo $input
    unset input
    main_menu
}

install_basic_apps(){
	echo "Setting up packman essentials and flathub."
    sudo zypper ar -cfp 90 https://ftp.fau.de/packman/suse/openSUSE_Tumbleweed/Essentials packman-essentials    # using essentials for ffmpeg etc
    sudo zypper dup -y --from packman-essentials --allow-vendor-change     # update system packages with essentials

    sudo zypper install curl
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

	sudo zypper install -y konsole kate discover dolphin-plugins\
	plymouth-theme-spinfinity 7zip hplip java-17-openjdk brave-browser\
    mozilla-openh264 gstreamer-plugin-openh264 
       
	sudo plymouth-set-default-theme spinfinity -R

    bash -c "source "$SCRIPTS_HOME"/modules/flatpak.sh; fbasic"

    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.


}

install_game_clients(){
    mkdir "$HOME"/Games
	mkdir "$HOME"/Games/bottles
    mkdir "$HOME"/.config/MangoHud/
    sudo zypper install -y steam goverlay gamemode
    sudo modprobe xpad

    bash -c "source "$SCRIPTS_HOME"/modules/misc.sh; extra_games"
    
}

cleanup(){
    echo ""
}

DESKTOP=$XDG_CURRENT_DESKTOP
main_menu