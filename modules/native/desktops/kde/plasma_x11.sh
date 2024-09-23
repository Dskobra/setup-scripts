#!/usr/bin/bash

install_plasma_x11(){
    if [ "$PKGMGR" == "dnf" ]
    then
        FEDORA_VERSION=$(source /etc/os-release ; echo $VERSION_ID)
        if [ "$FEDORA_VERSION" -ge "40" ]
        then
            sudo dnf install -y plasma-workspace-x11
        else
            echo "This only supports Fedora 40+. 39 has x11 support by default."
        fi
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        FEDORA_VERSION=$(source /etc/os-release ; echo $VERSION_ID)
        if [ "$FEDORA_VERSION" -ge "40" ]
        then
            sudo rpm-ostree install plasma-workspace-x11
            #sudo rpm-ostree apply-live
            "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
        else
            echo "Fedora version detected as 39. Not installing x11 support."
        fi
    else
        echo "This only supports Fedora Linux 40+"
    fi
}

install_plasma_x11
