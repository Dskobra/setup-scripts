#!/usr/bin/bash
native_rclone(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y rclone rclone-browser
    else
        echo "Unkown error has occurred."
    fi
}

native_rclone()