#/usr/bin/bash
PROTONGELINK=https://github.com/GloriousEggroll/proton-ge-custom/releases/download/6.20-GE-1/Proton-6.20-GE-1.tar.gz
PROTONGETARBALL=Proton-6.20-GE-1.tar.gz

WINEGE=https://github.com/GloriousEggroll/wine-ge-custom/releases/download/6.20-GE-1/wine-lutris-ge-6.20-1-x86_64.tar.xz
WINEGETARBALL=wine-lutris-ge-6.20-1-x86_64.tar.xz

rpmfusion(){
DIREXISTS=0
test -d ~/.steam/ && DIREXISTS=rpmfusion
if [ "$DIREXISTS" = "rpmfusion" ];
then
    cd ~/.steam/root/
    mkdir compatibilitytools.d
    cd compatibilitytools.d
    wget $PROTONGELINK
    tar -xvf $PROTONGETARBALL
    rm $PROTONGETARBALL
else
    echo "Please make sure steam is installed and run once before running this script."
fi
}

flatpak(){
DIREXISTS=0
test -d ~/.var/app/com.valvesoftware.Steam/ && DIREXISTS=flatpak
if [ "$DIREXISTS" = "flatpak" ];
then
    echo "Requires flatpak 1.12.1+ or later to run official proton."
    cd ~/.var/app/com.valvesoftware.Steam/data/Steam/
    mkdir compatibilitytools.d
    cd compatibilitytools.d
    wget $PROTONGELINK
    tar -xvf $PROTONGETARBALL
    
    rm $PROTONGETARBALL
else
    echo "Please make sure steam is installed and run once before running this script."
fi
}

lutris(){
DIREXISTS=0
test -d ~/.local/share/lutris/runners/ && DIREXISTS=lutris
if [ "$DIREXISTS" = "lutris" ];
then
    cd ~/.local/share/lutris/runners/
    mkdir wine
    cd wine
    wget $WINEGE
    tar -xvf $WINEGETARBALL
    
    rm $WINEGETARBALL
else
    echo "Please make sure lutris is installed and run once before running this script."
fi
}

menu(){
    echo "GloriousEggroll Installer"
    echo "1. GE (rpmfusion) 2. GE (flatpak)"
    echo "3. GE Wine (lutris) 0. Exit"
    read input
    if [ $input -eq 1 ]
    then
	    rpmfusion
    elif [ $input -eq 2 ]
    then
        flatpak
    elif [ $input -eq 3 ]
    then
        lutris
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    menu
}
menu

