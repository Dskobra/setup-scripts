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
        zypper addrepo https://download.opensuse.org/repositories/home:Dead_Mozay/openSUSE_Slowroll/home:Dead_Mozay.repo
        zypper refresh
        zypper install corectrl
    elif [ "$DISTRO" == "opensuse-leap" ]
    then
        zypper addrepo https://download.opensuse.org/repositories/home:ecsos/15.6/home:ecsos.repo
        zypper refresh
        zypper install corectrl
    elif [ "$DISTRO" == "debian" ]
    then
        echo "deb http://deb.debian.org/debian bookworm-backports main" >> backports.list
        sudo chown root:root backports.list
        sudo mv backports.list /etc/apt/sources.list.d/backports.list
        sudo apt-get update
        sudo apt-get install -y corectrl/bookworm-backports
    else
        echo "Unkown error has occurred."
    fi
}
install_corectrl
