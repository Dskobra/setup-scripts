#!/usr/bin/bash

native_vim(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y vim-enhanced
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install vim
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y vim
    else
        echo "Unkown error has occurred."
    fi
}

native_vim
