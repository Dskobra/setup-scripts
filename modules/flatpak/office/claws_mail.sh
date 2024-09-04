#!/usr/bin/bash

remove_claws_mail(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y claws-mail
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y claws-mail
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.claws_mail.Claws-Mail
remove_claws_mail
