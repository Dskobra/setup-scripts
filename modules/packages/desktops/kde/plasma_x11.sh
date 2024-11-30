#!/usr/bin/bash

native_plasma_x11(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y plasma-workspace-x11
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree install plasma-workspace-x11
        #sudo rpm-ostree apply-live
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    else
        echo "This only supports Fedora Linux 40+"
    fi
}

native_plasma_x11
