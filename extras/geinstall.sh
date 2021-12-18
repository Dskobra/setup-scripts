#/usr/bin/bash
PROTONGELINK=https://github.com/GloriousEggroll/proton-ge-custom/releases/download/6.21-GE-2/Proton-6.21-GE-2.tar.gz
PROTONGETARBALL=Proton-6.21-GE-2.tar.gz

WINEGELINK=https://github.com/GloriousEggroll/wine-ge-custom/releases/download/6.21-GE-1/wine-lutris-ge-6.21-1-x86_64.tar.xz
WINEGETARBALL=wine-lutris-ge-6.21-1-x86_64.tar.xz

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

steam_rpmfusion(){
    gui_install
    steam
    cd /home/$USER/.steam/root/
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

steam_flatpak(){
    gui_install
    flatpak run com.valvesoftware.Steam
    cd /home/$USER/.var/app/com.valvesoftware.Steam/data/Steam/
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


lutris_wine(){
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
}

menu(){
    echo "GE Installer"
    echo "1. ProtonGE (rpmfusion) 2. ProtonGE (flatpak)"
    echo "3. WineGE (lutris) 4. Setup MangoHud (flatpak) 0. Exit"
    read input
    if [ $input -eq 1 ]
    then
	   steam_rpmfusion
    elif [ $input -eq 2 ]
    then
        steam_flatpak
    elif [ $input -eq 3 ]
    then
        lutris_wine
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

