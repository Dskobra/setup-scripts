#!/usr/bin/bash

install_kate(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kate kate-plugins
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install kate kate-plugins --allow-inactive
        sudo rpm-ostree apply-live     
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kate
    else
        echo "Unkown error has occurred."
    fi
}

install_kate