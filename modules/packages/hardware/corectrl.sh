#!/usr/bin/bash
install_corectrl(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y corectrl
        xdg-open https://gitlab.com/corectrl/corectrl/-/wikis/Setup
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:ecsos/openSUSE_Tumbleweed/home:ecsos.repo
        sudo zypper ref
        sudo zypper -n install corectrl
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:ecsos/openSUSE_Slowroll/home:ecsos.repo
        sudo zypper refresh
        sudo zypper -n install corectrl
    else
        echo "Unkown error has occurred."
    fi
}
install_corectrl
