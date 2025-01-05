#!/usr/bin/bash

native_python_tools(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y python3-idle python3-devel
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
    then
        sudo zypper -n install python3-idle python3-devel
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y idle-python3.11 python3.11-dev
    else
        echo "Unkown error has occurred."
    fi
}

native_python_tools
