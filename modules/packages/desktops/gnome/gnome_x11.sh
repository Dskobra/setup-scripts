#!/usr/bin/bash

native_gnome_x11(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y gnome-session-xsession
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree install gnome-session-xsession
        #sudo rpm-ostree apply-live
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    else
        echo "This only supports Fedora Linux 40+"
    fi
}

native_gnome_x11
