#!/usr/bin/bash

install_v4l2loopback(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y akmod-v4l2loopback v4l2loopback
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force
    else
        echo "Unkown error has occurred."
    fi
}

install_v4l2loopback
