#!/usr/bin/bash

native_github_desktop(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
        sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
        sudo dnf install -y github-desktop
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/zypp/repos.d/shiftkey-packages.repo'
    elif [ "$PKGMGR" == "apt-get" ]
    then
        wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
        sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
        sudo apt-get update && sudo apt-get install -y github-desktop
    else
        echo "Unkown error has occurred."
    fi
}

remove_github_desktop(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo rm /etc/yum.repos.d/shiftkey-packages.repo
        sudo rm /etc/pki/rpm-gpg/shiftkey-gpg.key
        sudo dnf remove -y github-desktop
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo rm /etc/zypp/repos.d/shiftkey-packages.repo
        sudo rm /etc/pki/rpm-gpg/shiftkey-gpg.key
        sudo zypper rm -n github-desktop
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo rm /etc/apt/sources.list.d/shiftkey-packages.list
        sudo apt-get remove -y github-desktop
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