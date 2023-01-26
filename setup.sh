#!/usr/bin/bash

main_menu(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Setup DE 2. Media" 
    echo "3. Office 4.Coding/Servers"
    echo "5. Gaming 6. Extras"
    echo "100. About script"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        install_basic_apps
        get_desktop_extras
    elif [ "$input" -eq 2 ]
    then
        media_menu
    elif [ "$input" -eq 3 ]
    then
        office_menu
    elif [ "$input" -eq 4 ]
    then
        coding_servers_menu
    elif [ "$input" -eq 5 ]
    then
        gaming_menu
    elif [ "$input" -eq 6 ]
    then
        extras_menu
    elif [ "$input" -eq 100 ]
    then
        about
    elif [ "$input" -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    main_menu
}

media_menu(){
    echo "================================================"
    echo "Media"
    echo "1. Codecs/Playback 2. Editing Tools"
    echo "3. OBS Studio"
    echo "0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
        sudo dnf install -y gstreamer1-plugin-openh264 \
	    mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs
	    flatpak install -y flathub org.videolan.VLC
    elif [ "$input" -eq 2 ]
    then
        av_editing
    elif [ "$input" -eq 3 ]
    then
        flatpak install -y flathub com.obsproject.Studio
        # needed to use obs virtual camera and
        # to share screen (games appear to work fine)
        # in discord under wayland
        sudo dnf install -y v4l2loopback    
    elif [ "$input" -eq 0 ]
    then
        main_menu
    else
        echo "error."
    fi
    media_menu
}

office_menu(){
    echo "================================================"
    echo "Office"
    echo "1. LibreOffice/QOwnNotes 2. Discord/Pidgin"
    echo "3. HP Printer Drivers"
    echo "0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        flatpak install -y flathub org.libreoffice.LibreOffice
	    flatpak install -y flathub org.qownnotes.QOwnNotes
    elif [ "$input" -eq 2 ]
    then
        flatpak install -y flathub com.discordapp.Discord
	    flatpak install -y flathub im.pidgin.Pidgin
    elif [ "$input" -eq 3 ]
    then
        sudo dnf install -y hplip-gui
    elif [ "$input" -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    office_menu
}

gaming_menu(){
    echo "================================================"
    echo "Gaming"
    echo "1. Game Clients 2. WoW Up"
    echo "3. Extra Games 4. Steam Deck"
    echo "0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        install_game_clients
    elif [ "$input" -eq 2 ]
    then
        WOWUPLINK=https://github.com/WowUp/WowUp.CF/releases/download/v2.9.2-beta.9/WowUp-CF-2.9.2-beta.9.AppImage
        WOWUPBINARY=WowUp-CF-2.9.2-beta.9.AppImage
        cd "$HOME"/Desktop
        wget $WOWUPLINK
        chmod +x $WOWUPBINARY
    elif [ "$input" -eq 3 ]
    then
        install_extra_games
    elif [ "$input" -eq 4 ]
    then
        setup_deck
    elif [ "$input" -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    gaming_menu
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
	    main_menu
    else
	    echo "error."
    fi
    coding_servers_menu
}

extras_menu(){
    echo "================================================"
    echo "Extras"
    echo "1. Utilities. 2. Virtualization"
    echo "3. Corectrl 4. Install firewalld"
    echo "5. Install ufw"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        install_utilities
    elif [ "$input" -eq 2 ]
    then
        sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
        -O /etc/yum.repos.d/virtio-win.repo
        sudo dnf groupinstall -y "Virtualization"
	    sudo dnf install -y virtio-win
    elif [ "$input" -eq 3 ]
    then
        sudo dnf install -y corectrl
	    cp /usr/share/applications/org.corectrl.corectrl.desktop "$HOME"/.config/autostart/org.corectrl.corectrl.desktop
    elif [ "$input" -eq 4 ]
    then
        # if using uncomplicated firewall remove it
        sudo systemctl disable --now ufw 
        sudo dnf remove -y ufw plasma-firewall-ufw
        sudo dnf install -y firewalld firewall-applet
        sudo systemctl enable --now firewalld
    elif [ "$input" -eq 5 ]
    then
        # if using firewalld remove it. Note firewalld broke connections to wow in past.
        # remove and use ufw if something similar happens again.
        sudo systemctl disable --now firewalld
        sudo dnf remove -y firewalld firewall-applet && sudo dnf install -y ufw
        sudo systemctl enable --now ufw 
        DESKTOP=$XDG_CURRENT_DESKTOP
        if [ "$DESKTOP" = "KDE" ]
        then
            sudo dnf install -y plasma-firewall-ufw
        else
            echo "Not installing ufw plasma integration."
        fi
    elif [ "$input" -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    extras_menu
}

install_basic_apps(){
	echo "Setting up rpmfusion and flathub."
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf update -y


	sudo dnf install -y  java-17-openjdk brave-browser \
	plymouth-theme-spinfinity vim-enhanced lm_sensors \
	bluecurve-icon-theme p7zip p7zip-plugins 
    sudo dnf groupinstall -y "Firefox Web Browser"
	sudo plymouth-set-default-theme spinfinity -R
	flatpak install -y flathub org.keepassxc.KeePassXC
    flatpak install -y flathub com.transmissionbt.Transmission
    flatpak install -y flathub com.dropbox.Client
    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
}

get_desktop_extras(){
    DESKTOP=$XDG_CURRENT_DESKTOP
    if [ "$DESKTOP" = "GNOME" ]
    then
        echo "Now setting up some extra gnome features."
        sudo dnf install -y menulibre pavucontrol \
        gnome-tweaks libappindicator-gtk3 libdbusmenu-gtk3 \
        libdbusmenu openssl xarchiver humanity-icon-theme 
        flatpak install -y flathub org.gnome.Extensions
	elif [ "$DESKTOP" = "KDE" ]
	then
        echo "Now setting up some extra kde features."
		sudo dnf install -y dolphin-plugins ark \
        kate kate-plugins
	elif [ "$DESKTOP" = "MATE" ]
	then
		echo "Now setting up some extra mate features."
		sudo dnf install -y caja-share mate-menu \
        dconf-editor humanity-icon-theme \
        gnome-icon-theme pavucontrol
    else
        echo "Unknown desktop"
	fi
}

install_coding_tools(){
	sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    sudo rpm --import https://mirror.mwt.me/ghd/gpgkey
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
	sudo sh -c 'echo -e "[shiftkey]\nname=GitHub Desktop\nbaseurl=https://mirror.mwt.me/ghd/rpm\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://mirror.mwt.me/ghd/gpgkey" > /etc/yum.repos.d/shiftkey-desktop.repo'
    sudo dnf groupinstall -y "C Development Tools and libraries"
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf groupinstall -y "RPM Development Tools"
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
	sudo dnf install -y python3-tools python3-devel git-gui \
	java-17-openjdk-devel codium github-desktop

}

av_editing(){
    flatpak install -y flathub org.openshot.OpenShot
    flatpak install -y flathub org.gimp.GIMP
    flatpak install -y flathub org.kde.kolourpaint
    # prefer brasero on gnome/mate k3b on kde
    DESKTOP=$XDG_CURRENT_DESKTOP
    if [ "$DESKTOP" = "GNOME" ] || [ "$DESKTOP" = "MATE" ]
    then
        sudo dnf install -y brasero
    elif [ "$DESKTOP" = "KDE" ]
    then
        sudo dnf install -y k3b
    else
        echo "Unknown desktop"
    fi
}

install_wine(){
    source /etc/os-release
	getRelease=$(echo $VERSION_ID)
	echo "Fedora Version: $getRelease"

	if [ "$getRelease" = "36" ]
	then
		sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/36/winehq.repo
	elif [ "$getRelease" = "37" ]
	then
		sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/37/winehq.repo
	elif [ "$input" -eq 0 ]
	then
		exit
	else
		echo "error."
	fi

    sudo dnf install -y alsa-plugins-pulseaudio.i686 glibc-devel.i686 glibc-devel \
        libgcc.i686 libX11-devel.i686 freetype-devel.i686 libXcursor-devel.i686 \
        libXi-devel.i686 libXext-devel.i686 libXxf86vm-devel.i686 libXrandr-devel.i686 \
        libXinerama-devel.i686 mesa-libGLU-devel.i686 mesa-libOSMesa-devel.i686 \
        libXrender-devel.i686 libpcap-devel.i686 ncurses-devel.i686 libzip-devel.i686 \
        lcms2-devel.i686 zlib-devel.i686 libv4l-devel.i686 libgphoto2-devel.i686  \
        cups-devel.i686 libxml2-devel.i686 openldap-devel.i686 libxslt-devel.i686 gnutls-devel.i686 \
        libpng-devel.i686 flac-libs.i686 json-c.i686 libICE.i686 libSM.i686 libXtst.i686 \
        libasyncns.i686 libedit.i686 liberation-narrow-fonts.noarch libieee1284.i686 libogg.i686 \
        libsndfile.i686 libuuid.i686 libva.i686 libvorbis.i686 libwayland-client.i686 \
        libwayland-server.i686 llvm-libs.i686 mesa-dri-drivers.i686 mesa-filesystem.i686 \
        mesa-libEGL.i686 mesa-libgbm.i686 nss-mdns.i686 ocl-icd.i686 pulseaudio-libs.i686 \
        sane-backends-libs.i686 tcp_wrappers-libs.i686 unixODBC.i686 samba-common-tools.x86_64 \
        samba-libs.x86_64 samba-winbind.x86_64 samba-winbind-clients.x86_64 \
        samba-winbind-modules.x86_64 mesa-libGL-devel.i686 fontconfig-devel.i686 \
        libXcomposite-devel.i686 libtiff-devel.i686 openal-soft-devel.i686 \
        mesa-libOpenCL-devel.i686 opencl-utils-devel.i686 alsa-lib-devel.i686 gsm-devel.i686 \
        libjpeg-turbo-devel.i686 pulseaudio-libs-devel.i686 pulseaudio-libs-devel gtk3-devel.i686 \
        libattr-devel.i686 libva-devel.i686 libexif-devel.i686 libexif.i686 glib2-devel.i686 \
        mpg123-devel.i686 mpg123-devel.x86_64 libcom_err-devel.i686 libcom_err-devel.x86_64 \
        libFAudio-devel.i686 libFAudio-devel.x86_64
        sudo dnf install -y winehq-staging
}

install_game_clients(){
    mkdir "$HOME"/Games
	mkdir "$HOME"/Games/bottles
    mkdir "$HOME"/.config/MangoHud/
    sudo dnf install -y mangohud gamemode gamemode.i686 \
    steam steam-devices kernel-modules-extra
    sudo modprobe xpad
	flatpak install -y flathub net.davidotek.pupgui2

    flatpak install -y flathub com.usebottles.bottles
    flatpak run com.usebottles.bottles # run once to ensure folders/runtimes are setup

    
    #lutris/bottles store MangoHud under "$HOME"/.var/app/APPNAME/config/MangoHud/
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/com.usebottles.bottles/config/"
    DESKTOP=$XDG_CURRENT_DESKTOP
    if [ "$DESKTOP" = "GNOME" ]
    then
        install_wine
        sudo dnf install -y lutris
	elif [ "$DESKTOP" = "KDE" ]
	then
        # winetricks runs poorly on kde with kdialog throwing popups 
        # on every warning (on gnome they are hidden). flatpak lutris
        # doesnt experience this on kde.
        flatpak install -y flathub net.lutris.Lutris        
        flatpak run net.lutris.Lutris       # run once to ensure folders/runtimes are setup

        flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/21.08
        flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/22.08

        #lutris/bottles store MangoHud under "$HOME"/.var/app/APPNAME/config/MangoHud/
        ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
    else
        echo "Unknown desktop"
	fi

}

install_extra_games(){
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
}

setup_deck(){
    flatpak install -y flathub org.mozilla.firefox
    flatpak install -y flathub com.brave.Browser
    flatpak install -y flathub com.dropbox.Client
    flatpak install -y flathub org.keepassxc.KeePassXC
    flatpak install -y flathub com.discordapp.Discord
    flatpak install -y flathub net.davidotek.pupgui2
    flatpak install -y flathub net.lutris.Lutris
    flatpak install -y flathub com.github.tchx84.Flatseal
    flatpak install -y flathub org.kde.kpat
}

install_utilities(){
	sudo dnf install -y dnfdragora mediawriter
	flatpak install -y flathub org.gtkhash.gtkhash
	flatpak install -y flathub com.github.tchx84.Flatseal
    flatpak install -y flathub org.raspberrypi.rpi-imager

    DESKTOP=$XDG_CURRENT_DESKTOP
    if [ "$DESKTOP" = "GNOME" ] || [ "$DESKTOP" = "MATE" ]
    then
        flatpak install -y flathub org.kde.kleopatra
	elif [ "$DESKTOP" = "KDE" ]
	then
		sudo dnf install -y kleopatra
    else
        echo "Unknown desktop"
	fi
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
