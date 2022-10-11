#/usr/bin/bash



help(){
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
        help
    elif [ $input -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    games_menu
}

office_menu(){
    echo "1. LibreOffice/QOwnNotes 2. Social Apps (messengers etc)"
    echo "3. HP Printer Drivers"
    echo "99. Help 0. Back to main menu"
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
        help
    elif [ $input -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    office_menu
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
        #./install/lamp.sh
        sudo dnf install -y httpd php mariadb mariadb-server
	    sudo dnf install -y phpmyadmin
	    sudo systemctl enable --now httpd mariadb
    elif [ $input -eq 2 ]
    then
        #./install/cockpit.sh
        sudo dnf install -y cockpit
	    sudo systemctl enable --now cockpit.socket
	    sudo firewall-cmd --add-service=cockpit
	    sudo firewall-cmd --add-service=cockpit --permanent
    elif [ $input -eq 3 ]
    then
        ./install/samba_share.sh
    elif [ $input -eq 99 ]
    then
        help
    elif [ $input -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    servers_menu
}

main_menu(){
    echo "================================================"
    echo "1. Repos 2. AMD Fan Control"
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
        ./install/repos.sh
    elif [ $input -eq 2 ]
    then
        sudo dnf install -y radeon-profile
	    sudo systemctl enable radeon-profile-daemon.service
	    sudo systemctl start radeon-profile-daemon.service
    elif [ $input -eq 3 ]
    then
        ./install/basic_apps.sh
        ./install/de.sh
    elif [ $input -eq 4 ]
    then
        sudo dnf install -y gstreamer1-plugin-openh264 \
	    mozilla-openh264 ffmpeg
	    flatpak install -y flathub org.videolan.VLC
    elif [ $input -eq 5 ]
    then
        ./menus/office.sh
    elif [ $input -eq 6 ]
    then
        sudo dnf install -y kolourpaint
	    flatpak install -y flathub com.obsproject.Studio
	    flatpak install -y flathub org.openshot.OpenShot
    elif [ $input -eq 7 ]
    then
        ./install/coding_tools.sh
    elif [ $input -eq 8 ]
    then
        games_menu
    elif [ $input -eq 9 ]
    then
        ./menus/servers.sh
    elif [ $input -eq 10 ]
    then
        ./install/utilities.sh
    elif [ $input -eq 11 ]
    then
        #./install/virtualization.sh
        sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
        -O /etc/yum.repos.d/virtio-win.repo
	    sudo dnf install -y	virt-manager libvirt-client virtio-win
    elif [ $input -eq 99 ]
    then
        help
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
