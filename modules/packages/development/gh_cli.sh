#!/usr/bin/bash

native_gh_cli(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y gh
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install gh
    else
        echo "Unkown error has occurred."
    fi
}

native_gh_cli
