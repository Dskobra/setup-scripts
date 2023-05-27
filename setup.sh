#!/usr/bin/bash

distro_check(){
    ID=$(grep 'ID' -w /etc/os-release)
    echo $ID

    if [ "$ID" == "ID=fedora" ]
    then
        $SCRIPTS_HOME/modules/fedora.sh
    elif [ "$ID" == "ID=opensuse-tumbleweed" ]
    then
        $SCRIPTS_HOME/modules/suse.sh
    else
	    echo "error."
    fi
}

SCRIPTS_HOME=$(pwd)
DESKTOP=$XDG_CURRENT_DESKTOP
distro_check