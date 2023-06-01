#!/usr/bin/bash

distro_check(){
    ID=$(grep 'ID' -w /etc/os-release)
    echo $ID

    if [ "$ID" == 'ID=fedora' ]
    then
        fedora_variant_check
    elif [ "$ID" == 'ID="opensuse-tumbleweed"' ]
    then
        $SCRIPTS_HOME/modules/suse.sh
    else
	    echo "error."
    fi
}

fedora_variant_check(){
    PNAME=$(grep 'PRETTY_NAME' -w /etc/os-release)
    if [ "$PNAME" == *"(Kinoite)"* ]
    then
        echo "kinoite"
    else
    echo "Normal dnf based Fedora"
        $SCRIPTS_HOME/modules/fedora.sh
	    echo "error."
    fi
}

SCRIPTS_HOME=$(pwd)
DESKTOP=$XDG_CURRENT_DESKTOP
distro_check
