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

install_bottles(){
	mkdir /home/$USER/Games
	mkdir /home/$USER/Games/bottles
	flatpak install -y flathub com.usebottles.bottles
}

install_lutris(){
	sudo dnf install -y gnome-desktop3 xrandr xorg-x11-server-Xephyr python3-evdev gvfs cabextract \
	python3-magic libraqm python3-olefile python3-pillow fluid-soundfont-gs p7zip p7zip-plugins 
	sudo dnf install -y lutris
}

install_wine(){
	echo "Installing wine and various libs for things like wow."
    sudo dnf install -y alsa-plugins-pulseaudio.i686 glibc-devel.i686 glibc-devel libgcc.i686 libX11-devel.i686 freetype-devel.i686
    sudo dnf install -y libXcursor-devel.i686 libXi-devel.i686 libXext-devel.i686 libXxf86vm-devel.i686 libXrandr-devel.i686
    sudo dnf install -y libXinerama-devel.i686 mesa-libGLU-devel.i686 mesa-libOSMesa-devel.i686 libXrender-devel.i686 libpcap-devel.i686
    sudo dnf install -y ncurses-devel.i686 libzip-devel.i686 lcms2-devel.i686 zlib-devel.i686 libv4l-devel.i686 libgphoto2-devel.i686
    sudo dnf install -y cups-devel.i686 libxml2-devel.i686 openldap-devel.i686 libxslt-devel.i686 gnutls-devel.i686 libpng-devel.i686
    sudo dnf install -y flac-libs.i686 json-c.i686 libICE.i686 libSM.i686 libXtst.i686 libasyncns.i686 libedit.i686
    sudo dnf install -y liberation-narrow-fonts.noarch libieee1284.i686 libogg.i686 libsndfile.i686 libuuid.i686 libva.i686 libvorbis.i686
    sudo dnf install -y libwayland-client.i686 libwayland-server.i686 llvm-libs.i686 mesa-dri-drivers.i686 mesa-filesystem.i686 mesa-libEGL.i686
    sudo dnf install -y mesa-libgbm.i686 nss-mdns.i686 ocl-icd.i686 pulseaudio-libs.i686  sane-backends-libs.i686 tcp_wrappers-libs.i686 unixODBC.i686
    sudo dnf install -y samba-common-tools.x86_64 samba-libs.x86_64 samba-winbind.x86_64
    sudo dnf install -y samba-winbind-clients.x86_64 samba-winbind-modules.x86_64 mesa-libGL-devel.i686 fontconfig-devel.i686 libXcomposite-devel.i686
    sudo dnf install -y libtiff-devel.i686 openal-soft-devel.i686 mesa-libOpenCL-devel.i686 opencl-utils-devel.i686 alsa-lib-devel.i686 gsm-devel.i686
    sudo dnf install -y libjpeg-turbo-devel.i686 pulseaudio-libs-devel.i686 pulseaudio-libs-devel gtk3-devel.i686 libattr-devel.i686 libva-devel.i686
    sudo dnf install -y libexif-devel.i686 libexif.i686 glib2-devel.i686 mpg123-devel.i686 mpg123-devel.x86_64 libcom_err-devel.i686
    sudo dnf install -y libcom_err-devel.x86_64 libFAudio-devel.i686 libFAudio-devel.x86_64
    sudo dnf install -y gnutls.i686 gnutls-devel openldap openldap.i686
	sudo dnf install -y openldap-devel libgpg-error libgpg-error.i686 sqlite2.i686 sqlite2.x86_64
	sudo dnf install -y pipewire-devel.i686 pipewire-devel.x86_64 gstreamer1*.i686 gstreamer1*.x86_64
	sudo dnf install -y freetype.i686 gnutls.i686 openldap.i686 libgpg-error.i686 sqlite2.i686 pulseaudio-libs.i686
	sudo dnf install -y dxvk-native-devel.x86_64 dxvk-native-devel.i686 vulkan-tools
    sudo dnf install -y winehq-staging
}

install_wowup(){
    WOWUPLINK=https://github.com/WowUp/WowUp/releases/download/v2.9.0/WowUp-2.9.0.AppImage
    WOWUPBINARY=WowUp-2.9.0.AppImage
    mkdir /home/$USER/Downloads/wowup 
    cd /home/$USER/Downloads/wowup 
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
    sudo mv /home/$USER/Downloads/wowup /opt/wowup
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
        setup_wine_repo
        install_wine
    elif [ $input -eq 3 ]
    then
        install_bottles
        install_lutris
    elif [ $input -eq 4 ]
    then
        install_wowup
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
