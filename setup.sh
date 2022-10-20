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

install_game_clients(){
    mkdir /home/$USER/Games
	mkdir /home/$USER/Games/bottles
    sudo dnf install -y mangohud gamemode gamemode.i686 steam steam-devices
	flatpak install -y flathub net.davidotek.pupgui2
	flatpak install -y flathub com.usebottles.bottles
    flatpak install -y flathub net.lutris.Lutris
    flatpak install -y org.freedesktop.Platform.VulkanLayer.MangoHud


}

install_wine(){
    echo "================================================"
	echo "This will now install wine and many libraries"
    echo "for as much a complete experience as possible"
    echo "for running Windows games."
    echo "================================================"

    sudo dnf install -y alsa-plugins-pulseaudio.i686 glibc-devel.i686 glibc-devel libgcc.i686 libX11-devel.i686 freetype-devel.i686\
    libXcursor-devel.i686 libXi-devel.i686 libXext-devel.i686 libXxf86vm-devel.i686 libXrandr-devel.i686 libXinerama-devel.i686 \
    mesa-libGLU-devel.i686 mesa-libOSMesa-devel.i686 libXrender-devel.i686 libpcap-devel.i686 ncurses-devel.i686 libzip-devel.i686 \
    lcms2-devel.i686 zlib-devel.i686 libv4l-devel.i686 libgphoto2-devel.i686 cups-devel.i686 libxml2-devel.i686 openldap-devel.i686 \
    
    sudo dnf install -y libxslt-devel.i686 gnutls-devel.i686 libpng-devel.i686 flac-libs.i686 json-c.i686 libICE.i686 libSM.i686 \
    libXtst.i686 libasyncns.i686 libedit.i686 liberation-narrow-fonts.noarch libieee1284.i686 libogg.i686 libsndfile.i686 \
    libuuid.i686 libva.i686 libvorbis.i686 libwayland-client.i686 libwayland-server.i686 llvm-libs.i686 \
    mesa-dri-drivers.i686 mesa-filesystem.i686 mesa-libEGL.i686 mesa-libgbm.i686 nss-mdns.i686 ocl-icd.i686 \
    pulseaudio-libs.i686  sane-backends-libs.i686 tcp_wrappers-libs.i686 unixODBC.i686 samba-common-tools.x86_64 samba-libs.x86_64 \
    samba-winbind.x86_64 samba-winbind-clients.x86_64 samba-winbind-modules.x86_64 mesa-libGL-devel.i686 fontconfig-devel.i686 \
    libXcomposite-devel.i686
    
    sudo dnf install -y libtiff-devel.i686 openal-soft-devel.i686 mesa-libOpenCL-devel.i686 opencl-utils-devel.i686 \
    alsa-lib-devel.i686 gsm-devel.i686 libjpeg-turbo-devel.i686 pulseaudio-libs-devel.i686 pulseaudio-libs-devel gtk3-devel.i686 \
    libattr-devel.i686 libva-devel.i686 libexif-devel.i686 libexif.i686 glib2-devel.i686 mpg123-devel.i686 mpg123-devel.x86_64 \
    libcom_err-devel.i686 libcom_err-devel.x86_64 libFAudio-devel.i686 libFAudio-devel.x86_64 gnutls.i686 gnutls-devel openldap \
    openldap.i686 openldap-devel libgpg-error libgpg-error.i686 sqlite2.i686 sqlite2.x86_64 pipewire-devel.i686 \
    pipewire-devel.x86_64 gstreamer1-plugin-libav.i686 gstreamer1-plugin-libav.x86_64 freetype.i686 gnutls.i686 openldap.i686 \
    libgpg-error.i686 sqlite2.i686 pulseaudio-libs.i686 dxvk-native-devel.x86_64 dxvk-native-devel.i686 vulkan-tools

    sudo dnf install -y SDL2.i686 SDL2.x86_64 SDL2_net.x86_64 alsa-lib.i686 avahi-libs.i686 bzip2-libs.i686 cairo.i686 \
    cairo-gobject.i686 cdparanoia-libs.i686 cups-libs.i686 cyrus-sasl-lib.i686 dbus-libs.i686 elfutils-debuginfod-client.i686 \
    elfutils-libelf.i686 elfutils-libs.i686 expat.i686 flac-libs.i686 fluid-soundfont-common.noarch fluid-soundfont-gm.noarch
    
    sudo dnf install -y fluidsynth-libs.x86_64 fontconfig.i686 freetype.i686 fribidi.i686 gd.i686 gdbm-libs.i686 gdk-pixbuf2.i686 \
    glib2.i686 glibc.i686 glibc-gconv-extra.i686 gmp.i686 gnutls.i686 graphene.i686 graphite2.i686 gsm.i686 gstreamer1.i686 \
    gstreamer1-plugins-base.i686 gstreamer1-plugins-good.i686 harfbuzz.i686 isl.x86_64 jbigkit-libs.i686 keyutils-libs.i686          

    sudo dnf install -y krb5-libs.i686 lame-libs.i686 libX11.i686 libX11-xcb.i686 libXau.i686 libXcomposite.i686 libXcursor.i686 \
    libXdamage.i686 libXext.i686 libXfixes.i686 libXft.i686 libXinerama.i686 libXpm.i686 libXrandr.i686 libXrender.i686 libXv.i686 \
    libXxf86vm.i686 libaom.i686 libasyncns.i686 libavif.i686 libblkid.i686 libbrotli.i686 libcap.i686 libcom_err.i686 \
    libcurl.i686 libdatrie.i686 libdav1d.i686 libdecor.i686 libdecor.x86_64 libdrm.i686 libedit.i686


    sudo dnf install -y liberation-narrow-fonts.noarch libevent.i686 libexif.i686 libffi.i686 libgcc.i686 libgcrypt.i686 libglvnd.i686 \
    libglvnd-egl.i686 libglvnd-glx.i686 libgomp.i686 libgpg-error.i686 libgphoto2.i686 libgudev.i686 libibverbs.i686 \
    libidn2.i686 libieee1284.i686 libimagequant.i686 libinstpatch.x86_64 libjpeg-turbo.i686 libjxl.i686 libkadm5.x86_64 \
    libmount.i686 libnghttp2.i686 libnl3.i686 libogg.i686 libpcap.i686 libpciaccess.i686 libpng.i686 libpsl.i686 \
    libselinux.i686 libsepol.i686 libshout.i686 libslirp.x86_64 libsndfile.i686 libssh.i686 libstdc++.i686 libtasn1.i686
    
    sudo dnf install -y libthai.i686 libtheora.i686 libtiff.i686 libtool-ltdl.i686 libunistring.i686 libunwind.i686 libusb1.i686 libuuid.i686 \
    libv4l.i686 libva.i686 libverto.i686 libvisual.i686 libvorbis.i686 libvpx.i686 libwayland-client.i686 \
    libwayland-cursor.i686 libwayland-egl.i686 libwayland-server.i686 libwebp.i686 libxcb.i686 libxcrypt.i686 libxml2.i686 \
    libxshmfence.i686 libzstd.i686 llvm-libs.i686 lmdb.x86_64 lockdev.i686 lz4-libs.i686 mesa-dri-drivers.i686 \
    mesa-filesystem.i686 mesa-libEGL.i686 mesa-libGL.i686 mesa-libOSMesa.i686 mesa-libOSMesa.x86_64 mesa-libgbm.i686
    
    sudo dnf install -y mesa-libglapi.i686 mesa-vulkan-drivers.i686 mingw-binutils-generic.x86_64 mingw-filesystem-base.noarch \
    mingw32-binutils.x86_64 mingw32-cpp.x86_64 mingw32-crt.noarch mingw32-filesystem.noarch mingw32-gcc.x86_64 \
    mingw32-headers.noarch mingw32-lcms2.noarch mingw32-libpng.noarch mingw32-libxml2.noarch mingw32-libxslt.noarch \
    mingw32-vkd3d.noarch mingw32-win-iconv.noarch mingw32-winpthreads.noarch mingw32-zlib.noarch mingw64-binutils.x86_64 \
    mingw64-cpp.x86_64 mingw64-crt.noarch mingw64-filesystem.noarch mingw64-gcc.x86_64 mingw64-headers.noarch \
    mingw64-lcms2.noarch mingw64-libpng.noarch mingw64-libxml2.noarch mingw64-libxslt.noarch mingw64-vkd3d.noarch
    
    sudo dnf install -y mingw64-win-iconv.noarch mingw64-winpthreads.noarch mingw64-zlib.noarch mpg123-libs.i686 mt32emu.x86_64 \
    ncurses-libs.i686 nettle.i686 nss-mdns.i686 ocl-icd.i686 ocl-icd.x86_64 openal-soft.i686 openal-soft.x86_64 \
    openldap.i686 openssl-libs.i686 openssl-pkcs11.i686 opus.i686 orc.i686 p11-kit.i686 pango.i686 pcre.i686 \
    pcre2.i686 pixman.i686 pulseaudio-libs.i686 python3-dns.noarch python3-ldb.x86_64 python3-samba.x86_64 
    
    sudo dnf install -y python3-samba-dc.x86_64 python3-talloc.x86_64 python3-tdb.x86_64 python3-tevent.x86_64 rav1e-libs.i686  \
    readline.i686 samba.x86_64 samba-common-tools.x86_64 samba-dc-libs.x86_64 samba-libs.x86_64 \
    samba-winbind.x86_64 samba-winbind-clients.x86_64 samba-winbind-modules.x86_64 \
    sane-backends-drivers-cameras.i686 sane-backends-drivers-scanners.i686  sane-backends-libs.i686 \
    speex.i686 systemd-libs.i686 taglib.i686 tdb-tools.x86_64 twolame-libs.i686 unixODBC.i686 unixODBC.x86_64  \
    vulkan-loader.i686 vulkan-tools.x86_64 wavpack.i686 xz-libs.i686 zlib.i686        
    
    sudo dnf install -y winehq-staging
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
    echo "1. Game Clients 2. Wine"
    echo "3. WoW Up 4. Minecraft "
    echo "5. Controller Setup"
    echo "99. Help 0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input -eq 1 ]
    then
        install_game_clients
    elif [ $input -eq 2 ]
    then
        #setup_wine_repo
        #install_wine
        echo "Disabled atm"
    elif [ $input -eq 3 ]
    then
        install_wowup
    elif [ $input -eq 4 ]
    then
        flatpak -y install flathub com.mojang.Minecraft
    elif [ $input -eq 5 ]
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
    VERSION=10.5.2022.3.20am
    echo "================================================"
    echo "Copyright (c) 2022 Jordan Bottoms"
    echo "Released under the MIT license"
    echo "Version: $VERSION"
    echo "================================================"
    main_menu
}

USER=$(whoami)
main_menu
