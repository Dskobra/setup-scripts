#!/usr/bin/bash

install_claws_mail(){
    ## template function for adding more packages
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y claws-mail
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y claws-mail
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.claws_mail.Claws-Mail
install_claws_mail