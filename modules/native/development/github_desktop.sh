#!/usr/bin/bash

install_github_desktop(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
        sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
        sudo dnf install -y github-desktop
    elif [ "$PKGMGR" == "apt-get" ]
    then
        wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
        sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
        sudo apt-get update && sudo apt-get install -y github-desktop
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y io.github.shiftey.Desktop
install_github_desktop
