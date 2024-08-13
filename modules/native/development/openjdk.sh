#!/usr/bin/bash

install_openjdk(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y java-21-openjdk-devel openjfx
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Using openjdk 17 as 21 isn't in stable yet."
        sudo apt-get install -y openjdk-17-jdk openjfx
    else
        echo "Unkown error has occurred."
    fi
}

install_openjdk