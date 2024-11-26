#!/usr/bin/bash

native_plasma_x11(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y plasma-workspace-x11
        FEDORA_VERSION=$(source /etc/os-release ; echo $VERSION_ID)
        if [ "$FEDORA_VERSION" -ge "40" ]
        then
            
        else
            echo "This only supports Fedora 40+. 39 has x11 support by default."
        fi
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
