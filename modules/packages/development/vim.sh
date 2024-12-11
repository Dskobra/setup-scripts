#!/usr/bin/bash

native_vim(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y vim-enhanced
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        sudo rpm-ostree install vim-enhanced
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install vim
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y vim
    else
        echo "Unkown error has occurred."
    fi
}

native_vim
