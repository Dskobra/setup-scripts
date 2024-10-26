#!/usr/bin/bash

remove_marknote(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y marknote
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing marknote as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}


remove_marknote
