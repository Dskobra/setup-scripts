#!/usr/bin/bash

# checks/installs basic packages such as flatpak, curl/wget and git.

install_prereq(){
    if [ "$DISTRO" == "fedora" ]
    then
        echo "Following packages will be installed: curl wget flatpak flatseal dnf-plugins-core"
        sudo dnf install -y curl wget flatpak dnf-plugins-core
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf update -y
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        echo "Following packages will be installed: curl wget flatpak flatseal"
        sudo zypper -n install wget curl flatpak
    else
        echo "Unkown error has occurred."
    fi
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install --user -y flathub com.github.tchx84.Flatseal        # allows easily managing permissions for flatpaks
}

run_prereq_check(){
    ### make sure curl, wget and flatpak are installed.
    PREREQ_FILE=$(cat $SCRIPTS_FOLDER/.prereq.txt)
    echo $PREREQ_FILE
   if [ "$PREREQ_FILE" != "1" ]
    then
        mkdir /home/$USER/bin
        sudo mkdir /opt/apps/
        sudo mkdir /opt/apps/icons
        sudo mkdir /opt/apps/appimages
        sudo chown $USER:$USER /opt/apps/ -R
        install_prereq
        echo "1" > $SCRIPTS_FOLDER/.prereq.txt
    else
        echo "Skipping first run steps."
    fi
}
run_prereq_check
