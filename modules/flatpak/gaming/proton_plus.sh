#!/usr/bin/bash

remove_proton_plus(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y protonplus
        sudo rm /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:wehagy:protonplus.repo
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing protonplus as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub com.vysp3r.ProtonPlus
remove_proton_plus
