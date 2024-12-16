#!/usr/bin/bash

# checks/installs basic packages such as flatpak, curl/wget and git.

install_prereq(){
    if [ "$DISTRO" == "fedora" ]
    then
        echo "Following packages will be installed: curl wget flatpak flatseal dnf-plugins-core"
        sudo dnf install -y curl wget flatpak dnf-plugins-core
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf update -y
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        echo "Following packages will be installed: flatseal dnf-plugins-core"
        sudo rpm-ostree install dnf dnf-plugins-core
        sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo rpm-ostree apply-live
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        echo "Following packages will be installed: curl wget flatpak flatseal"
        sudo zypper -n install wget curl flatpak
    elif [ "$DISTRO" == "debian" ]
    then
        echo "Following packages will be installed: curl wget flatpak flatseal software-properties-common"
        sudo apt-get install -y curl wget flatpak
        sudo apt-get install -y software-properties-common
        sudo apt-add-repository -y --component contrib non-free 
        sudo dpkg --add-architecture i386
        sudo apt-get update && sudo apt-get upgrade -y
    else
        echo "Unkown error has occurred."
    fi
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install --user -y flathub com.github.tchx84.Flatseal        # allows easily managing permissions for flatpaks
}

run_prereq_check(){
    ### make sure curl, wget and flatpak are installed.
    RAN_ONCE_FILE=$SCRIPTS_FOLDER/.ranonce.txt
    test -f "$RAN_ONCE_FILE" && RAN_ONCE_FILE="exists"
    if [ "$RAN_ONCE_FILE" = "exists" ]
    then
        echo "Skipping first run steps."
    else
        install_prereq
        touch "$SCRIPTS_FOLDER"/.ranonce.txt
    fi
}
RAN_ONCE_FILE="missing"
run_prereq_check
