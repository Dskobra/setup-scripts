#!/usr/bin/bash

main_menu(){
    echo "================================================"
    echo "Main Menu"
    echo "1.Brave Browser 2. Coding Tools"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        install_brave
    elif [ "$input" -eq 2 ]
    then
        coding_servers_menu
    elif [ "$input" -eq 100 ]
    then
        about
    elif [ "$input" -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    echo $input
    unset input
    main_menu
}

coding_servers_menu(){
    echo "================================================"
    echo "Coding and Servers"
    echo "1. Coding Tools 2. Lamp Stack" 
    echo "3. Fedora Cockpit 4. Samba Share"
    echo "0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        install_coding_tools
    elif [ "$input" -eq 2 ]
    then
        sudo dnf install -y systemd
        sudo dnf install -y httpd php mariadb mariadb-server
	    sudo dnf install -y phpmyadmin
	    sudo systemctl enable --now httpd mariadb
    elif [ "$input" -eq 3 ]
    then
        sudo dnf install -y systemd
        sudo dnf install -y cockpit
	    sudo systemctl enable --now cockpit.socket
	    sudo firewall-cmd --add-service=cockpit
	    sudo firewall-cmd --add-service=cockpit --permanent
    elif [ "$input" -eq 4 ]
    then
        sudo dnf install -y systemd
        sudo dnf install -y samba
        sudo systemctl enable smb nmb
        sudo firewall-cmd --add-service=samba --permanent
        sudo firewall-cmd --reload
        mkdir "$HOME"/FILES1
        mkdir "$HOME"/FILES2
    elif [ "$input" -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    echo $input
    unset input
    coding_servers_menu
}

install_brave(){
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf update -y
    

    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf update -y

    sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
    sudo dnf install -y gstreamer1-plugin-openh264 \
	ffmpeg ffmpeg-libs.i686 ffmpeg-libs
	sudo dnf install -y brave-browser
}

install_coding_tools(){
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
	sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
    sudo dnf groupinstall -y "C Development Tools and libraries"
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf groupinstall -y "RPM Development Tools"
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
	sudo dnf install -y python3-tools python3-devel git-gui \
	java-17-openjdk-devel codium github-desktop systemd

}

about(){
    VERSION="dev branch"
    echo "================================================"
    echo "Copyright (c) 2023 Jordan Bottoms"
    echo "Released under the MIT license"
    echo "Version: $VERSION"
    echo "================================================"
    main_menu
}

main_menu