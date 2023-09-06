#!/usr/bin/bash

dev_menu(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Virtual Machine 2. Containers"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
       fedora_vm_menu
    elif [ "$input" -eq 2 ]
    then
        container_dev_tools
    elif [ "$input" -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    echo $input
    unset input
    containers_menu
}

fedora_vm_menu(){
    echo "================================================"
    echo "Fedora (dnf)"
    echo "1. Setup DE 2. Dev Tools"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        install_vm_basic_apps
    elif [ "$input" -eq 2 ]
    then
        install_vm_dev_tools
    elif [ "$input" -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    echo $input
    unset input
    fedora_vm_menu
}

install_vm_basic_apps(){
    echo "Setting up rpmfusion and brave browser"
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf update -y


	sudo dnf install -y  dolphin-plugins ark java-17-openjdk\
    brave-browser plymouth-theme-spinfinity vim-enhanced\
    lm_sensors p7zip p7zip-plugins hplip-gui dnfdragora           
    
    sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
    sudo dnf install -y gstreamer1-plugin-openh264 \
	mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs
	sudo plymouth-set-default-theme spinfinity -R
    
	bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fbasic"
    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; futils"

    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.


}

install_vm_dev_tools(){
	sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
	sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
    
    sudo dnf groupinstall -y "C Development Tools and libraries"
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf groupinstall -y "RPM Development Tools"
    sudo dnf groupinstall -y "Container Management"

	sudo dnf install -y python3-idle python3-devel git-gui \
	java-17-openjdk-devel codium github-desktop distrobox\
    toolbox
    sudo systemctl enable podman

    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
}

container_dev_tools(){
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf groupinstall -y "C Development Tools and libraries"
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf groupinstall -y "RPM Development Tools"
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
	sudo dnf install -y python python3-devel java-17-openjdk-devel

}

dev_menu
