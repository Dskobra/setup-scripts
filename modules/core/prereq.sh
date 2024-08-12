#!/usr/bin/bash

# basic packages for installing everything
install_prereq(){
    if [ $PKGMGR == "dnf" ]
    then
        echo "Following packages will be installed: git curl wget zenity flatpak flatseal dnf-plugins-core"
        sudo dnf install -y git curl wget zenity flatpak dnf-plugins-core
        sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf update -y
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        echo "Following packages will be installed: zenity flatseal dnf-plugins-core"
        sudo rpm-ostree install zenity dnf dnf-plugins-core
        sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo rpm-ostree apply-live
        flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    elif [ $PKGMGR == "apt-get" ]
    then
        echo "Following packages will be installed: git curl wget zenity flatpak flatseal software-properties-common"
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

run_prereq_check(){
    ### make sure git, curl, wget, zenity
    ### and flatpak are installed.
    RAN_ONCE_FILE=$SCRIPTS_FOLDER/.ranonce.txt
    test -f $RAN_ONCE_FILE && RAN_ONCE_FILE="exists"
    if [ "$RAN_ONCE_FILE" = "exists" ]
    then
        echo "Skipping first run steps."
    else
        install_prereq
        touch $SCRIPTS_FOLDER/.ranonce.txt
        zenity --info --text="Required packages now installed and enabled 3rd party repositories. May now proceed to text menu."
    fi
}
RAN_ONCE_FILE="missing"
run_prereq_check
#install_prereq