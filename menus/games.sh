#/usr/bin/bash



help(){
    echo "1. Gaming Apps - steam, bottles, discord and mangohud."
    echo "2. Wine - official version of wine from winehq."
    echo "3. Lutris - pulls in official lutris with git."
    echo "4. WoW Apps - wowup and weak auras desktop apps."
    echo "5. Minecraft - downloads minecraft."
}

menu(){
    echo "1. Gaming Apps 2. Wine"
    echo "3. Lutris 4. WoW Apps" 
    echo "5. Minecraft"
    echo "6. Steam flatpak permissions for mangohud"
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
    elif [ $input -eq 6 ]
    then
        flatpak override --user --env=MANGOHUD=1 com.valvesoftware.Steam
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
