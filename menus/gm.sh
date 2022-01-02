#/usr/bin/bash



help(){
    echo "1. Gaming Apps - flatpak versions of steam, discored and mangohud."
    echo "2. Wine - official version of wine from winehq."
    echo "3. Lutris - pulls in official lutris with git."
    echo "4. WoW Apps - wowup and weak auras desktop apps."
    echo "5. Minecraft - downloads minecraft."
}

menu(){
    echo "1. Gaming Apps 2. Wine"
    echo "3. Lutris 4. WoW Apps 4." 
    echo "5. Minecraft"
    echo "99. Help 0. Back to main menu"
    read input
    
    if [ $input -eq 1 ]
    then
        ./install/gaming_apps.sh
    elif [ $input -eq 2 ]
    then
        ./install/winehq.sh
    elif [ $input -eq 3 ]
    then
        ./install/getlutris.sh
    elif [ $input -eq 4 ]
    then
        ./install/wowapps.sh
    elif [ $input -eq 5 ]
    then
        ./install/minecraft.sh
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
