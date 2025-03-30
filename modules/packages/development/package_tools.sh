#!/usr/bin/bash

native_package_tools(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf4 groupinstall -y "Development Tools"
        sudo dnf4 groupinstall -y "C Development Tools and Libraries"
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install patterns-devel-C-C++-devel_C_C++
    else
        echo "Unkown error has occurred."
    fi
}

native_package_tools
