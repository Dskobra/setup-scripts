#!/usr/bin/bash

native_containers(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y toolbox distrobox
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree install distrobox
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y distrobox podman-toolbox
    else
        echo "Unkown error has occurred."
    fi
}

native_containers
