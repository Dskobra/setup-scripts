#!/usr/bin/bash

native_vim(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y vim-enhanced
    else
        echo "Unkown error has occurred."
    fi
}

native_vim
