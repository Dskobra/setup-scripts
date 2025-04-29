#!/usr/bin/bash

native_brave_browser(){
    if [ "$DISTRO" == "fedora" ]
    then
        curl -fsSLO "https://dl.brave.com/install.sh{,.asc}" && gpg --keyserver hkps://keys.openpgp.org --recv-keys D16166072CACDF2C9429CBF11BF41E37D039F691 && gpg --verify install.sh.asc
        curl -fsS https://dl.brave.com/install.sh | sh
    else
        echo "Unkown error has occurred."
    fi
}

remove_brave_browser(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y brave-browser
        sudo rm "/etc/yum.repos.d/brave-browser.repo"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave-nightly"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave-beta"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave"
        sudo dnf update -y
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub com.brave.Browser
    remove_brave_browser
elif [ "$1" == "native" ]
then
    flatpak uninstall --user -y com.brave.Browser
    native_brave_browser
else
    echo "error"
fi