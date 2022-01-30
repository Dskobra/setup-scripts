#/usr/bin/bash
PROTONGELINK=0
PROTONGETARBALL=0

WINEGELINK=0
WINEGETARBALL=0

USER=$(whoami)
STEAMPATH=0
STEAMRUN=0

gui_install(){
    zenity --info --width=430 height=300 \
    --text="This will now run steam to ensure the client is downloaded and directories built."
    zenity --info --width=430 height=300 \
    --text="Please close steam once the account creation screen appears to continue the script."
}

gui_finished(){
    zenity --info --width=430 height=300 \
    --text="ProtonGE is now installed." 
}

gui_error(){
    zenity --info --width=430 height=300 \
    --text="Please make sure steam is installed before running this script."
}

proton_setup(){
    gui_install
    $STEAMRUN
    cd $STEAMPATH
    mkdir compatibilitytools.d
    cd compatibilitytools.d
    (
    echo "25" ; wget $PROTONGELINK
    echo "# Extracting ProtonGE" ; sleep 1
    echo "50" ; tar -xvf $PROTONGETARBALL
    echo "# Removing ProtonGE tarball" ; sleep 1
    echo "75" ; rm $PROTONGETARBALL
    echo "# Removing ProtonGE tarball" ; sleep 1
    echo "100" ; sleep 1
)|  zenity --progress \
    --title="ProtonGE Installer" \
    --text="Downloading ProtonGE..." \
    --percentage=0

if [ "$?" = -1 ] ; then
        zenity --error \
          --text="Update canceled."
fi
}

winege_setup(){
LUTRISEXISTS=0
test -f /usr/bin/lutris && LUTRISEXISTS=lutris
if [ "$LUTRISEXISTS" = "lutris" ];
then
    zenity --info --width=430 height=300 \
    --text="This will now run lutris to ensure the runners directory is built."
    zenity --info --width=430 height=300 \
    --text="Please close lutris once it loads to continue the script."
    lutris
    cd /home/$USER/.local/share/lutris/runners/
    mkdir wine
    cd wine
    (
    echo "25" ; wget $WINEGELINK
    echo "# Extracting WineGE" ; sleep 1
    echo "50" ; tar -xvf $WINEGETARBALL
    echo "# Removing WineGE tarball" ; sleep 1
    echo "75" ; rm $WINEGETARBALL
    echo "# Removing WineGE tarball" ; sleep 1
    echo "100" ; sleep 1
)|  zenity --progress \
    --title="WineGE Installer" \
    --text="Downloading WineGE..." \
    --percentage=0

if [ "$?" = -1 ] ; then
        zenity --error \
          --text="Update canceled."
fi
else
    gui_error
fi
}

help(){
    echo "4. Setup MangoHud (flatpak) - overrides folder permissions to enable"
    echo "flatpak mangohud to work with flatpak steam. Using this in gaming_apps.sh script"
    echo "gives an error."


steam_type_menu(){
    echo "Select how you installed Steam"
    echo "1. Package Manager 2. Flatpak"
    echo "0. Main Menu"
    read input
    if [ $input -eq 1 ]
    then
        STEAMPATH=/home/$USER/.steam/root/
        STEAMRUN=steam
	    ./menus/proton_menu.sh
    elif [ $input -eq 2 ]
    then
        STEAMPATH=/home/$USER/.var/app/com.valvesoftware.Steam/data/Steam/
        STEAMRUN="flatpak run com.valvesoftware.Steam"
        ./menus/proton_menu.sh
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    menu
}

menu(){
    echo "Select platform"
    echo "1. ProtonGE (steam) 2. WineGE (lutris)" 
    echo "Set flatpak MangoHud Permissions" 
    echo "0. Exit"
    read input
    if [ $input -eq 1 ]
    then
	   steam_type_menu
    elif [ $input -eq 3 ]
    then
        ./menus/wine_menu.sh
        winege_setup
    elif [ $input -eq 4 ]
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

