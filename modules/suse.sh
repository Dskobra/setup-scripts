#!/usr/bin/bash

main_menu(){
    echo "================================================"
    echo "openSUSE Menu"
    echo "1. Setup DE 2. Gaming"
    echo "3. Coding Tools 4. Extras"
    echo "100. About" 
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        install_basic_apps
    elif [ "$input" -eq 2 ]
    then
        install_game_clients
        mango
    elif [ "$input" -eq 3 ]
    then
        install_coding_tools
    elif [ "$input" -eq 4 ]
    then
        extras_menu
    elif [ "$input" -eq 100 ]
    then
        bash -c "source $SCRIPTS_HOME/modules/misc.sh; about"  
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

install_basic_apps(){
	echo "Setting up packman essentials and brave browser"
    sudo zypper ar -cfp 90 https://ftp.fau.de/packman/suse/openSUSE_Tumbleweed/Essentials packman-essentials    # using essentials for ffmpeg etc
    sudo zypper dup -y --from packman-essentials --allow-vendor-change     # update system packages with essentials

    sudo zypper install curl
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

	sudo zypper install -y konsole kate ark discover dolphin-plugins\
	plymouth-theme-spinfinity 7zip hplip java-17-openjdk brave-browser\
    mozilla-openh264 gstreamer-plugin-openh264 
       
	sudo plymouth-set-default-theme spinfinity -R

    bash -c "source "$SCRIPTS_HOME"/modules/flatpak.sh; fbasic"

    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.


}

install_game_clients(){
    mkdir "$HOME"/Games
	mkdir "$HOME"/Games/bottles
    mkdir "$HOME"/.config/MangoHud/
    sudo zypper install -y steam goverlay gamemode
    sudo modprobe xpad

    bash -c "source "$SCRIPTS_HOME"/modules/flatpak.sh; fgames"
    bash -c "source "$SCRIPTS_HOME"/modules/misc.sh; extra_games"
    
}

install_coding_tools(){
	sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/zypp/repos.d/vscodium.repo
    sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/zypp/repos.d/shiftkey-packages.repo'

    sudo zypper install -y patterns-devel-C-C++-devel_C_C++ patterns-devel-python-devel_python3 patterns-devel-base-devel_rpm_build\
    patterns-containers-container_runtime
    sudo zypper install -y python310-idle git-gui java-17-openjdk-devel codium github-desktop distrobox


    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fdev"
}

extras_menu(){
    echo "================================================"
    echo "Extras"
    echo "1. Virtualization 2. Corectrl"
    echo "3. Extra Apps 4. Cleanup"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        echo "Use Yast -> "Virtualization" -> "Install Hypervisor and Tools" to install"
    elif [ "$input" -eq 2 ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:Dead_Mozay/openSUSE_Tumbleweed/home:Dead_Mozay.repo
        sudo zypper refresh
        sudo zypper install -y corectrl
	    cp /usr/share/applications/org.corectrl.corectrl.desktop "$HOME"/.config/autostart/org.corectrl.corectrl.desktop
    elif [ "$input" -eq 3 ]
    then
        sudo zypper install -y k3b v4l2loopback-autoload
        bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fextras"
    elif [ "$input" -eq 4 ]
    then
        cleanup
    elif [ "$input" -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    echo $input
    unset input
    extras_menu
}

mango(){
    # link bottles/lutris to mangohud configuration folder
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/com.usebottles.bottles/config/"
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
    $SCRIPTS_HOME/modules/mangohud.sh
    
}

cleanup(){
    sudo zypper remove -y icewm
}

SCRIPTS_HOME=$(pwd)
DESKTOP=$XDG_CURRENT_DESKTOP
main_menu