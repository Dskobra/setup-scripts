#!/usr/bin/bash
setup_permissions(){
    cd $PARENT/data
    sudo chown $USER:$USER *.sh

    cd $PARENT/data/mangohud
    sudo chown $USER:$USER *.conf

    cd $PARENT/data/shortcuts
    sudo chown $USER:$USER *.desktop
}

setup_mangohud(){
    mkdir /home/$USER/.config/MangoHud/
    #lutris/bottles store MangoHud under /home/$USER/.var/app/APPNAME/config/MangoHud/
    ln -s "/home/$USER/.config/MangoHud/" "/home/$USER/.var/app/net.lutris.Lutris/config/"
    ln -s "/home/$USER/.config/MangoHud/" "/home/$USER/.var/app/com.usebottles.bottles/config/"
    cd $PARENT/data/mangohud

    cp wine-GTA5.conf /home/$USER/.config/MangoHud/
    cp wine-NewWorld.conf /home/$USER/.config/MangoHud/
    cp wine-PathOfExile_x64Steam.conf /home/$USER/.config/MangoHud/
    cp wine-R5Apex.conf /home/$USER/.config/MangoHud/
    cp wine-RuneScape.conf /home/$USER/.config/MangoHud/
    cp wine-WorldOfTanks.conf /home/$USER/.config/MangoHud/
    cp wine-WorldOfWarships.conf /home/$USER/.config/MangoHud/
    cp wine-Gw2-64.conf /home/$USER/.config/MangoHud/
    cp wine-WoW.conf /home/$USER/.config/MangoHud/
}

setup_steam_with_gamescope(){
    cd $PARENT/data/shortcuts
    xdg-desktop-menu install Steamgs.desktop --mode user --novendor

}

main_help(){
    echo "Copies my personal profiles for mangohud"
    echo "and setups a steam with gamescope shortcut"
}

main_menu(){
    echo "================================================"
    echo "My custom setup scripts"
    echo "1. Copy Mangohud configs"
    echo "2. Steam (gamescope)"
    echo "99. Help 0. Exit"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        setup_permissions
        setup_mangohud
    elif [ $input -eq 2 ]
    then
        setup_permissions
        setup_steam_with_gamescope
    elif [ $input -eq 99 ]
    then
        main_help
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    main_menu
}

USER=$(whoami)
PARENT=$(pwd)   # get the current folder custom.sh is running from
main_menu
