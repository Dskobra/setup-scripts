#!/usr/bin/bash

suse_menu(){
    echo "        ----------------"
    echo "        |   openSUSE   |"
    echo "        ----------------"
    echo ""
    echo "                 Menu"
    echo ""
    echo "(1) Packman Essentials     (2) Setup Flatpak"
    echo "(3) Hardware               (4) Desktop Plugins"      
    echo "(5) Internet               (6) Multimedia"
    echo "(7) Gaming                 (8) Office"
    echo "(9) Coding                 (10) Utilities"
    echo "(11) Extras"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)  
            source $SCRIPTS_HOME/modules/packages/3rd_party_repos.conf
            sudo $PKGMGR ar -cfp 90 $OPENSUSE_PACKMAN_ESSENTIALS packman-essentials
            sudo $PKGMGR dup --from packman-essentials --allow-vendor-change
            suse_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_flatpak"
            suse_menu
            ;;

        3)
            hardware_menu
            suse_menu
            ;;

        4)
            desktop_plugins_menu
            suse_menu
            ;;

        5)
            internet_menu
            suse_menu
            ;;

        6)
            multimedia_menu
            suse_menu
            ;;

        7)
            gaming_menu
            suse_menu
            ;;

        8)
            office_menu
            suse_menu
            ;;
        9)
            #coding_menu
            echo "This menu is disabled atm"
            suse_menu
            ;;

        10)
            #utils_menu
            echo "This menu is disabled atm"
            suse_menu
            ;;

        11)
            #extras_menu
            echo "This menu is disabled atm"
            suse_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            suse_menu
            ;;

        esac
        unset input
        fedora_menu
}

hardware_menu(){
    echo "              ---------------"
    echo "              |   Drivers   |"
    echo "              ---------------"
    echo ""
    echo "AMD/Nvidia drivers"
    echo ""
    echo "                Menu"     
    echo "(1) Corectrl(amd)       (2) Nvidia Driver"
    echo "(3) Cheese(gtk)         (4) Kamoso(Qt)"
    echo "(h) Help"
    echo "(m) Main Menu           (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/packages/3rd_party_repos.conf
            sudo $PKGMGR addrepo $OPENSUSE_CORECTRL
            sudo $PKGMGR refresh
            sudo $PKGMGR -n install corectrl
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/hardware#amd-cpus-andor-gpus-with-corectrl
            hardware_menu
            ;;

        2)
            sudo $PKGMGR addrepo --refresh $OPENSUSE_NVIDIA NVIDIA
            sudo $PKGMGR install-new-recommends --repo NVIDIA
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/hardware#nvidia
            hardware_menu
            ;;
        3)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_cheese"
            hardware_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_kamoso"
            hardware_menu
            ;;
        
        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/hardware
            hardware_menu
            ;;

        H)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/hardware
            hardware_menu
            ;;

        m)
            suse_menu
            ;;
            
        M)
            suse_menu
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            hardware_menu
            ;;
            
        esac
        unset input
        hardware_menu
}

desktop_plugins_menu(){
    echo "              ------------------------"
    echo "              |   Desktop Plugins    |"
    echo "              ------------------------"
    echo ""
    echo "Extra plugins and misc stuff for specific desktops"
    echo ""
    echo "                Menu"
    echo "(1) KDE                (2) XFCE"
    echo "(3) Mate               (h) Help"     
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_kdeapps"
            ;;
        
        2)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_xfce_apps"
            ;;

        3)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_mate_apps"
            ;;

        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            kde_features_menu
            ;;

        H)  
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Desktop-Features
            kde_features_menu
            ;;

        m)
            suse_menu
            ;;

        M)
            suse_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            desktop_plugins_menu
            ;;
            
        esac
        unset input
        desktop_plugins_menu
}

internet_menu(){
    echo "              ---------------------"
    echo "              |   Internet Apps   |"
    echo "              --------------------"
    echo ""
    echo "Web browser, cloud storage and bitorrent client."
    echo ""
    echo "                   Menu"
    echo "(1) Firefox                (2) Brave Browser"
    echo "(3) Dropbox                (4) Transmissionbt"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_firefox"
            internet_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_brave_browser"
            internet_menu
            ;;
        
        3)
            source $SCRIPTS_HOME/modules/packages/internet_apps.conf
            flatpak install --user -y $FLATPAK_DROPBOX
            internet_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/packages/internet_apps.conf
            flatpak install --user -y  $FLATPAK_TRANSMISSION
            internet_menu
            ;;

        m)
            suse_menu
            ;;

        M)
            suse_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            internet_menu
            ;;
            
        esac
        unset input
        internet_menu
}

multimedia_menu(){
    echo "              -----------------------"
    echo "              |   Multimedia Apps   |"
    echo "              -----------------------"
    echo ""
    echo "Various multimedia apps, codecs etc."
    echo ""
    echo "                   Menu"
    echo "(1) Codecs                (2) VLC Media Player" 
    echo "(3) OBS Studio            (4) OpenShot" 
    echo "(5) K3b                   (6) Kolourpaint"
    echo "(m) Main Menu             (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_codecs"
            multimedia_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/packages/multimedia_apps.conf
            flatpak install --user -y $FLATPAK_VLC
            multimedia_menu
            ;;
        
        3)
            source $SCRIPTS_HOME/modules/packages/multimedia_apps.conf
            flatpak install --user -y $FLATPAK_OBS
            multimedia_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_openshot"
            multimedia_menu
            ;;

        5)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_kthreeb"
            multimedia_menu
            ;;

        6)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_kolourpaint"
            multimedia_menu
            ;;
        
        m)
            suse_menu
            ;;
        
        M)
            suse_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            multimedia_menu
            ;;
            
        esac
        unset input
        multimedia_menu
}

gaming_menu(){
    echo "              -------------------"
    echo "              |   Gaming Apps   |"
    echo "              -------------------"
    echo ""
    echo "Steam, lutris and other game related apps/games."
    echo ""
    echo "                Menu"
    echo "(1) Steam                  (2) Lutris"
    echo "(3) Mangohud               (4) Protontricks"
    echo "(5) ProtonUp Qt            (6) Discord"
    echo "(7) Solitare               (8) Minecraft"
    echo "(9) WoWUp"
    echo "(m) Main Menu              (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)  
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_steam"
            sudo modprobe xpad
            ;;

        2)
            source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
            mkdir "$HOME"/Games
            mkdir "$HOME"/.config/MangoHud/
            
            flatpak install --user -y $FLATPAK_LUTRIS
            flatpak run net.lutris.Lutris
            ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
            ;;

        3)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_mangohud"
            gaming_menu
            ;;

        4)
            source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
            flatpak install --user -y $FLATPAK_PROTONTRICKS
            ;;
        
        5)
            source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
            flatpak install --user -y $FLATPAK_PROTONUP
            ;;

        6)
            source $SCRIPTS_HOME/modules/packages/gaming_apps.conf
            flatpak install --user -y $FLATPAK_DISCORD
            ;;

        7)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_kpat"
            ;;
        
        8)
            source $SCRIPTS_HOME/modules/shared.sh; "minecraft"
            ;;

        9)
            source $SCRIPTS_HOME/modules/shared.sh; "wowup"
            ;;


        m)
            suse_menu
            ;;

        M)
            suse_menu
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            gaming_menu
            ;;
            
        esac
        unset input
        gaming_menu
}

office_menu(){
    echo "              -------------------"
    echo "              |   Office Apps   |"
    echo "              -------------------"
    echo ""
    echo "Office and note taking apps."
    echo ""
    echo "                Menu"
    echo "(1) QOwnNotes          (2) Libreoffice"
    echo "(3) Abiword            (4) Gnumeric"
    echo "(5) KDE Okular         (6) Gnome Evince"
    echo "(7) KDE Ark            (8) Gnome File Roller"
    echo "(9) Claws-Mail         (10) Thunderbird"         
    echo "(m) Main Menu          (0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/packages/office_apps.conf
            flatpak install --user -y $FLATPAK_QOWNNOTES
            office_menu
            ;;

        2)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "remove_office"
            source $SCRIPTS_HOME/modules/packages/office_apps.conf
            flatpak install --user -y $FLATPAK_LIBREOFFICE
            office_menu
            ;;

        3)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_abiword"
            office_menu
            ;;
        
        4)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_gnumeric"
            office_menu
            ;;

        5)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_okular"
            office_menu
            ;;

        6)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_evince"
            office_menu
            ;;
        
        7)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_kde_ark"
            office_menu
            ;;

        8)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_file_roller"
            office_menu
            ;;

        9)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_claws_mail"
            office_menu
            ;;
        
        10)
            source $SCRIPTS_HOME/modules/opensuse/opensuse_packages.sh; "install_thunderbird"
            office_menu
            ;;
        
        99) 
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Office-Apps
            ;;

        m)
            fedora_menu
            ;;

        M)
            fedora_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            office_menu
            ;;
            
        esac
        unset input
        office_menu
}

old_suse_menu(){
    echo "================================================"
    echo "openSUSE (tumbleweed)"
    echo "1. Setup DE 2. Gaming"
    echo "3. Dev Tools 4. Extras"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    case $input in

        1)
        install_basic_apps
        ;;

        2)
        install_game_clients
        source $SCRIPTS_HOME/modules/shared.sh; "game_profiles"
        ;;

        3)
        install_dev_tools
        ;;

        4)
        extras_menu
        ;;

        0)
        exit
        ;;

    *)
        echo -n "Unknown entry"
        echo ""
        launch_menu
        ;;
    esac
    unset input
    suse_menu
}

old_install_basic_apps(){
	echo "Setting up packman essentials and brave browser"
    sudo zypper ar -cfp 90 https://ftp.fau.de/packman/suse/openSUSE_Tumbleweed/Essentials packman-essentials    # using essentials for ffmpeg etc
    sudo zypper dup -y --from packman-essentials --allow-vendor-change     # update system packages with essentials

    sudo zypper install curl
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

	sudo zypper install -y konsole kate ark discover dolphin-plugins \
    mozilla-openh264 gstreamer-plugin-openh264 p7zip-full java-17-openjdk\
    brave-browser plymouth-theme-spinfinity
       
	sudo plymouth-set-default-theme spinfinity -R

    pull_shared_code

    bash -c "source "$SCRIPTS_HOME"/modules/shared.sh; fbasic"
    bash -c "source $SCRIPTS_HOME/modules/shared.sh; futils"

}

old_install_game_clients(){
    mkdir "$HOME"/Games
	mkdir "$HOME"/Games/bottles
    mkdir "$HOME"/.config/MangoHud/
    sudo zypper install -y steam goverlay gamescope gamemode
    sudo modprobe xpad


    source $SCRIPTS_HOME/modules/shared.sh; "fgames"
    source $SCRIPTS_HOME/modules/shared.sh; "wowup"
    source $SCRIPTS_HOME/modules/shared.sh; "minecraft"
    
}

old_install_dev_tools(){
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
}

old_extras_menu(){
    echo "================================================"
    echo "Extras"
    echo "1. Virtualization 2. Corectrl"
    echo "3. Extra Apps 4. Cleanup"
    echo "5. Autostarts"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    case $input in

        1)
            echo "Use Yast -> "Virtualization" -> "Install Hypervisor and Tools" to install"
            ;;

        2)
            sudo zypper addrepo https://download.opensuse.org/repositories/home:Dead_Mozay/openSUSE_Tumbleweed/home:Dead_Mozay.repo
            sudo zypper refresh
            sudo zypper install -y corectrl
            ;;
        3)
            sudo zypper install -y k3b v4l2loopback-autoload
            flatpak --user remote-add --if-not-exists kde-applications https://raw.githubusercontent.com/KDE/flatpak-kde-applications/master/kdeapps.flatpakrepo
            latpak --user install -y org.kde.xwaylandvideobridge
            cp /home/$USER/.local/share/flatpak/exports/share/applications/org.kde.xwaylandvideobridge.desktop /home/$USER/.config/autostart/org.kde.xwaylandvideobridge.desktop
            bash -c "source $SCRIPTS_HOME/modules/shared.sh; fmedia"
            bash -c "source $SCRIPTS_HOME/modules/shared.sh; fextras"
            ;;
        4)
            cleanup
            ;;

        5)
            autostart
            ;;

        
        9)
            suse_menu
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            extras_menu
            ;;

        esac
        unset input
        extras_menu
}

old_autostart(){
    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
    cp /home/$USER/.local/share/flatpak/exports/share/applications/com.dropbox.Client.desktop /home/$USER/.config/autostart/com.dropbox.Client.desktop
    DISCORD="/home/$USER/.local/share/flatpak/exports/share/applications/com.discordapp.Discord.desktop"
    STEAM="/usr/share/applications/steam.desktop"
    CORECTRL="/usr/share/applications/org.corectrl.corectrl.desktop"
    XWVIDEO_BRIDGE="/usr/share/applications/org.kde.xwaylandvideobridge.desktop"

    [ -f $DISCORD ] && { echo "Discord was found. Adding to startup."; cp "$DISCORD"  /home/$USER/.config/autostart/com.discordapp.Discord.desktop; }
    [ -f $STEAM ] && { echo "Steam was found. Adding to startup."; cp "$STEAM"  /home/$USER/.config/autostart/steam.desktop; }
    [ -f $CORECTRL ] && { echo "Corectrl was found. Adding to startup."; cp "$CORECTRL"  /home/$USER/.config/autostart/org.corectrl.corectrl.desktop; }
    [ -f $XWVIDEO_BRIDGE ] && { echo "XWaylandVideoBridge was found. Adding to startup."; cp "$XWVIDEO_BRIDGE"  /home/$USER/.config/autostart/org.kde.xwaylandvideobridge.desktop; }
}

old_cleanup(){
    sudo zypper remove -y icewm
}

pull_shared_code(){
    cd $SCRIPTS_HOME/temp
    git clone https://github.com/Dskobra/setup-scripts
    cd setup-scripts/modules
    chmod +x shared.sh
    mv shared.sh $SCRIPTS_HOME/modules
}

variant_check(){
    test -f /run/ostree-booted && VARIANT=ostree
    if [ ! -n "$VARIANT" ]
    then
        PKGMGR="zypper"
        echo "openSUSE detected."
        echo "Setting package manager to $PKGMGR."
        #sudo $PKGMGR clean all && sudo $PKGMGR update -y
    elif [ $VARIANT == "ostree" ]
    then
        PKGMGR="rpm-ostree"
        ### Possibly reuse this for next openSUSE leap
        # that will be immutable
        #echo "openSUSE spin detected as immutable"
        #echo "Setting package manager to $PKGMGR."
        #echo "Please note this is experimental atm"
        #sudo $PKGMGR refresh-md
    fi
}

export VARIANT=""
export PKGMGR="zypper"
variant_check
suse_menu
