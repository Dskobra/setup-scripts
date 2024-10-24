#!/usr/bin/bash

native_k3b(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y k3b
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y k3b
    else
        echo "Unkown error has occurred."
    fi
}

native_k3b