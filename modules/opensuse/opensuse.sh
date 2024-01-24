#!/usr/bin/bash

suse_menu(){
    echo "        ----------------"
    echo "        |   openSUSE   |"
    echo "        ----------------"
    echo ""
    echo "                 Menu"
    echo ""
    echo "(1) Packman Essentials     (2) Setup Flatpak"
    echo "(3) Drivers                (4) Desktop Features"      
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
            drivers_menu
            #check_if_immutable
            suse_menu
            ;;

        4)
            desktop_features_menu
            #check_if_immutable
            echo "This menu is disabled atm"
            suse_menu
            ;;

        5)
            #internet_menu
            echo "This menu is disabled atm"
            suse_menu
            ;;

        6)
            #multimedia_menu
            echo "This menu is disabled atm"
            suse_menu
            ;;

        7)
            #gaming_menu
            echo "This menu is disabled atm"
            suse_menu
            ;;

        8)
            #office_menu
            echo "This menu is disabled atm"
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

drivers_menu(){
    echo "              ---------------"
    echo "              |   Drivers   |"
    echo "              ---------------"
    echo ""
    echo "AMD/Nvidia drivers"
    echo ""
    echo "                Menu"     
    echo "(1) Corectrl(amd)       (2) Nvidia Driver"
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
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Drivers#amd-cpus-andor-gpus-with-corectrl
            #check_if_immutable
            drivers_menu
            ;;

        2)
            sudo $PKGMGR addrepo --refresh $OPENSUSE_NVIDIA NVIDIA
            sudo $PKGMGR install-new-recommends --repo NVIDIA
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Drivers#nvidia
            #check_if_immutable
            drivers_menu
            ;;
        
        h)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Drivers
            drivers_menu
            ;;

        H)
            xdg-open https://github.com/Dskobra/setup-scripts/wiki/Drivers
            drivers_menu
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
            drivers_menu
            ;;
            
        esac
        unset input
        drivers_menu
}

desktop_features_menu(){
    echo "              ------------------------"
    echo "              |   Desktop Features   |"
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
            kde_features_menu
            ;;
        
        2)
            xfce_features_menu
            ;;

        3)
            mate_features_menu
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
            desktop_features_menu
            ;;
            
        esac
        unset input
        desktop_features_menu
}

kde_features_menu(){
    echo "              -----------"
    echo "              |   KDE   |"
    echo "              -----------"
    echo ""
    echo "Extra apps and plugins for KDE"
    echo ""
    echo "                Menu"
    echo "(1) KDE Applications   (2) KDE Email/Contacts"
    echo "(3) KDE Multimedia "     
    echo "(p) Previous Menu      (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            source $SCRIPTS_HOME/modules/fedora/opensuse_packages.sh; "install_kdeapps"
            kde_features_menu
            ;;
        
        2)

            echo "Disabled atm"
            #source $SCRIPTS_HOME/modules/fedora/opensuse_packages.sh; "install_kdeemail"
            kde_features_menu
            ;;

        3)
            echo "Disabled atm"
            #source $SCRIPTS_HOME/modules/fedora/opensuse_packages.sh; "install_kdemm"
            kde_features_menu
            ;;

        p)
            desktop_features_menu
            ;;
        P)
            desktop_features_menu
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
            kde_features_menu
            ;;
            
        esac
        unset input
        kde_features_menu
}

xfce_features_menu(){
    echo "              ------------"
    echo "              |   XFCE   |"
    echo "              ------------"
    echo ""
    echo "Extra apps and plugins for XFCE"
    echo ""
    echo "                Menu"
    echo "(1) XFCE Applications  (2) XFCE Plugins"
    echo "(3) XFCE Multimedia"        
    echo "(p) Previous Menu      (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            echo "Disabled atm"
            #source $SCRIPTS_HOME/modules/fedora/opensuse_packages.sh; "install_xfce_apps"
            xfce_features_menu
            ;;
        
        2)

            #source $SCRIPTS_HOME/modules/fedora/opensuse_packages.sh; "install_xfce_plugins"
            xfce_features_menu
            ;;

        3)
            #source $SCRIPTS_HOME/modules/fedora/opensuse_packages.sh; "install_xfcemm"
            xfce_features_menu
            ;;


        p)
            desktop_features_menu
            ;;
        
        P)
            desktop_features_menu
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
            xfce_features_menu
            ;;
            
        esac
        unset input
        xfce_features_menu
}

mate_features_menu(){
    echo "              ------------"
    echo "              |   Mate   |"
    echo "              ------------"
    echo ""
    echo "Extra apps and plugins for Mate"
    echo ""
    echo "                Menu"
    echo "(1) Mate Applications (2) Compiz"      
    echo "(p) Previous Menu     (m) Main Menu"
    echo "(0) Exit"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            echo "Disabled atm"
            #source $SCRIPTS_HOME/modules/fedora/opensuse_packages.sh; "install_mate_apps"
            mate_features_menu
            ;;
        
        2)

            #source $SCRIPTS_HOME/modules/fedora/opensuse_packages.sh; "install_compiz"
            mate_features_menu
            ;;

        3)
            
            mate_features_menu
            ;;


        p)
            desktop_features_menu
            ;;

        P)
            desktop_features_menu
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
            mate_features_menu
            ;;
            
        esac
        unset input
        mate_features_menu
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
