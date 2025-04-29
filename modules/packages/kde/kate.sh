#!/usr/bin/bash

native_kate(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y kate kate-plugins
    else
        echo "Unkown error has occurred."
    fi
}

native_kate
