#!/usr/bin/bash

native_kate(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y kate kate-plugins
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        sudo rpm-ostree install kate kate-plugins --allow-inactive
        sudo rpm-ostree apply-live     
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install kate kate-plugins
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y kate
    else
        echo "Unkown error has occurred."
    fi
}

native_kate
