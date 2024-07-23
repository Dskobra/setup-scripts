#!/usr/bin/bash

# basic packages for installing everything
install_prereq(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y git curl wget zenity flatpak dnf-plugins-core
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf update -y
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install zenity dnf dnf-plugins-core
        sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo rpm-ostree apply-live
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y git curl wget zenity flatpak
        sudo apt-get install -y software-properties-common
        sudo apt-add-repository -y --component contrib non-free 
        sudo dpkg --add-architecture i386
        sudo apt-get update && sudo apt-get upgrade -y
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    else
        echo "Unkown error has occurred."
    fi
    flatpak install --user -y flathub com.github.tchx84.Flatseal
}

install_prereq