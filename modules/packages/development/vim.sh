#!/usr/bin/bash

native_vim(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y vim-enhanced
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install vim
    else
        echo "Unkown error has occurred."
    fi
}

native_vim
