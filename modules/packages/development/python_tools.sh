#!/usr/bin/bash

native_python_tools(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y python3-idle python3-devel
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y idle-python3.11 python3.11-dev
    else
        echo "Unkown error has occurred."
    fi
}

native_python_tools
