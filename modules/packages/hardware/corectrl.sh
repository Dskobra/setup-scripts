#!/usr/bin/bash
install_corectrl(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y corectrl
        xdg-open https://gitlab.com/corectrl/corectrl/-/wikis/Setup
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:Dead_Mozay/openSUSE_Tumbleweed/home:Dead_Mozay.repo
        sudo zypper ref
        sudo zypper -n install corectrl
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:Dead_Mozay/openSUSE_Slowroll/home:Dead_Mozay.repo
        sudo zypper refresh
        sudo zypper -n install corectrl
    else
        echo "Unkown error has occurred."
    fi
}
install_corectrl
