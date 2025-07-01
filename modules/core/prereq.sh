#!/usr/bin/bash

# checks/installs basic packages such as flatpak, curl/wget and git.

deps_check(){
    DEPS="$(cat < "$SCRIPTS_FOLDER"/.deps.txt)"
    if [ "$DEPS" == "0" ]
    then
        install_deps
        echo "1" > "$SCRIPTS_FOLDER"/.deps.txt
    elif [ "$DEPS" == "1" ]
    then
        echo "Not installing dependencies."
    else
        echo "Unkown error has occurred."
    fi
}

install_deps(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y wget curl flatpak dnf-plugins-core
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install wget curl flatpak opi
    else
        echo "Unkown error has occurred."
    fi
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install --user -y flathub com.github.tchx84.Flatseal        # allows easily managing permissions for flatpaks
    sudo mkdir /opt/apps/
    sudo mkdir /opt/apps/icons
    sudo mkdir /opt/apps/temp
    sudo chown $USER:$USER /opt/apps/ -R
    echo "Created folder: /opt/apps/"
    echo "Created folder: /opt/apps/icons"
    echo "Created folder: /opt/apps/temp"
}

deps_check
