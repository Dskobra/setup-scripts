#!/usr/bin/bash
install_corectrl(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y corectrl
        xdg-open https://gitlab.com/corectrl/corectrl/-/wikis/Setup
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:Dead_Mozay/openSUSE_Slowroll/home:Dead_Mozay.repo
        sudo zypper --gpg-auto-import-keys ref
        sudo zypper -n install corectrl
    else
        echo "Unkown error has occurred."
    fi
}
install_corectrl
