#! /usr/bin/bash

setup_permissions(){
    cd /$PARENT/install/data/
    sudo chown $USER:$USER *.sh

    cd /$PARENT/install/data/mangohud
    sudo chown $USER:$USER *.conf

    cd /$PARENT/install/data/shortcuts
    sudo chown $USER:$USER *.desktop
}


setup_wowup(){
    cd /$PARENT/install/data/
    cp wowup.sh /opt/launchers
    cd /$PARENT/install/data/shortcuts
    xdg-desktop-menu install WoWUp.desktop --mode user --novendor
}

setup_dropbox(){
    cd /$PARENT/install/data/shortcuts
    xdg-desktop-menu install Dropbox-fix.desktop --mode user --novendor
}

setup_mangohud(){
    mkdir /home/$USER/.config/MangoHud/
    #mkdir /home/$USER/.var/app/net.lutris.Lutris/config/MangoHud/
    mkdir /home/$USER/.var/app/com.usebottles.bottles/config/MangoHud/
    cd /$PARENT/install/data/mangohud

# for steam/lutris installed via package manager
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
    cd /$PARENT/install/data/shortcuts
    cp /$PARENT/install/data/steamgs.sh /opt/launchers
    sudo ln -s "/opt/launchers/steamgs.sh" "/usr/bin/steamgs"
    xdg-desktop-menu install Steamgs.desktop --mode user --novendor

}

main_help(){
    echo "These are my custom scripts for copying and setting up"
    echo "mangohud for various games and custom menu shortcuts"
    echo "Option 4 will copy my mangohud configs for steam,"
    echo "lutris and bottles."
}

other_options_help(){
    echo ""
    echo ""
}

other_options_menu(){
    echo "Other options"
    echo "1. Steam (gamescope)"
    echo "99. Help 0. Back"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        setup_permissions
        setup_steam_with_gamescope
    elif [ $input -eq 99 ]
    then
        other_options_help
    elif [ $input -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    other_options_menu
}

main_menu(){
    echo "My custom setup scripts"
    echo "1. Setup bash profile 2. WoW Up"
    echo "3. Copy Mangohud configs"
    echo "4. Setup dropbox tray 6. Other"
    echo "99. Help 0. Exit"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        cp /home/$USER/.bashrc /home/$USER/.bashrc.bak
        cat /$PARENT/install/data/custom_paths >> /home/$USER/.bashrc
    elif [ $input -eq 2 ]
    then
        setup_permissions
        setup_wowup
    elif [ $input -eq 3 ]
    then
        setup_permissions
        setup_mangohud
    elif [ $input -eq 4 ]
    then
        setup_permissions
        setup_dropbox
    elif [ $input -eq 6 ]
    then
        other_options_menu
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
PARENT=$(pwd)   # get the setup-scripts root folder
main_menu
