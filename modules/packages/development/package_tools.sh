#!/usr/bin/bash

native_package_tools(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf4 groupinstall -y "Development Tools"
        sudo dnf4 groupinstall -y "C Development Tools and Libraries"
    else
        echo "Unkown error has occurred."
    fi
}

native_package_tools
