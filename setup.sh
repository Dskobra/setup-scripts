#!/usr/bin/bash

fed_main_menu(){
    echo "================================================"
    echo "Fedora Menu"
    echo "1. Setup DE 2. Gaming"
    echo "3. Coding/Servers 4. Extras"
    echo "100. About" 
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        fed_install_basic_apps
    elif [ "$input" -eq 2 ]
    then
        fed_install_game_clients
        mango
    elif [ "$input" -eq 3 ]
    then
        fed_coding_servers_menu
    elif [ "$input" -eq 4 ]
    then
        fed_extras_menu
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
    fed_main_menu
}

fed_install_basic_apps(){
	echo "Setting up rpmfusion and flathub."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	if [ "$DESKTOP" = "MATE" ]
	then
		echo "Now setting up some extra mate features."
		sudo dnf install -y caja-share mate-menu \
        dconf-editor humanity-icon-theme \
        gnome-icon-theme pavucontrol
    else
        echo "Not running Mate."
	fi
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf update -y


	sudo dnf install -y  java-17-openjdk brave-browser \
	plymouth-theme-spinfinity vim-enhanced lm_sensors \
    p7zip p7zip-plugins hplip-gui dnfdragora             
    
    sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
    sudo dnf install -y gstreamer1-plugin-openh264 \
	mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs
    sudo dnf groupinstall -y "Firefox Web Browser"
	sudo plymouth-set-default-theme spinfinity -R
    
	flatpak install -y flathub org.keepassxc.KeePassXC
    flatpak install -y flathub com.transmissionbt.Transmission
    flatpak install -y flathub com.dropbox.Client

    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.


}

fed_install_game_clients(){
    mkdir "$HOME"/Games
	mkdir "$HOME"/Games/bottles
    mkdir "$HOME"/.config/MangoHud/
    sudo dnf install -y steam goverlay
    sudo modprobe xpad
	flatpak install -y flathub net.davidotek.pupgui2
    flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/21.08
    flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/22.08

    flatpak install -y flathub com.usebottles.bottles
    flatpak install -y flathub net.lutris.Lutris 
    
    # run once to ensure folders/runtimes are setup
    flatpak run com.usebottles.bottles
    flatpak run net.lutris.Lutris

    cd "$HOME"/Downloads
    wget https://launcher.mojang.com/download/Minecraft.tar.gz
    tar -xvf Minecraft.tar.gz
    cd minecraft-launcher
    chmod +x minecraft-launcher
    mv minecraft-launcher "$HOME"/Desktop
    cd "$HOME"/Downloads
    rm -r minecraft-launcher
    rm Minecraft.tar.gz

    flatpak install -y flathub org.kde.kpat

    WOWUPLINK=https://github.com/WowUp/WowUp.CF/releases/download/v2.9.2/WowUp-CF-2.9.2.AppImage
    WOWUPBINARY=WowUp-CF-2.9.2.AppImage
    cd "$HOME"/Desktop
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
    
}

fed_coding_servers_menu(){
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
        fed_install_coding_tools
    elif [ "$input" -eq 2 ]
    then
        sudo dnf install -y httpd php mariadb mariadb-server
	    sudo dnf install -y phpmyadmin
	    sudo systemctl enable --now httpd mariadb
    elif [ "$input" -eq 3 ]
    then
        sudo dnf install -y cockpit
	    sudo systemctl enable --now cockpit.socket
	    sudo firewall-cmd --add-service=cockpit
	    sudo firewall-cmd --add-service=cockpit --permanent
    elif [ "$input" -eq 4 ]
    then
        sudo dnf install -y samba
        sudo systemctl enable smb nmb
        sudo firewall-cmd --add-service=samba --permanent
        sudo firewall-cmd --reload
        mkdir "$HOME"/FILES1
        mkdir "$HOME"/FILES2
    elif [ "$input" -eq 0 ]
    then
	    fed_main_menu
    else
	    echo "error."
    fi
    echo $input
    unset input
    coding_servers_menu
}

fed_install_coding_tools(){
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
	sudo dnf install -y python3-idle python3-devel git-gui \
	java-17-openjdk-devel codium github-desktop

}

fed_extras_menu(){
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
        sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
        -O /etc/yum.repos.d/virtio-win.repo
        sudo dnf groupinstall -y "Virtualization"
	    sudo dnf install -y virtio-win
    elif [ "$input" -eq 2 ]
    then
        sudo dnf install -y corectrl
	    cp /usr/share/applications/org.corectrl.corectrl.desktop "$HOME"/.config/autostart/org.corectrl.corectrl.desktop
    elif [ "$input" -eq 3 ]
    then
        fed_extra_apps
    elif [ "$input" -eq 4 ]
    then
        fed_cleanup
    elif [ "$input" -eq 0 ]
    then
	    fed_main_menu
    else
	    echo "error."
    fi
    echo $input
    unset input
    extras_menu
}

fed_extra_apps(){
    
    sudo dnf install -y dolphin-plugins ark kate kate-plugins\
    k3b v4l2loopback
    
    flatpak install -y flathub org.openshot.OpenShot
    flatpak install -y flathub org.gimp.GIMP
    flatpak install -y flathub org.kde.kolourpaint
    flatpak install -y flathub com.discordapp.Discord
	flatpak install -y flathub im.pidgin.Pidgin
    flatpak install -y flathub org.libreoffice.LibreOffice
	flatpak install -y flathub org.qownnotes.QOwnNotes

    flatpak install -y flathub org.fedoraproject.MediaWriter
    flatpak install -y flathub org.kde.kleopatra
	flatpak install -y flathub org.gtkhash.gtkhash
	flatpak install -y flathub com.github.tchx84.Flatseal
    flatpak install -y flathub org.raspberrypi.rpi-imager
    flatpak install -y flathub org.videolan.VLC
    flatpak install -y flathub com.obsproject.Studio

}

mango(){
    # link bottles/lutris to mangohud configuration folder
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/com.usebottles.bottles/config/"
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
    cd $SCRIPTS_HOME/mangohud
    ./setup.sh

    
}

fed_cleanup(){
	# Installing Fedora 36 using the everything installer to install the mate desktop with my normal package groups "Development Tools", 
	# "C Development Tools and libraries" and "RPM Development Tools" results in systemd-oomd-defaults also being installed.
	# This creates a package conflict with mate-desktop and mate-desktop-configs when updating. Research shows this is an 
	# uneeded/extra package as Fedora uses earlyoom. So removing systemd-oomd-defaults is perfectly safe. Unsure what causes this
	# to be installed.
	sudo dnf remove -y libreoffice-core \
	gnome-shell-extension-gamemode gnome-text-editor \
	kmahjongg kmines systemd-oomd-defaults \
	transmission-gtk transmission-qt \
	compiz kpat
}

suse_main_menu(){
    echo "================================================"
    echo "openSUSE Menu"
    echo "1. Setup DE 2. Gaming"
    echo "3. Coding/Servers 4. Extras"
    echo "100. About" 
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        suse_install_basic_apps
    elif [ "$input" -eq 2 ]
    then
        suse_install_game_clients
        mango
    elif [ "$input" -eq 3 ]
    then
        #suse_coding_servers_menu
    elif [ "$input" -eq 4 ]
    then
        #suse_extras_menu
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
    suse_main_menu
}

suse_install_basic_apps(){
	echo "Setting up packman essentials and flathub."
    sudo zypper ar -cfp 90 https://ftp.fau.de/packman/suse/openSUSE_Tumbleweed/Essentials packman-essentials    # using essentials for ffmpeg etc
    sudo zypper dup --from packman-essentials --allow-vendor-change     # update system packages with essentials
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    sudo zypper install curl
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

	sudo zypper install -y  java-17-openjdk brave-browser \
	plymouth-theme-spinfinity vim-enhanced p7zip p7zip-plugins hplip             

    sudo zypper install -y gstreamer1-plugin-openh264 mozilla-openh264
	sudo plymouth-set-default-theme spinfinity -R
    
	flatpak install -y flathub org.keepassxc.KeePassXC
    flatpak install -y flathub com.transmissionbt.Transmission
    flatpak install -y flathub com.dropbox.Client

    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.


}

suse_install_game_clients(){
    mkdir "$HOME"/Games
	mkdir "$HOME"/Games/bottles
    mkdir "$HOME"/.config/MangoHud/
    sudo zypper install -y steam goverlay gamemode
    sudo modprobe xpad
	flatpak install -y flathub net.davidotek.pupgui2
    flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/21.08
    flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/22.08

    flatpak install -y flathub com.usebottles.bottles
    flatpak install -y flathub net.lutris.Lutris 
    
    # run once to ensure folders/runtimes are setup
    flatpak run com.usebottles.bottles
    flatpak run net.lutris.Lutris

    cd "$HOME"/Downloads
    wget https://launcher.mojang.com/download/Minecraft.tar.gz
    tar -xvf Minecraft.tar.gz
    cd minecraft-launcher
    chmod +x minecraft-launcher
    mv minecraft-launcher "$HOME"/Desktop
    cd "$HOME"/Downloads
    rm -r minecraft-launcher
    rm Minecraft.tar.gz

    flatpak install -y flathub org.kde.kpat

    WOWUPLINK=https://github.com/WowUp/WowUp.CF/releases/download/v2.9.2/WowUp-CF-2.9.2.AppImage
    WOWUPBINARY=WowUp-CF-2.9.2.AppImage
    cd "$HOME"/Desktop
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
    
}

about(){
    VERSION="dev branch"
    echo "================================================"
    echo "Copyright (c) 2021-2023 Jordan Bottoms"
    echo "Released under the MIT license"
    echo "Version: $VERSION"
    echo "================================================"
    fed_main_menu
}

distro_check(){
    ID=$(grep 'ID' -w /etc/os-release)

    if [ "$input" -eq 1 "ID=fedora" ]
    then
        fed_fed_main_menu
    elif [ "$input" -eq "ID=opensuse-tumbleweed" ]
    then
        suse_install_basic_apps
    else
	    echo "error."
    fi
}

SCRIPTS_HOME=$(pwd)
DESKTOP=$XDG_CURRENT_DESKTOP
distro_check
