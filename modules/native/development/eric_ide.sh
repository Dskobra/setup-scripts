#!/usr/bin/bash

install_eric_ide(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y eric
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y eric
    else
        echo "Unkown error has occurred."
    fi
}

install_eric_ide