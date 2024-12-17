#!/usr/bin/bash

native_gnome_x11(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y gnome-session-xsession
    else
        echo "This only supports Fedora Linux 40+"
    fi
}

native_gnome_x11
