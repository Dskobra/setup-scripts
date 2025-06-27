#!/usr/bin/bash

native_python_tools(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y python3-idle python3-devel
    else
        echo "Unkown error has occurred."
    fi
}

native_python_tools
