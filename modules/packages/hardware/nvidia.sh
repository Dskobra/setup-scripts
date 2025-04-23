#!/usr/bin/bash

install_nvidia(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y akmod-nvidia nvidia-settings
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force
    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia