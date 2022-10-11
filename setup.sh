#/usr/bin/bash

setup_repos(){
	echo "Setting up rpmfusion and flathub."
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf update -y
}

install_basic_apps(){
	sudo dnf install -y  java-17-openjdk brave-browser \
	plymouth-theme-spinfinity vim-enhanced lm_sensors \
	bluecurve-icon-theme
	sudo plymouth-set-default-theme spinfinity -R
	flatpak install -y flathub org.keepassxc.KeePassXC
	sudo mkdir /opt/launchers
	sudo chown $USER:$USER /opt/launchers
}

get_desktop_extras(){
    DESKTOP=$XDG_CURRENT_DESKTOP
	if [ "$DESKTOP" = "GNOME" ];
	then
		install_gnome_extras
	elif [ "$DESKTOP" = "KDE" ];
	then
		install_kde_extras
	elif [ "$DESKTOP" = "MATE" ];
	then
		echo "Now setting up some extra mate features."
		sudo dnf install -y caja-dropbox caja-share \
		mate-menu
	fi
}

install_gnome_extras(){
	echo "Now setting up some extra gnome features."
	sudo dnf install -y menulibre pavucontrol \
	gnome-tweaks nautilus-dropbox file-roller \
	gnome-shell-extension-appindicator openssl \
	humanity-icon-theme gedit gedit-plugins
	flatpak install -y flathub org.gnome.Extensions
	flatpak install -y flathub com.transmissionbt.Transmission
	flatpak install -y flathub org.gimp.GIMP
}

install_kde_extras(){
	echo "Now setting up some extra kde features."
	sudo dnf install -y dolphin-plugins \
	kate zenity ark digikam kde-connect konversation \
	kpat ktorrent krusader
	flatpak install -y flathub com.dropbox.Client
}

get_desktop_extras(){
    DESKTOP=$XDG_CURRENT_DESKTOP
    if [ "$DESKTOP" = "GNOME" ];
	then
		install_gnome_extras
	elif [ "$DESKTOP" = "KDE" ];
	then
		install_kde_extras
	elif [ "$DESKTOP" = "MATE" ];
	then
		echo "Now setting up some extra mate features."
		sudo dnf install -y caja-dropbox caja-share \
		mate-menu
	fi
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
	flatpak install -y flathub org.geany.Geany

}

install_utilities(){
	sudo dnf -y copr enable timlau/yumex-dnf
	sudo dnf install -y yumex-dnf dconf-editor \
	clamav clamav-update firewall-applet kleopatra \
	mediawriter
	flatpak install -y flathub org.gtkhash.gtkhash
	flatpak install -y flathub com.github.tchx84.Flatseal
}
main_help(){
    echo "1. Repos - rpmfusion, flatpak and brave browser."
    echo "2. Amd Drivers - x11 driver arnd radeon-profile package for fan control. Doesnt work on laptops or cards without fans."
    echo "3. Setup DE - Sets up desktop environment specific packages. Also installs brave and few other basic packages."
    echo "Such as nautilus-dropbox for gnome etc."
    echo "4. Audio/Video Support - VLC, mppeg and and openh264 codecs."
    echo "5. Office - Sets up office apps like libreoffice and HP printer drivers."
    echo "6. Multimedia Editing Tools - OBS Studio, GIMP and OpenShot."
    echo "7. Coding Tools - Compilers, nodejs and other development packages."
    echo "8. Gaming - Wine, lutris and steam. Plus extra stuff like mangohud, gamingmode, discord, xbox controller etc."
    echo "9. Servers - Apache Web Server, samba and mysql."
    echo "10. Utilities - Clamav, dnfdragora and some other useful packages."
    echo "11. Virtualization - libvirt and related tools."
    echo "12. Extras - Some extra stuff like ossec."
}

about(){
    VERSION=10.5.2022.3.20am
    echo "================================================"
    echo "Copyright (c) 2022 Jordan Bottoms"
    echo "Released under the MIT license"
    echo "Version: $VERSION"
    echo "================================================"
    main_menu
}

games_menu(){
    echo "================================================"
    echo "Games Menu"
    echo "1. Steam Client 2. Wine"
    echo "3. Lutris/Bottles 4. WoW Up" 
    echo "5. Minecraft 6. Controller Setup"
    echo "99. Help 0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        sudo dnf install -y mangohud gamemode gamemode.i686 steam steam-devices
	    flatpak install -y flathub net.davidotek.pupgui2
    elif [ $input -eq 2 ]
    then
        ./install/winehq.sh
    elif [ $input -eq 3 ]
    then
        ./install/gaming_apps.sh
    elif [ $input -eq 4 ]
    then
        ./install/wowup.sh
    elif [ $input -eq 5 ]
    then
        flatpak -y install flathub com.mojang.Minecraft
    elif [ $input -eq 6 ]
    then
        sudo dnf install -y kernel-modules-extra
	    sudo modprobe xpad
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

games_help(){
    echo "1. Steam Client - Self explanatory. :P"
    echo "2. Wine - official version of wine from winehq."
    echo "3. Lutris/Bottles - Downloads latest stable lutris, bottles and protonup."
    echo "4. WoW Up - World of Warcraft addon manager."
    echo "5. Minecraft - installs flatpak package of minecraft."
    echo "6. Controller Setup - Installs kernel development packages and runs xpad."
}

office_menu(){
    echo "================================================"
    echo "Office Menu"
    echo "1. LibreOffice/QOwnNotes 2. Social Apps (messengers etc)"
    echo "3. HP Printer Drivers"
    echo "99. Help 0. Back to main menu"
    printf "Option: "
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

office_help(){
    echo "1. LibreOffice/QOwnNotes - self explanatory. :P"
    echo "2. Social Apps - Currently installs discord and pidgin."
}

servers_menu(){
    echo "================================================"
    echo "1. Lamp Stack 2. Samba Share"
    echo "3. Fedora Cockpit"
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
        ./install/samba_share.sh
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

servers_help(){
    echo "1. Lamp Stack - Apache web server, mariadb etc."
    echo "2. Fedora Cockpit - Setups fedora cockpit for remote management."
    echo "3. Samba Share - Installs samba server and creates folders."
}

main_menu(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Repos 2. AMD Radeon Fan Control"
    echo "3. Setup DE 4. Audio/Video Support" 
    echo "5. Office 6. A/V/Image Editing/Recording"
    echo "7.Coding Tools 8. Gaming"
    echo "9. Servers 10. Utilities"
    echo "11. Virtualization"
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
        sudo dnf install -y gstreamer1-plugin-openh264 \
	    mozilla-openh264 ffmpeg
	    flatpak install -y flathub org.videolan.VLC
    elif [ $input -eq 5 ]
    then
        office_menu
    elif [ $input -eq 6 ]
    then
        sudo dnf install -y kolourpaint
	    flatpak install -y flathub com.obsproject.Studio
	    flatpak install -y flathub org.openshot.OpenShot
    elif [ $input -eq 7 ]
    then
        install_coding_tools
    elif [ $input -eq 8 ]
    then
        games_menu
    elif [ $input -eq 9 ]
    then
        servers_menu
    elif [ $input -eq 10 ]
    then
        install_utilities
    elif [ $input -eq 11 ]
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


USER=$(whoami)
main_menu
