#!/usr/bin/bash

native_github_desktop(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
        sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
        sudo dnf install -y github-desktop
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/zypp/repos.d/shiftkey-packages.repo'
        sudo zypper -n install github-desktop
    else
        echo "Unkown error has occurred."
    fi
}

remove_github_desktop(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo rm /etc/yum.repos.d/shiftkey-packages.repo
        sudo rm /etc/pki/rpm-gpg/shiftkey-gpg.key
        sudo dnf remove -y github-desktop
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo rm /etc/zypp/repos.d/shiftkey-packages.repo
        sudo rm /etc/pki/rpm-gpg/shiftkey-gpg.key
        sudo zypper -n rm github-desktop
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub io.github.shiftey.Desktop
    remove_github_desktop
elif [ "$1" == "native" ]
then
    flatpak remove --user -y io.github.shiftey.Desktop
    native_github_desktop
else
    echo "error"
fi