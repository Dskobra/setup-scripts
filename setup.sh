#!/usr/bin/bash

setup_repos(){
	echo "Setting up rpmfusion and flathub."
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf update -y
}

setup_wine_repo(){
	source /etc/os-release
	getRelease=$(echo $VERSION_ID)
	echo "Fedora Version:" $getRelease

	if [ "$getRelease" = "36" ]
	then
		# remove after 37 is released, winehq updated and no major bugs.
		sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/36/winehq.repo
	elif [ "$getRelease" = "37" ]
	then
		# temporarily use fedora 36 winehq repo on fedora 37. change when official 37 support is added.
		sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/36/winehq.repo
	elif [ "$getRelease" = "38" ]
	then
		# temporarily use fedora 36 winehq repo on fedora 37. change when official 37 support is added.
		#sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/36/winehq.repo
		echo "Fedora 38 placeholder. Not due for release until around may/june"
	elif [ $input -eq 0 ]
	then
		exit
	else
		echo "error."
	fi
}

get_desktop_extras(){
    DESKTOP=$XDG_CURRENT_DESKTOP
    if [ "$DESKTOP" = "GNOME" ]
	then
		install_gnome_extras
	elif [ "$DESKTOP" = "KDE" ]
	then
		install_kde_extras
	elif [ "$DESKTOP" = "MATE" ]
	then
		echo "Now setting up some extra mate features."
		sudo dnf install -y caja-dropbox caja-share \
		mate-menu
    else
        echo "test"
	fi
}

install_basic_apps(){
	sudo dnf install -y  java-17-openjdk brave-browser \
	plymouth-theme-spinfinity vim-enhanced lm_sensors \
	bluecurve-icon-theme p7zip p7zip-plugins 
	sudo plymouth-set-default-theme spinfinity -R
	flatpak install -y flathub org.keepassxc.KeePassXC
    flatpak install -y flathub com.transmissionbt.Transmission
    mkdir /home/$USER/.apps
    mkdir /home/$USER/.apps/launchers
}

install_gnome_extras(){
	echo "Now setting up some extra gnome features."
	sudo dnf install -y menulibre pavucontrol \
	gnome-tweaks nautilus-dropbox file-roller \
	gnome-shell-extension-appindicator openssl \
	humanity-icon-theme gedit gedit-plugins
	flatpak install -y flathub org.gnome.Extensions
	
	
}

install_kde_extras(){
	echo "Now setting up some extra kde features."
	sudo dnf install -y dolphin-plugins ark digikam \
    kde-connect kpat krusader dropbox
	#flatpak install -y flathub com.dropbox.Client
}

install_coding_tools(){
	sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
	sudo dnf install -y python3-tools python3-devel git-gui \
	java-17-openjdk-devel codium
	flatpak install -y flathub io.github.shiftey.Desktop

}

install_utilities(){
	sudo dnf -y copr enable timlau/yumex-dnf
	sudo dnf install -y yumex-dnf dconf-editor \
	clamav clamav-update firewall-applet kleopatra \
	mediawriter
	flatpak install -y flathub org.gtkhash.gtkhash
	flatpak install -y flathub com.github.tchx84.Flatseal
}

install_game_clients(){
    mkdir /home/$USER/Games
	mkdir /home/$USER/Games/bottles
    sudo dnf install -y mangohud gamemode gamemode.i686 steam steam-devices \
    kernel-modules-extra
    sudo modprobe xpad
	flatpak install -y flathub net.davidotek.pupgui2
	flatpak install -y flathub com.usebottles.bottles
    flatpak install -y flathub net.lutris.Lutris
    flatpak install -y org.freedesktop.Platform.VulkanLayer.MangoHud
}


install_wowup(){
    WOWUPLINK=https://github.com/WowUp/WowUp/releases/download/v2.9.0/WowUp-2.9.0.AppImage
    WOWUPBINARY=WowUp-2.9.0.AppImage
    mkdir /home/$USER/Downloads/wowup 
    cd /home/$USER/Downloads/wowup 
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
    mv /home/$USER/Downloads/wowup /home/$USER/.apps
}

install_samba(){
	sudo dnf install -y samba
	sudo systemctl enable smb nmb
	sudo firewall-cmd --add-service=samba --permanent
	sudo firewall-cmd --reload
	sudo mkdir /mnt/shared
	sudo chown $USER /mnt/shared -R
}

main_help(){
    echo "1. Repos - rpmfusion, flatpak and brave browser."
    echo "2. AMD Radeon Fan Control - installs radeon-profile package for fan control and enables the service."
    echo "3. Setup DE - Sets up desktop environment specific packages. Also installs brave and few other basic packages."
    echo "Such as nautilus-dropbox for gnome etc."
    echo "4. Media Menu - Sub menu for media related packages."
    echo "5. Office Menu - Sub menu for office related packages."
    echo "6. Coding Tools - openJDK, nodejs and other development packages."
    echo "7. Gaming Menu - Sub menmu for gaming related packages."
    echo "8. Servers Menu - Sub menu for server related packages."
    echo "9. Utilities - Clamav, yumex and some other useful packages."
    echo "10. Virtualization - libvirt and related tools."
}

games_help(){
    echo "1. Steam Client - Self explanatory. :P"
    echo "2. Wine - official version of wine from winehq."
    echo "3. Lutris/Bottles - Downloads latest stable lutris, bottles and protonup."
    echo "4. WoW Up - World of Warcraft addon manager."
    echo "5. Minecraft - installs flatpak package of minecraft."
    echo "6. Controller Setup - Installs kernel development packages and runs xpad."
}

office_help(){
    echo "1. LibreOffice/QOwnNotes - self explanatory. :P"
    echo "2. Social Apps - Currently installs discord and pidgin."
    echo "3. HP Printer Drivers - self explanatory. :P"
}

servers_help(){
    echo "1. Lamp Stack - Apache web server, mariadb and php/phpmyadmin."
    echo "2. Fedora Cockpit - Setups fedora cockpit for remote management."
    echo "3. Samba Share - Installs samba server and creates folders."
}

media_help(){
    echo "1. Codecs/Playback - openh264 (firefox), ffmpeg and vlc."
    echo "2. Editing Tools - GIMP, Kolourpaint and OpenShot."
    echo "3. OBS Studio - self explanatory. :P"
}

main_menu(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Repos 2. AMD Radeon Fan Control"
    echo "3. Setup DE 4. Media Menu" 
    echo "5. Office Menu 6.Coding Tools"
    echo "7. Gaming Menu 8. Servers Menu"
    echo "9. Utilities 10. Virtualization"
    echo "99. Help 100. About script "
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        setup_repos
    elif [ $input -eq 2 ]
    then
        sudo dnf install -y radeon-profile
	    sudo systemctl enable radeon-profile-daemon.service
	    sudo systemctl start radeon-profile-daemon.service
    elif [ $input -eq 3 ]
    then
        install_basic_apps
        get_desktop_extras
    elif [ $input -eq 4 ]
    then
        media_menu
    elif [ $input -eq 5 ]
    then
        office_menu
    elif [ $input -eq 6 ]
    then
        install_coding_tools
    elif [ $input -eq 7 ]
    then
        games_menu
    elif [ $input -eq 8 ]
    then
        servers_menu
    elif [ $input -eq 9 ]
    then
        install_utilities
    elif [ $input -eq 10 ]
    then
        sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
        -O /etc/yum.repos.d/virtio-win.repo
	    sudo dnf install -y	virt-manager libvirt-client virtio-win
    elif [ $input -eq 99 ]
    then
        main_help
    elif [ $input -eq 100 ]
    then
        about
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    main_menu
}

games_menu(){
    echo "================================================"
    echo "Games Menu"
    echo "1. Game Clients 2. WoW Up"
    echo "3. Minecraft"
    echo "99. Help 0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        install_game_clients
    elif [ $input -eq 2 ]
    then
        install_wowup
    elif [ $input -eq 3 ]
    then
        flatpak -y install flathub com.mojang.Minecraft
    elif [ $input -eq 99 ]
    then
        games_help
    elif [ $input -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    games_menu
}

office_menu(){
    echo "================================================"
    echo "Office Menu"
    echo "1. LibreOffice/QOwnNotes 2. Social Apps (messengers etc)"
    echo "3. HP Printer Drivers"
    echo "99. Help 0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        flatpak install -y flathub org.libreoffice.LibreOffice
	    flatpak install -y flathub org.qownnotes.QOwnNotes
    elif [ $input -eq 2 ]
    then
        flatpak install -y flathub com.discordapp.Discord
	    flatpak install -y flathub im.pidgin.Pidgin
    elif [ $input -eq 3 ]
    then
        sudo dnf install -y hplip-gui
    elif [ $input -eq 99 ]
    then
        office_help
    elif [ $input -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    office_menu
}

media_menu(){
    echo "================================================"
    echo "Media Menu"
    echo "1. Codecs/Playback 2. Editing Tools"
    echo "3. OBS Studio"
    echo "99. Help 0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        echo ""
        sudo dnf install -y gstreamer1-plugin-openh264 \
	    mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs
	    flatpak install -y flathub org.videolan.VLC
    elif [ $input -eq 2 ]
    then
        sudo dnf install -y kolourpaint
	    flatpak install -y flathub org.openshot.OpenShot
        flatpak install -y flathub org.gimp.GIMP
    elif [ $input -eq 3 ]
    then
        flatpak install -y flathub com.obsproject.Studio
    elif [ $input -eq 99 ]
    then
        media_help
    elif [ $input -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    media_menu
}

servers_menu(){
    echo "================================================"
    echo "1. Lamp Stack 2. Fedora Cockpit"
    echo "3. Samba Share"
    echo "99. Help 0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        sudo dnf install -y httpd php mariadb mariadb-server
	    sudo dnf install -y phpmyadmin
	    sudo systemctl enable --now httpd mariadb
    elif [ $input -eq 2 ]
    then
        sudo dnf install -y cockpit
	    sudo systemctl enable --now cockpit.socket
	    sudo firewall-cmd --add-service=cockpit
	    sudo firewall-cmd --add-service=cockpit --permanent
    elif [ $input -eq 3 ]
    then
        install_samba
    elif [ $input -eq 99 ]
    then
        servers_help
    elif [ $input -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    servers_menu
}

about(){
    VERSION="dev branch"
    echo "================================================"
    echo "Copyright (c) 2022 Jordan Bottoms"
    echo "Released under the MIT license"
    echo "Version: $VERSION"
    echo "================================================"
    main_menu
}

USER=$(whoami)
main_menu
