#/usr/bin/bash



help(){
    echo "1. Steam Client - Self explanatory. :P"
    echo "2. Wine - official version of wine from winehq."
    echo "3. Lutris/Bottles - Downloads latest stable lutris, bottles and protonup."
    echo "4. WoW Up - World of Warcraft addon manager."
    echo "5. Minecraft - installs flatpak package of minecraft."
    echo "6. Controller Setup - Installs kernel development packages and runs xpad."
}

menu(){
    echo "1. Steam Client 2. Wine"
    echo "3. Lutris/Bottles 4. WoW Up" 
    echo "5. Minecraft 6. Controller Setup"
    echo "7. Steam Deck"
    echo "99. Help 0. Back to main menu"
    read input
    
    if [ $input -eq 1 ]
    then
        ./install/steam.sh
    elif [ $input -eq 2 ]
    then
        ./install/winehq.sh
    elif [ $input -eq 3 ]
    then
        ./install/gaming_apps.sh
    elif [ $input -eq 4 ]
    then
        ./install/wowup.sh
    elif [ $input -eq 5 ]
    then
        flatpak -y install flathub com.mojang.Minecraft
    elif [ $input -eq 6 ]
    then
        sudo dnf install -y kernel-modules-extra
	    sudo modprobe xpad
    elif [ $input -eq 7 ]
    then
        ./install/deck.sh
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
