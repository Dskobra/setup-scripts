#!/usr/bin/bash

main_menu(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Setup DE 2. Gaming"
    echo "3. Coding/Servers 4. Extras" 
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        get_fedora_version
        install_basic_apps
        get_desktop_extras
    elif [ "$input" -eq 2 ]
    then
        install_game_clients
        mango
    elif [ "$input" -eq 3 ]
    then
        coding_servers_menu
    elif [ "$input" -eq 4 ]
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
    echo $input
    unset input
    coding_servers_menu
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
        extra_apps
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

extra_apps(){
    
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

install_basic_apps(){
	echo "Setting up rpmfusion and flathub."
    flatpak remote-modify --disable fedora
    if [ "$fedoraVersion" = "38" ]
    then
        #echo "Fedora Version: $fedoraVersion includes flathub, but disabled by default."
        #flatpak remote-modify --enable flathub
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	elif [ "$fedoraVersion" = "37" ]
	then
		echo "Fedora Version: $fedoraVersion which requires adding remote flathub."
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    else
        echo "Unknown error has occured"
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

get_desktop_extras(){
	if [ "$DESKTOP" = "MATE" ]
	then
		echo "Now setting up some extra mate features."
		sudo dnf install -y caja-share mate-menu \
        dconf-editor humanity-icon-theme \
        gnome-icon-theme pavucontrol
    else
        echo "Not running Mate."
	fi
}

install_coding_tools(){
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

install_game_clients(){
    mkdir "$HOME"/Games
	mkdir "$HOME"/Games/bottles
    mkdir "$HOME"/.config/MangoHud/
    sudo dnf install -y mangohud steam goverlay
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

    WOWUPLINK=https://github.com/WowUp/WowUp.CF/releases/download/v2.9.4-beta.3/WowUp-CF-2.9.4-beta.3.AppImage
    WOWUPBINARY=WowUp-CF-2.9.4-beta.3.AppImage
    cd "$HOME"/Desktop
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
    
}

mango(){
    # link bottles/lutris to mangohud configuration folder
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/com.usebottles.bottles/config/"
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
    USER=$(whoami)
    cd $SCRIPTS_HOME/mangohud
    sudo chown $USER:$USER *.conf
    cp wine-GTA5.conf $HOME/.config/MangoHud/
    cp wine-NewWorld.conf $HOME/.config/MangoHud/
    cp wine-PathOfExile_x64Steam.conf $HOME/.config/MangoHud/
    cp wine-R5Apex.conf $HOME/.config/MangoHud/
    cp wine-RuneScape.conf $HOME/.config/MangoHud/
    cp wine-WorldOfTanks.conf $HOME/.config/MangoHud/
    cp wine-WorldOfWarships.conf $HOME/.config/MangoHud/
    cp wine-Gw2-64.conf $HOME/.config/MangoHud/
    cp wine-WoW.conf $HOME/.config/MangoHud/
    cp "wine-Diablo IV.conf" $HOME/.config/MangoHud/
    
}

get_fedora_version(){
    source /etc/os-release
	fedoraVersion=$(echo $VERSION_ID)
	echo "Fedora Version:" $fedoraVersion
}

cleanup(){
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

SCRIPTS_HOME=$(pwd)
DESKTOP=$XDG_CURRENT_DESKTOP
$fedoraVersion
main_menu
