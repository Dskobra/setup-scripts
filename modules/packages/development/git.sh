#!/usr/bin/bash

native_git(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y git git-gui gh
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install git git-gui gh
    else
        echo "Unkown error has occurred."
    fi
}

native_kommit(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y kommit
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install kommit
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "git" ]
then
    native_git
elif [ "$1" == "kommit" ]
then
    native_kommit
else
    echo "error"
fi