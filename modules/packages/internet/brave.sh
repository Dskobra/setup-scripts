#!/usr/bin/bash

native_brave_browser(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf4 config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo dnf update -y
        sudo dnf install -y brave-browser
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